//
//  CharactersViewModel.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//
import Foundation
import Combine

enum CharacterStatus: String, CaseIterable {
    case all = ""
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    
    var title: String {
        switch self {
        case .all: "All"
        case .alive: "Alive"
        case .dead: "Dead"
        case .unknown: "Unknown"
        }
    }
}

final class CharactersViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var characters: [Character] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String? = nil
    @Published private(set) var selectedStatus: CharacterStatus = .all
    
    // MARK: - Private
    private var currentPage = 1
    private var hasMorePages = true
    private var cancellables = Set<AnyCancellable>()
    
    private let service: RickAndMortyServiceProtocol
    
    // MARK: - Init
    init(service: RickAndMortyServiceProtocol = RickAndMortyService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    func fetchCharacters(reset: Bool = false) {

        if reset {
            characters = []
            currentPage = 1
            hasMorePages = true
        }
        
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        error = nil
        
        service.fetchCharacters(page: currentPage,
                                status: selectedStatus == .all ? nil : selectedStatus.rawValue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.error = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.characters.append(contentsOf: response.results)
                self.hasMorePages = response.info.next != nil
                self.currentPage += 1
            }
            .store(in: &cancellables)
    }
    
    func changeFilter(to status: CharacterStatus) {
        guard status != selectedStatus else { return }
        selectedStatus = status
        fetchCharacters(reset: true)
    }
}
