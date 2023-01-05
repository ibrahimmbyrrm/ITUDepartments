//
//  Bolumler.swift
//  ITU-Bolumler
//
//  Created by İbrahim Bayram on 5.01.2023.
//

import Foundation

class Bolumler {
    var bolum_id : Int?
    var bolum_ad : String?
    var bolum_siralama : Float?
    var bolum_dil : String?
    
    init(bolum_id: Int? = nil, bolum_ad: String? = nil, bolum_siralama: Float? = nil, bolum_dil: String? = nil) {
        self.bolum_id = bolum_id
        self.bolum_ad = bolum_ad
        self.bolum_siralama = bolum_siralama
        self.bolum_dil = bolum_dil
    }
    
}
