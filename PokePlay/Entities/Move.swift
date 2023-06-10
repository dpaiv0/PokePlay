//
//  Move.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct Move: Codable {
    var move_id: Int
    var move: MoveDetail
}

struct MoveDetail: Codable {
    var name: String
}
