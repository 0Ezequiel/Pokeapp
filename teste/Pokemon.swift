import Foundation
import UIKit

struct Home: Decodable {
    let front_default: String
}

struct Other: Decodable {
    let home: Home
}

struct Pokemon: Decodable {
    struct Sprite: Decodable {
        let other: Other
    }
    
    let name: String
    let id: Int
    let sprites: Sprite
    
}

//Sprites > other > home > front_default
