//
//  Weakness.swift
//  PokePlay
//
//  Created by David Paiva on 15/06/2023.
//

import Foundation

struct Weakness {
    static func DealDamage(defendingPokemon: ComplexPokemon, damage: Int) -> ComplexPokemon {
        return defendingPokemon.setCurrentHealth(currentHealth: defendingPokemon.getCurrentHp() - Double(damage))
    }
    
    static func CalculateTypeEffectiveness(attackingPokemon: ComplexPokemon, defendingPokemon: ComplexPokemon, move: Move) -> Double {
        let attackingType = attackingPokemon.getTypes().first?.type.name
        let defendingType = defendingPokemon.getTypes().first?.type.name
        
        let effectiveness: Double
        
        switch (attackingType, defendingType) {
        case ("normal", "rock"),
             ("normal", "ghost"):
            effectiveness = 0.5
        case ("fighting", "normal"),
             ("fighting", "ice"),
             ("fighting", "rock"),
             ("fighting", "normal"),
             ("fighting", "flying"),
             ("fighting", "poison"),
             ("fighting", "bug"),
             ("fighting", "psychic"):
            effectiveness = 2.0
        case ("fighting", "ghost"):
            effectiveness = 0.0
        case ("flying", "fighting"),
             ("flying", "bug"),
             ("flying", "grass"):
            effectiveness = 2.0
        case ("flying", "rock"),
             ("flying", "electric"):
            effectiveness = 0.5
        case ("poison", "grass"),
             ("poison", "bug"),
             ("poison", "poison"):
            effectiveness = 0.5
        case ("poison", "ground"),
             ("poison", "rock"),
             ("poison", "ghost"):
            effectiveness = 2.0
        case ("ground", "poison"),
             ("ground", "rock"),
             ("ground", "electric"):
            effectiveness = 2.0
        case ("ground", "bug"),
             ("ground", "grass"):
            effectiveness = 0.5
        case ("ground", "flying"):
            effectiveness = 0.0
        case ("rock", "fighting"),
             ("rock", "ground"),
             ("rock", "normal"),
             ("rock", "flying"),
             ("rock", "bug"),
             ("rock", "fire"):
            effectiveness = 2.0
        case ("rock", "water"),
             ("rock", "grass"),
             ("rock", "electric"),
             ("rock", "ice"):
            effectiveness = 0.5
        case ("bug", "grass"),
             ("bug", "psychic"),
             ("bug", "bug"):
            effectiveness = 0.5
        case ("bug", "poison"),
             ("bug", "fire"),
             ("bug", "flying"),
             ("bug", "rock"):
            effectiveness = 2.0
        case ("bug", "fighting"),
             ("bug", "ghost"):
            effectiveness = 0.0
        case ("ghost", "normal"),
             ("ghost", "psychic"):
            effectiveness = 0.0
        case ("ghost", "ghost"):
            effectiveness = 2.0
        case ("fire", "bug"),
             ("fire", "grass"),
             ("fire", "ice"),
             ("fire", "steel"):
            effectiveness = 2.0
        case ("fire", "rock"),
             ("fire", "fire"),
             ("fire", "water"),
             ("fire", "dragon"):
            effectiveness = 0.5
        case ("water", "ground"),
             ("water", "rock"),
             ("water", "fire"):
            effectiveness = 2.0
        case ("water", "water"),
             ("water", "grass"),
             ("water", "dragon"):
            effectiveness = 0.5
        case ("electric", "flying"),
             ("electric", "water"):
            effectiveness = 2.0
        case ("electric", "grass"),
             ("electric", "electric"),
             ("electric", "dragon"):
            effectiveness = 0.5
        case ("grass", "ground"),
             ("grass", "rock"),
             ("grass", "water"):
            effectiveness = 2.0
        case ("grass", "flying"),
             ("grass", "poison"),
             ("grass", "bug"),
             ("grass", "fire"),
             ("grass", "grass"),
             ("grass", "dragon"):
            effectiveness = 0.5
        case ("grass", "electric"):
            effectiveness = 0.5
        case ("grass", "ice"):
            effectiveness = 2.0
        case ("psychic", "poison"),
             ("psychic", "fighting"):
            effectiveness = 2.0
        case ("psychic", "psychic"),
             ("psychic", "steel"):
            effectiveness = 0.5
        case ("ice", "flying"),
             ("ice", "ground"),
             ("ice", "grass"),
             ("ice", "dragon"):
            effectiveness = 2.0
        case ("ice", "water"),
             ("ice", "ice"),
             ("ice", "fire"),
             ("ice", "steel"):
            effectiveness = 0.5
        case ("dragon", "dragon"):
            effectiveness = 2.0
        default:
            effectiveness = 1.0
        }
        
        return effectiveness
    }
}
