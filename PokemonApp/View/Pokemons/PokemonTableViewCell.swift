//
//  PokemonTableViewCell.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
