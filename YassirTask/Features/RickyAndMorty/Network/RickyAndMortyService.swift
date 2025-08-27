//
//  RickyAndMortyAPI.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//
import Foundation
import Combine

final class RickAndMortyService: RickAndMortyServiceProtocol {
    func fetchCharacters(page: Int, status: String?) -> AnyPublisher<CharactersResponse, Error> {
        var urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        if let status = status, !status.isEmpty {
            urlString += "&status=\(status)"
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CharactersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
