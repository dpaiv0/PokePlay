//
//  KantoGyms.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import Foundation

struct KantoGyms {
    static let gyms = [
        Gym(
            name: "Pewter City Gym",
            sprite: "pewter-city-gym",
            badge: Badge(name: "Boulder Badge", sprite: "1"),
            type: "Rock",
            gymLeader: Trainer(name: "Brock", sprite: "brock", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 74), level: 12),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 95), level: 14)
            ])
        ),
        
        Gym(
            name: "Cerulean City Gym",
            sprite: "cerulean-city-gym",
            badge: Badge(name: "Cascade Badge", sprite: "2"),
            type: "Water",
            gymLeader: Trainer(name: "Misty", sprite: "misty", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 120), level: 18),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 121), level: 21)
            ])
        ),
        
        Gym(
            name: "Vermilion City Gym",
            sprite: "vermilion-city-gym",
            badge: Badge(name: "Thunder Badge", sprite: "3"),
            type: "Electric",
            gymLeader: Trainer(name: "Lt. Surge", sprite: "lt-surge", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 100), level: 21),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 25), level: 18),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 26), level: 24)
            ])
        ),
        
        Gym(
            name: "Celadon City Gym",
            sprite: "celadon-city-gym",
            badge: Badge(name: "Rainbow Badge", sprite: "4"),
            type: "Grass",
            gymLeader: Trainer(name: "Erika", sprite: "erika", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 71), level: 29),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 114), level: 24),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 45), level: 29)
            ])
        ),
        
        Gym(
            name: "Fuchsia City Gym",
            sprite: "fuchsia-city-gym",
            badge: Badge(name: "Soul Badge", sprite: "5"),
            type: "Poison",
            gymLeader: Trainer(name: "Koga", sprite: "koga", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 109), level: 37),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 109), level: 37),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 89), level: 39),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 110), level: 43)
            ])
        ),
        
        Gym(
            name: "Saffron City Gym",
            sprite: "saffron-city-gym",
            badge: Badge(name: "Marsh Badge", sprite: "6"),
            type: "Psychic",
            gymLeader: Trainer(name: "Sabrina", sprite: "sabrina", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 64), level: 38),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 122), level: 37),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 49), level: 38),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 65), level: 43)
            ])
        ),
        
        Gym(
            name: "Cinnabar Island Gym",
            sprite: "cinnabar-island-gym",
            badge: Badge(name: "Volcano Badge", sprite: "7"),
            type: "Fire",
            gymLeader: Trainer(name: "Blaine", sprite: "blaine", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 58), level: 42),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 77), level: 40),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 78), level: 42),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 59), level: 47)
            ])
        ),
        
        Gym(
            name: "Viridian City Gym",
            sprite: "viridian-city-gym",
            badge: Badge(name: "Earth Badge", sprite: "8"),
            type: "Ground",
            gymLeader: Trainer(name: "Giovanni", sprite: "giovanni", team: [
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 111), level: 45),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 51), level: 42),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 31), level: 44),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 34), level: 45),
                ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 112), level: 50)
            ])
        )
    ]
}
