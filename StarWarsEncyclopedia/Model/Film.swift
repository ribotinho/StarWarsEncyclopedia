//
//  Film.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 17/10/22.
//

import Foundation


struct Film : Codable {
    var title : String
    var director : String
    var producer : String
    var releaseDate : String
    var episodeId : Int
    var openingCrawl : String
    var characters : [String]
}
