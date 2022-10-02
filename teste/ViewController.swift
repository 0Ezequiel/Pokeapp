import UIKit

enum CustomerError: Error {
    case invalidURL
    case errorSession
    case errorData
    case errorDecode
}

class ViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nextPreview: UIStepper!
    @IBOutlet weak var label: UILabel!

    var idInicial: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        nextPreview.value = 1
        nextPreview.minimumValue = 1
        nextPreview.maximumValue = 905
        pegaDaApi { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.name.text = pokemon.name.uppercased()
                }
                self.idInicial = pokemon.id
                self.pegaImagemDaApi(pokemon: pokemon)
            case .failure:
                print("Aconteceu um erro!!!")
            }
        }
    }
    
    @IBAction func stepperFuncao(_ sender: UIStepper) {
        idInicial = Int(sender.value)
        label.text = "Pokémon ID: \(idInicial)"
        
        pegaDaApi { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.name.text = pokemon.name.uppercased()
                }
                self.idInicial = pokemon.id
                self.pegaImagemDaApi(pokemon: pokemon)
            case .failure:
                print("Aconteceu um erro!!!")
            }
        }
    }
    
    func pegaDaApi(completion: @escaping (Result<Pokemon, CustomerError>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(self.idInicial)") else {
            return completion(.failure(.invalidURL))
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error == nil else {
                return completion(.failure(.errorSession))
            }
            
            guard let data = data else {
                return completion(.failure(.errorData))
            }
            
            guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
                return completion(.failure(.errorDecode))
            }
            
            completion(.success(pokemon))
        }.resume()
    }
    
    
    func pegaImagemDaApi(pokemon: Pokemon) {
        guard let url = URL(string: pokemon.sprites.other.home.front_default) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data else {
                return
            }
            let pokemonImage = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.image.image = pokemonImage
            }
        }.resume()
    }
}

