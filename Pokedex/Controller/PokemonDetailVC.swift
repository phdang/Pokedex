//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by HAI DANG on 1/10/18.
//  Copyright © 2018 HAI DANG. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon : Pokemon?
    
    @IBOutlet weak var label : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = pokemon?.name.capitalized

    }

}
