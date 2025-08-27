//
//  RickyAndMortyServiceProtocol.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

import Combine

protocol RickAndMortyServiceProtocol {
    func fetchCharacters(page: Int, status: String?) -> AnyPublisher<CharactersResponse, Error>
}
