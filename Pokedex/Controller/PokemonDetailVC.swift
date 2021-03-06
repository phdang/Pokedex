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
    
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var PokedexIdLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    
    @IBOutlet weak var currentStageImg: UIImageView!
    
    @IBOutlet weak var nextStageImg: UIImageView!
    
    @IBOutlet weak var reDownloadInfoButton: UIBarButtonItem!
    
    var noRefreshButtonClickedYet : Bool = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        reset()
        
        refresh()
    }
    
    //MARK:- Reset before loading data
    func reset() {
        
        reDownloadInfoButton.isEnabled = false
        
        detailTextView.text = ""
        
        typeLbl.text = ""
        
        defenseLbl.text = ""
        
        heightLbl.text = ""
        
        nextEvolutionLbl.text = ""
        
        weightLbl.text = ""
        
        attackLbl.text = ""
        
        PokedexIdLbl.text = ""
        
        if let poke = pokemon {
            
            navigationItem.title = poke.name.capitalized
            
            mainImg.image = UIImage(named: "\(poke.pokedexId)")
            
            PokedexIdLbl.text = "\(poke.pokedexId)"
            
            currentStageImg.image = UIImage(named: "\(poke.pokedexId)")
        }
        
    }
    
    //MARK:- Refresh Data again or button bar clicked
    
    func refresh() {
        
        if let poke = pokemon {
            
            if noRefreshButtonClickedYet {
            
                SVProgressHUD.show(withStatus: "Loading Pokemon Infomation")
                
            } else {
                
                SVProgressHUD.show(withStatus: "Refreshing Pokemon Infomation")
            }
            
            reDownloadInfoButton.isEnabled = false
            
            poke.finishDownloadPokemonDetails(completed: {
                
                self.updateUI()
                
            })
        }
        
    }
    
    //MARK:- Update Info once retriving data from networking
    
    func updateUI() {
        
        //print("Did get here")
        
        if let poke = pokemon {
            
            heightLbl.text = poke.height
            
            weightLbl.text = poke.weight
            
            defenseLbl.text = poke.defense
            
            attackLbl.text = poke.attack
            
            typeLbl.text = poke.type
            
            var details = poke.detail.replacingOccurrences(of: "\n", with: " ")
            
            details = details.replacingOccurrences(of: "POKéMON", with: "Pokémon")
            
            detailTextView.text = details
            
            if poke.nextEvolutionId == "\(poke.pokedexId)" {
                
                nextEvolutionLbl.text = "No Next Evolution Stage"
                
                nextStageImg.isHidden = true
                
            } else if poke.nextEvolutionName == "" {
                
                if noRefreshButtonClickedYet {
                
                    nextEvolutionLbl.text = "Not Found Information Use Refresh Button To Try Again"
                    
                } else {
                    
                    nextEvolutionLbl.text = "Unknown Information For Next Evolution Stage"
                }
                
                nextStageImg.image = UIImage(named: "0")
                
            } else {
                
                //print(poke.nextEvolutionId)
                
                nextStageImg.image = UIImage(named: poke.nextEvolutionId)
                
                nextEvolutionLbl.text = "Ultimate Evolution Stage: \(poke.nextEvolutionName.capitalized) Level \(poke.nextEvolutionLevel)"
                
            }
            
            SVProgressHUD.dismiss()
            
            if !reDownloadInfoButton.isEnabled {
                
                reDownloadInfoButton.isEnabled = true
            }
            
        }
    }
    
    //MARK:- Button Bar Item Clicked
    
    @IBAction func reDownloadInfo(_ sender: UIBarButtonItem) {
        
        noRefreshButtonClickedYet = false
        
        refresh()
        
    }
}
