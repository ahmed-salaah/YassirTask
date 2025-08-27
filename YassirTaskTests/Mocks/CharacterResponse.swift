//
//  CharacterResponse.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//
@testable import YassirTask

extension CharactersResponse {
    static var mock: CharactersResponse {
        CharactersResponse(
            info: PageInfo(count: 2, pages: 1, next: nil, prev: nil),
            results: [
                Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: "Male", location: Location(url: "", name: "Egypt")),
                Character(id: 2, name: "Morty Smith", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", gender: "Male", location: Location(url: "", name: "Egypt")),
                Character(id: 1, name: "Rick Sanchez", status: "Dead", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: "Male", location: Location(url: "", name: "Egypt")),
                Character(id: 2, name: "Morty Smith", status: "Dead", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", gender: "Male", location: Location(url: "", name: "Egypt")),
                Character(id: 1, name: "Rick Sanchez", status: "Unkown", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: "Male", location: Location(url: "", name: "Egypt")),
                Character(id: 2, name: "Morty Smith", status: "Unkown", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", gender: "Male", location: Location(url: "", name: "Egypt"))
            ]
        )
    }
}
