//
//  Character.swift
//  BreakingBad
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import Foundation

// https://breakingbadapi.com/api/characters
struct Character: Codable, Identifiable, Hashable {
    let id = UUID()
    let charId: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: String
    let nickname: String
    let appearance: [Int]?
    let portrayed: String
    let category: String
    let betterCallSaulAppearance: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case charId = "char_id"
        case name
        case birthday
        case occupation
        case img
        case status
        case nickname
        case appearance
        case portrayed
        case category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
}
