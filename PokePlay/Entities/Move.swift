//
//  Move.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct Move: Codable {
    let move_id: Int
    let move: MoveDetail
}

struct MoveDetail: Codable {
    let name: String
    let power: Int
}
