//
//  Stat.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct Stat: Codable {
    var stat: StatDetail
    var value: Int
}

struct StatDetail: Codable {
    var name: String
}
