//
//  Pokemon.swift
//  Pokedex
//
//  Created by HAI DANG on 1/10/18.
//  Copyright © 2018 HAI DANG. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
class Pokemon {
    
    private var _name : String = ""
    
    private var _pokedexId : Int = 0
    
    private var _detail: String = ""
    
    private var _type : String = ""
    
    private var _defense : String = ""
    
    private var _height : String = ""
    
    private var _weight: String = ""
    
    private var _attack: String = ""
    
    private var _nextEvolutionId : String = ""
    
    private var _nextEvolutionName: String = ""
    
    private var _nextEvolutionLevel : String = ""
    
    private var _pokemonURL : String = ""
    
    var nextEvolutionId : String {
        
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel : String {
        
        return _nextEvolutionLevel
    }
    
    var nextEvolutionName : String {
        
        return _nextEvolutionName
    }
    
    var height : String {
        
        return _height
    }
    
    var weight : String {
        
        return _weight
    }
    
    var defense : String {
        
        return _defense
    }
    
    var attack : String {
        
        return _attack    }
    
    var type: String {
        
        return _type
    }
    
    var detail : String {
        
        return _detail
    }
    
    
    var name : String {
        
        return _name
    }
    
    var pokedexId : Int {
        
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(pokedexId)/"
    }
    
    //MARK:- Networking: Downloading pokemon infomation
    
    func finishDownloadPokemonDetails(completed: @escaping downloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            //print(response.result.value)
            
            if response.result.isSuccess {
                
                if let dict = response.result.value as? Dictionary<String,Any> {
                    
                    //TODO:- Weight
                    
                    if let weight = dict["weight"] as? Int {
                        
                        self._weight = "\(weight)"
                    }
                    //TODO:- Height
                    
                    if let height = dict["height"] as? Int {
                        
                        self._height = "\(height)"
                    }
                    
                    if let stats = dict["stats"] as? NSArray  {
                        
                        //print("Get stats?")
                        
                        //TODO:- Attack
                        
                        if let specialAttack = stats[2] as? Dictionary<String, Any> {
                            
                            //print("Get specialAttack?")
                            
                            if let attack = specialAttack["base_stat"] as? Int {
                                
                                //print("Get base_stat?")
                                
                                self._attack = "\(attack)"
                                
                            }
                        }
                        //TODO:- Defense
                        
                        if let defenseDict = stats[3] as? Dictionary<String, Any> {
                            
                            //print("Get specialAttack?")
                            
                            if let defense = defenseDict["base_stat"] as? Int {
                                
                                //print("Get base_stat?")
                                
                                self._defense = "\(defense)"
                            }
                        }
                    }
                    
                    //TODO:- Types
                    
                    if let types = dict["types"] as? NSArray  {
                        
                        let numberOfTypes = types.count
                        
                        if numberOfTypes > 0 {
               
                            for i in 0..<numberOfTypes {
                                
                                if let typesArray = types[i] as? Dictionary<String, Any> {
                                    
                                    if let type = typesArray["type"] as? Dictionary<String,String> {
                                        
                                        if let name = type["name"] {
                                            
                                            if i == 0 {
                                                
                                                self._type = name.capitalized
                                            } else {
                                                
                                                self._type += "/\(name.capitalized)"
                                            }
                                        }
                                    }
                                }
                                
                            }
                            
                            
                        } else {
                            
                            self._type = "Unknown"
                            
                            if self._attack != "" {
                                
                                completed()
                            }
               
                        }
           
                    }
                    
//                    print(self._weight)
//
//                    print(self._height)
//
//                    print(self._attact)
//
//                    print(self._defense)
//
//                    print(self._type)
                    
                    if self._detail != "" {
                        
                        completed()
                    }
           
                }
                
            } else {
                
                print(response.result.error!)
                
                print("Connection issue")
                
                SVProgressHUD.dismiss()
                
                SVProgressHUD.showError(withStatus: "Connection issue. Try again later !")
            }
    
        }
        
        let descriptionURL = "\(BASE_URL)\(POKEMON_DESCRIPTION_URL)\(pokedexId)/"
        
        //MARK:- Description
        
        Alamofire.request(descriptionURL).responseJSON { response in
            
            if response.result.isSuccess {
                
                if let dict = response.result.value as? Dictionary<String,Any> {
                    
                    if let evolution = dict["evolution_chain"] as? Dictionary<String,Any> {
                        if let chainURL = evolution["url"] as? String {
                            
                            var chainId = chainURL.replacingOccurrences(of: "https://pokeapi.co/api/v2/evolution-chain/", with: "")
                            chainId = chainId.replacingOccurrences(of: "/", with: "")
                            
                            print(chainId)
                            
                            //TODO:- Evolution
                            
                            let evolutionURL = "\(BASE_URL)\(POKEMON_EVOLUTION_URL)\(chainId)/"
                            
                            print(evolutionURL)
                            
                            Alamofire.request(evolutionURL).responseJSON { response in
                                
                                if response.result.isSuccess {
                                    
                                    if let dict = response.result.value as? Dictionary<String,Any> {
                                        //print("1")
                                        if let chain = dict["chain"] as? Dictionary<String,Any> {
                                            //print("2")
                                            if let evolve = chain["evolves_to"] as?  NSArray {
                                                //print("3")
                                                if evolve.count > 0 {
                                                    
                                                    if let details = evolve[0] as? Dictionary<String,Any> {
                                                        //print("4")
                                                        if let evolvesToArray = details["evolves_to"] as? NSArray {
                                                            //print("5")
                                                            if evolvesToArray.count > 0 {
                                                                
                                                                if let evolvesTo = evolvesToArray[0] as? Dictionary<String,Any> {
                                                                    //print("6")
                                                                    if let species = evolvesTo["species"] as? Dictionary<String,Any> {
                                                                        //print("7")
                                                                        //TODO:- Evolution Name
                                                                        
                                                                        if let name = species["name"] as? String {
                                                                            //print("8")
                                                                            
                                                                            self._nextEvolutionName = name
                                                                            
                                                                        }
                                                                        
                                                                        //TODO:- Evolution Id
                                                                        
                                                                        if let url = species["url"] as? String {
                                                                            //print("9")
                                                                            
                                                                            //print(url)
                                                                            
                                                                            var nextEvolId = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
                                                                            
                                                                            nextEvolId = nextEvolId.replacingOccurrences(of: "/", with: "")
                                                                            
                                                                            self._nextEvolutionId = nextEvolId
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                                
                                                            } else {
                                                                
                                                                self._nextEvolutionName = ""
                                                                
                                                                self._nextEvolutionId = ""
                                                                
                                                                if self._attack != "" {
                                                                    
                                                                    //completed()
                                                                }
                                                            }
                                                            
                                                            //
                                                            
                                                            if let evolvesToArray = details["evolution_details"] as? NSArray {
                                                                
                                                                if evolvesToArray.count > 0 {
                                                                    
                                                                    if let detail = evolvesToArray[0] as? Dictionary<String,Any> {
                                                                        
                                                                        //TODO:- Evolution Level
                                                                        
                                                                        if let minLevel = detail["min_level"] as? Int {
                                                                            
                                                                            self._nextEvolutionLevel = "\(minLevel)"
                                                                            
                                                                            if self._attack != "" {
                                                                                
                                                                                //completed()
                                                                            }
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                } else {
                                                                    
                                                                    self._nextEvolutionLevel = ""
                                                                    
                                                                    if self._attack != "" {
                                                                        
                                                                        //completed()
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                } else {
                                                    
                                                    self._nextEvolutionName = ""
                                                    
                                                    self._nextEvolutionId = ""
                                                    
                                                    //completed()
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                } else {
                                    
                                    print(response.result.error!)
                                    
                                    print("Connection issue")
                                    
                                    SVProgressHUD.dismiss()
                                    
                                    SVProgressHUD.showError(withStatus: "Connection issue. Try again later !")
                                    
                                }
                            }
                        }
                    }
                    
                    if let flavors = dict["flavor_text_entries"] as? NSArray {
                        
                        //print("1")
                        
                        for flavor in flavors  {
                            //print("2")
                            if let languages = flavor as? Dictionary<String, Any> {
                                //print(languages)
                                if let language = languages["language"] as? Dictionary<String,String> {
                                    
                                    let name = language["name"]
                                        
                                        if name == "en" {
                                            
                                            if let text = languages["flavor_text"] as? String {
                                                
                                                self._detail += text
                                                
                                                completed()
                                            }
                                        }
                                }
                          
                            }
                            
                        }
                        
                    }
                    
                }
                
                
            } else {
                
                print(response.result.error!)
                
                print("Connection issue")
                
                SVProgressHUD.dismiss()
                
                SVProgressHUD.showError(withStatus: "Connection issue. Try again later !")
                
            }
        }
    }
    
    
}
