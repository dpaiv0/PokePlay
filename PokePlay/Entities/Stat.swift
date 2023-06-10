//
//  Stat.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct Stat: Codable {
    let stat: StatDetail
    let value: Int
}

struct StatDetail: Codable {
    let name: String
}
