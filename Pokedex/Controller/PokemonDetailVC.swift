//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by HAI DANG on 1/10/18.
//  Copyright © 2018 HAI DANG. All rights reserved.
//

import UIKit
import SVProgressHUD


class PokemonDetailVC: UIViewController {
    
    //Passing infomation from PokedmonVC
    
    var pokemon : Pokemon?
    
    //Declare all infomation outlet variables
    
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var detailLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var PokedexIdLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    
    @IBOutlet weak var currentStageImg: UIImageView!
    
    @IBOutlet weak var nextStageImg: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        reset()
        
        if let poke = pokemon {
        
            navigationItem.title = poke.name.capitalized
            
            mainImg.image = UIImage(named: "\(poke.pokedexId)")
            
            PokedexIdLbl.text = "\(poke.pokedexId)"
            
            currentStageImg.image = UIImage(named: "\(poke.pokedexId)")
            
            SVProgressHUD.show(withStatus: "Loading Pokemon Infomation")
            
            poke.finishDownloadPokemonDetails(completed: {
                
                self.updateUI()
                
                
            })
        
        }
    }
    
    func updateUI() {
        
        //print("Did get here")
        
        if let poke = pokemon {
            
            heightLbl.text = poke.height
            
            weightLbl.text = poke.weight
            
            defenseLbl.text = poke.defense
            
            attackLbl.text = poke.attack
            
            typeLbl.text = poke.type
            
            var details = poke.detail.replacingOccurrences(of: "\n", with: " ")
            
            details = details.replacingOccurrences(of: ".", with: ". ")
            
            detailLbl.text = details
            
            
            if poke.nextEvolutionId == "\(poke.pokedexId)" {
        
                nextEvolutionLbl.text = "No Next Evolution Stage"
                
            } else {
                
                //print(poke.nextEvolutionId)
                
                nextStageImg.image = UIImage(named: poke.nextEvolutionId)
             
                nextEvolutionLbl.text = "Next Evolution: \(poke.nextEvolutionName.capitalized) Level \(poke.nextEvolutionLevel)"
              
            }
            
            SVProgressHUD.dismiss()
            
        }
        
    }
    
    //MARK:- Reset before loading data
    func reset() {
        
        detailLbl.text = ""
        typeLbl.text = ""
        defenseLbl.text = ""
        heightLbl.text = ""
        nextEvolutionLbl.text = ""
        weightLbl.text = ""
        attackLbl.text = ""
        PokedexIdLbl.text = ""
        
        
    }

}
