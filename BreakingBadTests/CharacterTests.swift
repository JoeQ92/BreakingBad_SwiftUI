//
//  BreakingBadTests.swift
//  CharacterTests
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import XCTest
@testable import BreakingBad

class CharacterTests: XCTestCase {
    
    var characters = [Character]()

    override func setUpWithError() throws {
        guard let jsonFilePath = Bundle(for: type(of: self)).path(forResource: "AllCharacters", ofType: "json") else {
            XCTFail("JSON file not found")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            characters = try JSONDecoder().decode([Character].self, from: jsonData)
        } catch let error {
            XCTFail("Unable to decode JSON: error = \(error)")
        }
    }

    func testLoadAllCharacters() throws {
        XCTAssertEqual(characters.count, 63)
    }
    
    func testCharacterId1() throws {
        guard let character = characters.filter({ return $0.charId == 1 }).first else {
            XCTFail("Could not find character with charId = 1")
            return
        }
        
        XCTAssertEqual(character.name, "Walter White")
        XCTAssertEqual(character.birthday, "09-07-1958")
        XCTAssertEqual(character.occupation, ["High School Chemistry Teacher", "Meth King Pin"])
        XCTAssertEqual(character.img, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
        XCTAssertEqual(character.status, "Presumed dead")
        XCTAssertEqual(character.nickname, "Heisenberg")
        XCTAssertEqual(character.appearance, [1, 2, 3, 4, 5])
        XCTAssertEqual(character.portrayed, "Bryan Cranston")
        XCTAssertEqual(character.category, "Breaking Bad")
    }
    
    func testCharacterId30() throws {
        guard let character = characters.filter({ return $0.charId == 30 }).first else {
            XCTFail("Could not find character with charId = 30")
            return
        }
        
        XCTAssertEqual(character.name, "Mrs. Pinkman")
        XCTAssertEqual(character.birthday, "Unknown")
        XCTAssertEqual(character.occupation, ["unknown"])
        XCTAssertEqual(character.img, "https://vignette.wikia.nocookie.net/breakingbad/images/a/a2/Tess_Harper.jpg/revision/latest?cb=20120923235754")
        XCTAssertEqual(character.status, "Alive")
        XCTAssertEqual(character.nickname, "Jesse's mom")
        XCTAssertEqual(character.appearance, [1, 2, 3])
        XCTAssertEqual(character.portrayed, "Tess Harper")
        XCTAssertEqual(character.category, "Breaking Bad")
    }
    
    func testCharacterId63() throws {
        guard let character = characters.filter({ return $0.charId == 117 }).first else {
            XCTFail("Could not find character with charId = 1")
            return
        }
        
        XCTAssertEqual(character.name, "Stacey Ehrmantraut")
        XCTAssertEqual(character.birthday, "Unknown")
        XCTAssertEqual(character.occupation, ["Mother"])
        XCTAssertEqual(character.img, "https://vignette.wikia.nocookie.net/breakingbad/images/b/b3/StaceyEhrmantraut.png/revision/latest?cb=20150310150049")
        XCTAssertEqual(character.status, "?")
        XCTAssertEqual(character.nickname, "Stacey")
        XCTAssertEqual(character.appearance, [])
        XCTAssertEqual(character.portrayed, "Kerry Condon")
        XCTAssertEqual(character.category, "Better Call Saul")
    }
}
