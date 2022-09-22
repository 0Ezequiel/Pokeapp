//
//  ViewController.swift
//  teste
//
//  Created by user on 21/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nextPreview: UIStepper!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var restart: UIButton!
    
    var num = 1
    var i = 0;
    var pokemons = [
        "Pikachu",
        "Bulbasaur",
        "charizard",
        "charmander"
    ]
    let imagens: [UIImage?] = [
        UIImage.init(named: "pikachu"),
        UIImage.init(named: "bulbasaur"),
        UIImage.init(named: "charizard"),
        UIImage.init(named: "charmander"),
    ]
    
    
    @IBOutlet weak var id: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func getApi() {
//        let pokemons = "https://pokeapi.co/api/v2/pokemon/ditto"
//    }

    @IBAction func npPokemon(_ sender: Any) {
        if (pokemons.count > i) {
            name.text = pokemons[i]
            image.image = imagens[i]
            num+=1
            label.text = "Pokémon ID: \(num)"
            i+=1
        }
    }
}

