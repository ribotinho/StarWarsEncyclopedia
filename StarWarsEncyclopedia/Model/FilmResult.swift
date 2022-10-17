//
//  FilmResult.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 17/10/22.
//

import Foundation

struct FilmResult : Codable {
    var count : Int
    var results: [Film]
}
