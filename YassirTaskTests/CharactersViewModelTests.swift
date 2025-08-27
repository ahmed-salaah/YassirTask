//
//  CharactersViewModel.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

import XCTest
import Combine
@testable import YassirTask

final class CharactersViewModelTests: XCTestCase {
    var service: RickAndMortyServiceMock!
    var viewModel: CharactersViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        service = RickAndMortyServiceMock()
        viewModel = CharactersViewModel(service: service)
        cancellables = []
    }
    
    func testInitialFetchCharacters() {
        service.charactersResponse = CharactersResponse.mock
        let expectation = XCTestExpectation(description: "ViewModel fetches characters")
        
        viewModel.$characters
            .dropFirst()
            .sink { characters in
                XCTAssertEqual(characters.count, 6)
                XCTAssertEqual(characters.first?.name, "Rick Sanchez")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchCharacters()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilterCharactersAlive() {
        service.charactersResponse = CharactersResponse.mock
        let expectation = XCTestExpectation(description: "ViewModel Alive Filter")
        
        viewModel.$selectedStatus
            .dropFirst()
            .sink { status in
                XCTAssertEqual(status, .alive)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.changeFilter(to: .alive)
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilterCharactersDead() {
        service.charactersResponse = CharactersResponse.mock
        let expectation = XCTestExpectation(description: "ViewModel Dead Filter")
        
        viewModel.$selectedStatus
            .dropFirst()
            .sink { status in
                XCTAssertEqual(status, .dead)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.changeFilter(to: .dead)
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilterCharactersUnkown() {
        service.charactersResponse = CharactersResponse.mock
        let expectation = XCTestExpectation(description: "ViewModel Unkown Filter")
        
        viewModel.$selectedStatus
            .dropFirst()
            .sink { status in
                XCTAssertEqual(status, .unknown)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.changeFilter(to: .unknown)
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilterCharactersAliveCharactersList() {
        service.charactersResponse = CharactersResponse.mock
        let expectation = XCTestExpectation(description: "Characters filtered to Alive")
        
        // Subscribe to characters
        viewModel.$characters
            .dropFirst()
            .sink { characters in
                XCTAssertTrue(characters.allSatisfy { $0.status.lowercased() == "alive" })
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.changeFilter(to: .alive)
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilterCharactersDeadCharactersList() {
        service.charactersResponse = CharactersResponse.mock
        let expectation = XCTestExpectation(description: "Characters filtered to Dead")
        
        // Subscribe to characters
        viewModel.$characters
            .dropFirst()
            .sink { characters in
                XCTAssertTrue(characters.allSatisfy { $0.status.lowercased() == "dead" })
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.changeFilter(to: .dead)
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilterCharactersUnkownCharactersList() {
        service.charactersResponse = CharactersResponse.mock
        let expectation = XCTestExpectation(description: "Characters filtered to Unkown")
        
        // Subscribe to characters
        viewModel.$characters
            .dropFirst()
            .sink { characters in
                XCTAssertTrue(characters.allSatisfy { $0.status.lowercased() == "unkown" })
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.changeFilter(to: .unknown)
        
        // Then
        wait(for: [expectation], timeout: 1)
    }


}
