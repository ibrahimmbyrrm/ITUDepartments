//
//  ViewController.swift
//  ITU-Bolumler
//
//  Created by İbrahim Bayram on 5.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedcontrol: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var liste = [Bolumler]()
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
}

