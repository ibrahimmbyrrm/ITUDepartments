//
//  Bolumlerdao.swift
//  ITU-Bolumler
//
//  Created by İbrahim Bayram on 5.01.2023.
//

import Foundation

class Bolumlerdao {
    let db : FMDatabase?
    
    init() {
        let hedefyol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: hedefyol).appendingPathComponent("bolumler.db")
        db = FMDatabase(path: databaseURL.path)
    }
    func bolumleriAl() -> [Bolumler] {
        var liste = [Bolumler]()
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM bolumler", values: nil)
            
            while(rs.next()) {
                let bolum = Bolumler(bolum_id: Int(rs.string(forColumn: "bolum_id"))!, bolum_ad: rs.string(forColumn: "bolum_ad")!, bolum_siralama: Float(rs.string(forColumn: "bolum_siralama"))!, bolum_dil: rs.string(forColumn: "bolum_dil")!)
                liste.append(bolum)
            }
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    func ingBolumAl() -> [Bolumler] {
        var liste = [Bolumler]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM bolumler WHERE bolum_dil = 'ING'", values: nil)
            while(rs.next()) {
                let bolum = Bolumler(bolum_id: Int(rs.string(forColumn: "bolum_id"))!, bolum_ad: rs.string(forColumn: "bolum_ad")!, bolum_siralama: Float(rs.string(forColumn: "bolum_siralama"))!, bolum_dil: rs.string(forColumn: "bolum_dil")!)
                liste.append(bolum)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    func turkcebolumAl() -> [Bolumler] {
        var liste = [Bolumler]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM bolumler WHERE bolum_dil = '%30 ING'", values: nil)
            while(rs.next()) {
                let bolum = Bolumler(bolum_id: Int(rs.string(forColumn: "bolum_id"))!, bolum_ad: rs.string(forColumn: "bolum_ad")!, bolum_siralama: Float(rs.string(forColumn: "bolum_siralama"))!, bolum_dil: rs.string(forColumn: "bolum_dil")!)
                liste.append(bolum)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    func filtrele(siralama : Float) -> [Bolumler] {
        var liste = [Bolumler]()
        db?.open()
        do{
            let rs = try db!.executeQuery("SELECT * FROM bolumler WHERE bolum_siralama >= ?", values: [siralama])
            while(rs.next()) {
                let bolum = Bolumler(bolum_id: Int(rs.string(forColumn: "bolum_id"))!, bolum_ad: rs.string(forColumn: "bolum_ad")!, bolum_siralama: Float(rs.string(forColumn: "bolum_siralama"))!, bolum_dil: rs.string(forColumn: "bolum_dil")!)
                liste.append(bolum)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
}
