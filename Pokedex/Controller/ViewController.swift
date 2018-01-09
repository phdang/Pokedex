//
//  ViewController.swift
//  Pokedex
//
//  Created by HAI DANG on 1/10/18.
//  Copyright © 2018 HAI DANG. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet var collection : UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    
    var fileteredPokemons = [Pokemon]()
    
    var inSearchMode = false
    
    var musicPlayer : AVAudioPlayer!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collection.dataSource = self
        
        collection.delegate = self
        
        searchBar.delegate = self
        
        //return keytype
        
        searchBar.returnKeyType = UIReturnKeyType.done
       
        parsePokemonCSV()
        
        initAudio()
  
    }
    
    //MARK:- Init Audio
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            
            musicPlayer.prepareToPlay()
            
            musicPlayer.numberOfLoops = -1
            
            musicPlayer.play()
            
            
        } catch {
            
            print(error)
        }
    }
    
    
    //MARK:- Parse Pokemon CSV Methods
    
    func parsePokemonCSV() {
        
        if let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") {
        
            do {
                
                let csv = try CSV(contentsOfURL: path)
                
                let rows = csv.rows
                
                for row in rows {
                    
                    let pokedexId = Int(row["id"]!)
                    
                    let name = row["identifier"]
                    
                    let poke = Pokemon(name: name!, pokedexId: pokedexId!)
                    
                    pokemons.append(poke)
                }
                
            } catch {
                
                print(error)
            }
        }
        
    }
    
    //MARK:- Collection DataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            //let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row)
            
            let poke : Pokemon!
            
            if inSearchMode {
                
                poke = fileteredPokemons[indexPath.row]
                
            } else {
                
                poke = pokemons[indexPath.row]
            }
            
            
            cell.configureCell(pokemon: poke)
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return fileteredPokemons.count
            
        }
        
        return pokemons.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105.0, height: 105.0)
    }
    
    //MARK:- Collection Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK:- Music Button Pressed Method
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            
            sender.alpha = 0.2
            
        } else {
            
            musicPlayer.play()
            
            sender.alpha = 1
        }
        
    }
    
    //MARK:- Search Bar Delegate methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            fileteredPokemons = pokemons.filter({ $0.name.range(of: lower) != nil})
            
            
        }
        
        collection.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    
}

