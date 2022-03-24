//
//  PerrosCeldaTableViewCell.swift
//  ListaPerros
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import UIKit

class PerrosCeldaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEdadPerro: UILabel!
    @IBOutlet weak var lblDescripcionPerro: UILabel!
    @IBOutlet weak var lblNombrePerro: UILabel!
    @IBOutlet weak var imgPerro: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
