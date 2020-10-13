//
//  BreakingBadApp.swift
//  BreakingBad
//
//  Created by Joe Quesne on 11/10/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import SwiftUI

@main
struct BreakingBadApp: App {
    let viewModel = CharacterListViewModel(networkManager: NetworkManager())
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CharacterListView(viewModel: viewModel).navigationBarTitle("Characters")
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        }
    }
}
