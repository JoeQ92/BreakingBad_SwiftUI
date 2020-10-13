//
//  CharacterListViewModelTests.swift
//  BreakingBadTests
//
//  Created by Joe Quesne on 14/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import XCTest
@testable import BreakingBad

class CharacterListViewModelTests: XCTestCase {
    
    var characterListViewModel:CharacterListViewModel?

    override func setUp() {
        characterListViewModel = CharacterListViewModel(networkManager: MockNetworkManager())
        characterListViewModel?.loadCharacters()
    }

    func testNameFilter() throws {
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 3)
        
        characterListViewModel?.nameFilter = "Walt"
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 1)
        
        characterListViewModel?.nameFilter = "Walter White"
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 1)
        
        characterListViewModel?.nameFilter = "e"
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 2)
        
        characterListViewModel?.nameFilter = "Je"
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 1)
        
        characterListViewModel?.nameFilter = "jesse pinkman"
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 1)
        
        characterListViewModel?.nameFilter = "Gus"
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 1)
        
        characterListViewModel?.nameFilter = "a"
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 3)
        
        characterListViewModel?.nameFilter = ""
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 3)
    }
    
    func testSeasonFilter() throws {
        characterListViewModel?.seasonFilter = [1, 2, 3, 4, 5]
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 3)
        
        characterListViewModel?.seasonFilter = [3]
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 3)
        
        characterListViewModel?.seasonFilter = [1]
        XCTAssertEqual(characterListViewModel?.charactersFiltered.count, 2)
    }
}
