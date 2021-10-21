//
//  CelulaCustomizada.swift
//  revisaocollectionview
//
//  Created by Caroline Feldhaus de Souza on 20/10/21.
//

import UIKit

class CelulaCustomizada: UICollectionViewCell {
   
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    
    static var id: String = "celulaCustomizada"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
