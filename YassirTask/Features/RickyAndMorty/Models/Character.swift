//
//  Characeter.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

struct CharactersResponse: Decodable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let location: Location
}

struct Location: Decodable {
    let url: String
    let name: String
}
