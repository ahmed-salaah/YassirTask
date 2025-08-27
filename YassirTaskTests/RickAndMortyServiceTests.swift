//
//  Untitled.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//
import XCTest
import Combine
@testable import YassirTask

final class RickAndMortyServiceTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testFetchCharactersSuccess() {
        let service = RickAndMortyServiceMock()
        service.charactersResponse = CharactersResponse.mock
        
        let expectation = XCTestExpectation(description: "Fetch Characters Success")
        
        service.fetchCharacters(page: 1, status: "")
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                XCTAssertEqual(response.results.count, 6)
                XCTAssertEqual(response.results.first?.name, "Rick Sanchez")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchCharactersFailure() {
        let service = RickAndMortyServiceMock()
        service.error = URLError(.badServerResponse)
        let expectation = XCTestExpectation(description: "Fetch Characters Failure")
        service.fetchCharacters(page: 1, status: "")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not succeed")
            })
            .store(in: &self.cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
