//
//  Person.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 17/10/22.
//

import UIKit

struct People: Codable {
    var name: String
    var height: String
    var mass: String
    var hairColor : String
    var skinColor: String
    var eyeColor: String
    var birthYear: String
    var gender: String
    var url: String
    
    func getAvatar() -> UIImage {
        if let image = UIImage(named: name) {
            return image
        }else {
            return UIImage(named: "placeholderAvatar")!
        }
    }
    
    func value(for stat: PeopleStat) -> String {
        switch stat {
        case .height:
            return height
        case .mass:
            return mass
        case .eyeColor:
            return eyeColor
        case .gender:
            return gender
        case .birthYear:
            return birthYear
        case .skinColor:
            return skinColor
        case .hairColor:
            return hairColor
        }
    }
}

enum PeopleStat : String, CaseIterable {
    case height = "Height (cm)"
    case mass = "Weight (kg)"
    case eyeColor = "Eye color"
    case hairColor = "Hair color"
    case gender = "Gender"
    case birthYear = "Birthday"
    case skinColor = "Skin color"
}
