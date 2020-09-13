//
//  CharacterDetailsViewController.swift
//  BreakingBad
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import UIKit

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
        
        print("character = \(character.debugDescription)")
        setupViews()
    }
    
    func setupViews() {
        nameLabel.text = character?.name
        occupationLabel.text = character?.occupation.joined(separator: ", ")
        statusLabel.text = character?.status
        nicknameLabel.text = character?.nickname
        seasonLabel.text = character?.appearance.map(String.init).joined(separator: ", ")
    }
}
