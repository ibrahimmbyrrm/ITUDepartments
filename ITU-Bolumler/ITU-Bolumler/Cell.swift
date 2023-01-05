//
//  Cell.swift
//  ITU-Bolumler
//
//  Created by İbrahim Bayram on 5.01.2023.
//

import UIKit

class Cell: UITableViewCell {

   
    @IBOutlet weak var bolumSiralama: UILabel!
    @IBOutlet weak var bolumDili: UILabel!
    @IBOutlet weak var bolumAdi: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
