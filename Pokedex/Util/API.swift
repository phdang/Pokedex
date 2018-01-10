//
//  API.swift
//  Pokedex
//
//  Created by HAI DANG on 1/10/18.
//  Copyright © 2018 HAI DANG. All rights reserved.
//

import Foundation

let BASE_URL = "http://pokeapi.co"

let POKEMON_URL = "/api/v2/pokemon/"

let POKEMON_EVOLUTION_URL = "/api/v2/evolution-chain/"

let POKEMON_DESCRIPTION_URL = "/api/v2/pokemon-species/"

typealias downloadComplete = () -> ()
