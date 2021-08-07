//
//  ContentView.swift
//  Petition
//
//  Created by Evans Domina Attafuah on 05/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var petitons = [Petition]()
    
    var body: some View {
        NavigationView {
            List(petitons) {
                Text("\($0.title): ").bold() +
                Text($0.body)
                
            }
            .navigationTitle("Pettiton")
            .task {
                do {
                    inbox = try await inbox()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func inbox() async throws -> [Petition] {
        try await URLSession.shared.decode(from: URL(string: "https://hws.dev/petitions.json")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
