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
                
                TitleView()
                
                List(petitons) { petition in
                    PetitionView(petition: petition)
                }
                .task {
                    do {
                        petitons = try await petitions()
                        
                    } catch {
                       print(error.localizedDescription)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func petitions() async throws -> [Petition] {
        try await URLSession.shared.decode(from: URL(string: "https://hws.dev/petitions.json")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ContentView()
//                .environment(\.colorScheme, .dark)
//            .ignoresSafeArea(.all)
            
            ContentView()
                .environment(\.colorScheme, .light)
                .ignoresSafeArea(.all)
            ContentView()
                .environment(\.colorScheme, .dark)
                .ignoresSafeArea(.all)
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            Text("✊🏿").font(.system(size: 48))
            Text("Let\'s Enact Change")
                .font(.title)
                .foregroundColor(.title)
                .bold()
                .multilineTextAlignment(.center)
            
        }
        .frame(width: 155)
        
    }
}

struct PetitionView: View {
    let petition: Petition
    
    var body: some View {
        HStack {
            
            Text("🔐").font(.largeTitle)
            
            VStack(alignment: .leading) {
                
                Text(petition.title)
                    .foregroundColor(.title)
                    .bold()
                
                HStack {
                    
                    Image(systemName: "person.3.sequence.fill")
                        .foregroundColor(.accent)
                        .padding(.trailing, 5)
                    
                    Text("540")
                        .foregroundColor(.green).font(.body).bold()
                        .padding(.all, -6)
                    
                    Text("/ 340,987")
                        .foregroundColor(.accent)
                        .bold()
                    
                    Spacer()
                    
                    Text("STATUS")
                        .foregroundColor(.accent)
                        .font(.system(size: 10))
                        .bold()
                    
                    Text("-")
                        .foregroundColor(.accent)
                        .font(.caption).bold()
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.green)
                        .padding(.trailing, 10)
                    
                }
                .padding(.top, 1)
                
                ProgressView(value: 0.2)
                    .tint(.progess)
                    .progressViewStyle(.linear)
                
            }
        }
        .listRowBackground(Color.background)
    }
}
