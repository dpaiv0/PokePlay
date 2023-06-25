//
//  PokemonTeam.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct PokemonTeam : Codable {
    var pokemonList: [ComplexPokemon]
    var favoritePokemon: ComplexPokemon? = nil
}

struct ComplexPokemon : Codable {
    var pokemon: Pokemon
    var level: Int = 1
    var xp: Int = 0
    var nickname: String? = nil
    var currentHealth: Double = 0.0
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.currentHealth = Double(getBaseHp())
    }
    
    init(pokemon: Pokemon, level: Int) {
        self.pokemon = pokemon
        self.level = level
        self.currentHealth = Double(getBaseHp())
    }
    
    private func getStatValue(statName: String) -> Int {
        return pokemon.stats.first(where: { $0.stat.name == statName })?.value ?? 0
    }
    
    func levelUp() -> ComplexPokemon {
        var newPokemon = self
        newPokemon.level += 1
        newPokemon.xp = 0
        return newPokemon
    }
    
    func addXp(xp: Int) -> ComplexPokemon {
        var newPokemon = self
        newPokemon.xp += xp
        
        while (newPokemon.canLevelUp()) {
            newPokemon = newPokemon.levelUp()
        }
        
        PokeUtils.PokemonTeamData.UpdatePokemonFromTeam(pokemon: newPokemon)
        
        return newPokemon
    }
    
    func heal(_ hp: Double) -> ComplexPokemon {
        var newPokemon = self
        newPokemon.currentHealth += hp
        
        if (newPokemon.currentHealth > Double(getBaseHp())) {
            newPokemon.currentHealth = Double(getBaseHp())
        }
        
        PokeUtils.PokemonTeamData.UpdatePokemonFromTeam(pokemon: newPokemon)
        
        return newPokemon
    }
    
    func getLevelUpXp() -> Int {
        return (level * 20)
    }
    
    func canLevelUp() -> Bool {
        return xp >= getLevelUpXp()
    }
    
    func getBaseHp() -> Int {
        return getStatValue(statName: "hp")
    }
    
    func getCurrentHp() -> Double {
        return currentHealth
    }
    
    func getAttack() -> Int {
        return getStatValue(statName: "attack")
    }
    
    func getDefense() -> Int {
        return getStatValue(statName: "defense")
    }
    
    func getSpecialAttack() -> Int {
        return getStatValue(statName: "special-attack")
    }
    
    func getSpecialDefense() -> Int {
        return getStatValue(statName: "special-defense")
    }
    
    func getSpeed() -> Int {
        return getStatValue(statName: "speed")
    }
    
    func getTypes() -> [PokemonType] {
        return pokemon.types
    }
    
    func getMoves() -> [Move] {
        return pokemon.moves
    }
    
    func getMove(index: Int) -> Move {
        return pokemon.moves[index]
    }
    
    func getMoveCount() -> Int {
        return pokemon.moves.count
    }
    
    mutating func setNickname(nickname: String) -> ComplexPokemon {
        self.nickname = nickname
        return self
    }
    
    func getNickname() -> String {
        return nickname ?? pokemon.name.capitalized
    }
    
    func isFavorite() -> Bool {
        return pokemon.id == PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults().favoritePokemon?.pokemon.id
    }
    
    func setCurrentHealth(currentHealth: Double) -> ComplexPokemon {
        var newPokemon = self
        newPokemon.currentHealth = currentHealth
        
        PokeUtils.PokemonTeamData.UpdatePokemonFromTeam(pokemon: newPokemon)
        
        return newPokemon
    }
    
    func isFainted() -> Bool {
        return currentHealth <= 0
    }
}
