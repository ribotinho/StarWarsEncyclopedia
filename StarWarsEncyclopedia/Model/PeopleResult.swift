//
//  PersonResult.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 17/10/22.
//

import Foundation

struct PeopleResult: Codable {
    var count: Int
    var results: [People]
}
