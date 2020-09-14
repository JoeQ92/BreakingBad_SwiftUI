//
//  NetworkManager.swift
//  BreakingBad
//
//  Created by Joe Quesne on 13/09/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func getCharacters(completion: @escaping ([Character]) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func getCharacters(completion: @escaping ([Character]) -> Void) {
        networkRequest(endpoint: .getCharacters) { data, error in
            if let jsonData = data {
                do {
                    let characters = try JSONDecoder().decode([Character].self, from: jsonData)
                    completion(characters)
                }
                catch {
                    print("error = \(error)")
                }
            }
        }
    }
    
    private func networkRequest(endpoint: Endpoint, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        
        if let request = endpoint.urlRequest {
            URLSession.shared.dataTask(with: request) { data, response, error in
                completion(data, error)
            }.resume()
        }
    }
}
