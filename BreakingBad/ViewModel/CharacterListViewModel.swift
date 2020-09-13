//
//  CharacterListViewModel.swift
//  BreakingBad
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import Foundation

protocol CharacterListViewModelDelegate: class {
    func charactersUpdated()
}

class CharacterListViewModel {
    //MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    private var charactersAll: [Character] = []
    
    public var charactersFiltered: [Character] = [] {
        didSet {
            self.delegate?.charactersUpdated()
        }
    }
    public var seasonFilter: Set<Int> = Set() {
        didSet {
            filterCharacters()
        }
    }
    public var nameFilter: String = "" {
        didSet {
            filterCharacters()
        }
    }
    public weak var delegate: CharacterListViewModelDelegate?
    
    //MARK: - Initializer
    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func loadCharacters() {
        networkManager.getCharacters { characters in
            self.charactersAll = characters
            self.charactersFiltered = characters
        }
    }
    
    private func filterCharacters() {
        charactersFiltered = charactersAll.filter {
            let containsName = nameFilter.isEmpty ? true: $0.name.lowercased().contains(nameFilter.lowercased())
            let containsSeason = seasonFilter.isEmpty ? true: !(Set($0.appearance).intersection(seasonFilter).isEmpty)
            return containsName && containsSeason
        }
    }
}
