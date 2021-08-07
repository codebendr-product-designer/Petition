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
            VStack {
                Text("✊🏿").font(.title)
                Text("Let\'s Enact Change").font(.title).bold()
                List(petitons) { petition in
                    VStack {
    //                    Text("\(petition.title): ").bold() +
    //                    Text(petition.body)
                        HStack(alignment: .center) {
                            Text("🔐").font(.largeTitle)
                            
                            VStack {
                            Text(petition.title).bold()
                            }
                        }
                    }
                }
    //            .navigationTitle("Petition")
                .task {
                    print("task")
                    do {
                        petitons = try await petitions()
                        print("petitons", petitons)

                    } catch {
    //                    print(error.localizedDescription)
                        print("error", error)
                        
                    }
            }
            }
        }
    }
    
    func petitions() async throws -> [Petition] {
        try await URLSession.shared.decode(from: URL(string: "https://hws.dev/petitions.json")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
