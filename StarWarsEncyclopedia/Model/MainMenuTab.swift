//
//  Tabs.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 18/10/22.
//

import Foundation

struct MainMenuTab {
    var title : String
    var image : String
    
    static let tabs : [MainMenuTab] = [
        MainMenuTab(title: "Films", image: "film"),
        MainMenuTab(title: "People", image: "person.2.fill"),
        MainMenuTab(title: "Planets", image: "globe.americas.fill"),
        MainMenuTab(title: "Species", image: "allergens"),
        MainMenuTab(title: "Vehicles", image: "car.fill"),
        MainMenuTab(title: "Starship", image: "airplane.circle.fill")
    ]
}
