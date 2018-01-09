//
//  Pokemon.swift
//  Pokedex
//
//  Created by HAI DANG on 1/10/18.
//  Copyright © 2018 HAI DANG. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name : String = ""
    
    private var _pokedexId : Int = 0
    
    var name : String {
        
        return _name
    }
    
    var pokedexId : Int {
        
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        
        self._pokedexId = pokedexId
    }
}
