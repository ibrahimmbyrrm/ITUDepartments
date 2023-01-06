//
//  ViewController.swift
//  ITU-Bolumler
//
//  Created by İbrahim Bayram on 5.01.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var segmentedcontrol: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var liste = [Bolumler]()
    var siralama : Float?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        copyDatabase()
        segmentedcontrol.selectedSegmentIndex = 0
        liste = Bolumlerdao().bolumleriAl()
    }
    //Veritabanı Kopyalam İşlemini Mutlaka Yapıcaz
    func copyDatabase() {
        let bundleYolu = Bundle.main.path(forResource: "bolumler", ofType: ".db")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("bolumler.db")
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("veritabanı zaten mecvut")
        }else {
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                print("kopyalandi")
            }catch {
                print(error)
            }
        }
    }
    //Veri Tabanımızı Kopyaladık
    @IBAction func segmentTiklandi(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            liste = Bolumlerdao().bolumleriAl()
        }else if sender.selectedSegmentIndex == 1 {
            liste = Bolumlerdao().ingBolumAl()
        }else if sender.selectedSegmentIndex == 2 {
            liste = Bolumlerdao().turkcebolumAl()
        }
        self.tableView.reloadData()
    }
    @IBAction func filter(_ sender: Any) {
        let alert1 = UIAlertController(title: "Sıralamanızı giriniz", message: "Sıralamanızı araya nokta koyarak giriniz.", preferredStyle: UIAlertController.Style.alert)
        alert1.addTextField { (textfield : UITextField!) in
            textfield.placeholder = "Siralama"
            
        }
        //Butona basıldığında hangi dil sekmesi seçiliyse o dildeki uygun bölümleri listeler.
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { saveaction in
            self.siralama = Float(alert1.textFields![0].text!)
            if self.segmentedcontrol.selectedSegmentIndex == 0 {
                self.liste = Bolumlerdao().filtrele(siralama: self.siralama!)
            }else if self.segmentedcontrol.selectedSegmentIndex == 1 {
                self.liste = Bolumlerdao().filtreleING(siralama: self.siralama!)
            }else if self.segmentedcontrol.selectedSegmentIndex == 2 {
                self.liste = Bolumlerdao().filtreleTR(siralama: self.siralama!)
            }
            self.tableView.reloadData()
            
        }
        alert1.addAction(okButton)
        self.present(alert1, animated: true)
        
        
    }
    //Filtreleme yaptığımız sıralamayı devre dışı bırakarak sıralama fark etmeksizin tüm bölümleri listeler.
    @IBAction func resetButton(_ sender: Any) {
        if self.siralama != 0 {
            if self.segmentedcontrol.selectedSegmentIndex == 0 {
                self.liste = Bolumlerdao().bolumleriAl()
            }else if self.segmentedcontrol.selectedSegmentIndex == 1 {
                self.liste = Bolumlerdao().ingBolumAl()
            }else if self.segmentedcontrol.selectedSegmentIndex == 2 {
                self.liste = Bolumlerdao().turkcebolumAl()
            }
            self.tableView.reloadData()
        }
    }
    
    
    
}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.bolumAdi.text = liste[indexPath.row].bolum_ad!
        cell.bolumDili.text = liste[indexPath.row].bolum_dil!
        cell.bolumSiralama.text = String(liste[indexPath.row].bolum_siralama!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert()
    }
}
extension ViewController {
    func alert() {
        let alert = UIAlertController(title: "Mükemmel bir bölüm", message: "Umarız ki istediğin bölümü kazanabilirsin.Daha fazla bilgi için İTÜ'nün yayınladığı dokümanları inceleyebilirsin", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}


