//
//  Tabs.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import Foundation

enum MainMenuTab : String, CaseIterable {
    
    case films = "film"
    case people = "person.2.fill"
    case planets = "globe.americas.fill"
    case species = "allergens"
    case vehicles = "car.fill"
    case starship = "airplane.circle.fill"
    
    func displayName() -> String {
        switch self {
        case .films:
            return "Films"
        case .people:
            return "Characters"
        case .planets:
            return "Planets"
        case .species:
            return "Species"
        case .vehicles:
            return "Vehicles"
        case .starship:
            return "Starships"
        }
    }
    
}
