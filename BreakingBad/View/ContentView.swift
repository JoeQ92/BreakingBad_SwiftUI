//
//  ContentView.swift
//  BreakingBad
//
//  Created by Joe Quesne on 09/10/2020.
//  Copyright © 2020 JQ. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    @State private var season = 0
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search ...", text: $viewModel.nameFilter).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Seasons")
                seasonPicker()
            }
            List {
                ForEach(viewModel.charactersFiltered, id: \.self) { character in
                    NavigationLink(destination: CharacterDetailView(character: character), label: {
                        characterIcon(urlString: character.img)
                        Text(character.name)
                    })
                }
            }.onAppear {
                self.viewModel.loadCharacters()
            }.listStyle(PlainListStyle())
        }
        .padding()
    }
    
    func seasonPicker() -> some View {
        Picker(selection: $season, label: Text("Season: ")) {
            Text("All").tag(0)
            ForEach(Constants.bbSeasons, id: \.self) { season in
                Text(String(season)).tag(season)
            }
        }.onChange(of: season, perform: { value in
            if season == 0 {
                viewModel.seasonFilter = [1, 2, 3, 4, 5]
            } else {
                viewModel.seasonFilter = [value]
            }
        }).pickerStyle(SegmentedPickerStyle())
    }
    
    func characterIcon(urlString: String) -> some View {
        WebImage(url: URL(string: urlString))
            .placeholder(Image(systemName: "photo"))
            .resizable()
            .indicator(.activity)
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60, alignment: .leading)
            .transition(.fade(duration: 0.5))
    }
}

struct CharacterDetailView: View {
    var character: Character
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: character.img))
                .placeholder(Image(systemName: "photo"))
                .resizable()
                .indicator(.activity)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                //Used to fill width of VStack
                HStack {
                    Spacer()
                }
                headerText("Occupation:")
                valueText(character.occupation.joined(separator: ", "))
                headerText("Status:")
                valueText(character.status)
                headerText("Nickname:")
                valueText(character.nickname)
                headerText("Season Appearance:")
                valueText(character.appearance?.map(String.init).joined(separator: ", ") ?? "")
            }
        }
        .navigationTitle(character.name)
        .padding(20)
    }
    
    func headerText(_ header: String) -> some View {
        Text(header)
            .fontWeight(.bold)
            .padding(.top)
    }
    
    func valueText(_ value: String) -> some View {
        Text(value)
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CharacterListViewModel(networkManager: MockNetworkManager())
        
        NavigationView {
            CharacterListView(viewModel: viewModel).navigationBarTitle("Characters")
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailView(character: Character.testCharacter)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
