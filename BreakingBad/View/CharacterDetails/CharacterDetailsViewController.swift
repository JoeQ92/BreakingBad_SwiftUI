//
//  CharacterDetailsViewController.swift
//  BreakingBad
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterDetailsViewController: UIViewController {
    
    var character: Character?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        guard let character = character else {
            fatalError()
        }
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: URL(string: character.img), placeholderImage: UIImage(named: "placeholder"))
        nameLabel.text = character.name
        occupationLabel.text = character.occupation.joined(separator: ", ")
        statusLabel.text = character.status
        nicknameLabel.text = character.nickname
        seasonLabel.text = character.appearance?.map(String.init).joined(separator: ", ")
    }
}
