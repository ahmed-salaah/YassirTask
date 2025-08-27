//
//  RickeyAndMortyServiceMock.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

import XCTest
import Combine
@testable import YassirTask

final class RickAndMortyServiceMock: RickAndMortyServiceProtocol {
    
    var charactersResponse: CharactersResponse?
    var error: Error?
    func fetchCharacters(page: Int, status: String?) -> AnyPublisher<YassirTask.CharactersResponse, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        if let response = charactersResponse {
            var filteredResults = response.results
            
            if let status = status, !status.isEmpty {
                filteredResults = response.results.filter {
                    $0.status.lowercased() == status.lowercased()
                }
            }
            
            let filteredResponse = CharactersResponse(
                info: response.info,
                results: filteredResults
            )
            
            return Just(filteredResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Empty().eraseToAnyPublisher()
    }

}

