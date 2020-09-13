//
//  CharacterTableViewCell.swift
//  BreakingBad
//
//  Created by GAN on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImageView.sd_cancelCurrentImageLoad()
        characterImageView.image = nil
    }

    func setup(with character:Character) {
        characterImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        characterImageView.sd_setImage(with: URL(string: character.img), placeholderImage: UIImage(named: "placeholder"))
        characterNameLabel.text = character.name
    }

}
