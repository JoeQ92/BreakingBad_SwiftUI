//
//  CharacterListViewModelTests.swift
//  BreakingBadTests
//
//  Created by Joe Quesne on 14/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import XCTest
@testable import BreakingBad

class MockNetworkManager: NetworkManagerProtocol {
    
    let mockCharacters:[Character] = [
        Character(charId: 1, name: "Walter White", birthday: "09-07-1958", occupation: ["High School Chemistry Teacher", "Meth King Pin"], img: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg", status: "Presumed dead", nickname: "Heisenberg", appearance: [1, 2, 3, 4, 5], portrayed: "Bryan Cranston", category: "Breaking Bad", betterCallSaulAppearance: []),
        Character(charId: 2, name: "Jesse Pinkman", birthday: "09-24-1984", occupation: ["Meth Dealer"], img: "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Jesse_Pinkman2.jpg/220px-Jesse_Pinkman2.jpg", status: "Alive", nickname: "Cap n' Cook", appearance: [1, 2, 3, 4, 5], portrayed: "Aaron Paul", category: "Breaking Bad", betterCallSaulAppearance: []),
        Character(charId: 9, name: "Gustavo Fring", birthday: "Unknown", occupation: ["Los-Pollos co-Founder", "Philanthropist", "Cartel Leader"], img: "https://vignette.wikia.nocookie.net/breakingbad/images/1/1f/BCS_S4_Gustavo_Fring.jpg/revision/latest?cb=20180824195925", status: "Deceased", nickname: "Gus", appearance: [2, 3, 4], portrayed: "Giancarlo Esposito", category: "Breaking Bad, Better Call Saul", betterCallSaulAppearance: [3, 4])
    ]
    
    func getCharacters(completion: @escaping ([Character]) -> Void) {
        completion(mockCharacters)
    }
}

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
