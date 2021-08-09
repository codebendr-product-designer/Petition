//
//  ContentView.swift
//  Petition
//
//  Created by Evans Domina Attafuah on 05/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var petitions = [Petition]()
    
    var body: some View {
        NavigationView {
            VStack {
                
                TitleView()
                
                List(petitions) { petition in
                    NavigationLink(destination: PetitionDetailView(petition: petition)) {
                        PetitionView(petition: petition)
                    }
                    .listStyle(.insetGrouped)
                }
                .task {
                    do {
                        petitions = try await petitions().shuffled()
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
    
    static let petition = Petition(id: "2715183", title: "Stop the witch hunt of the duly elected president of the U.S.A  and obstructing the president's work.", body: "What they are doing to Donald Trump is 'really a witch hunt'.  After two years, and no findings of collusion or obstruction, the investigation has been derailed into an ongoing, non-ending witch hunt, obliterating,  intimidating, and bankrupting staffers and family, setting traps in the pursuit of revenge for having had won an election fairly and against all odds. A blind eye has been applied to the real corrupt agents of the federal government allowing them to retire with pensions and untouched by justice. We demand this persecution be stopped and he is allowed to govern for the benefit of our national security without further distractions. We demand that the real corrupt colluders and obstructers are brought to justice and that their benefits be removed. We support our president.", signatureCount: Int.random(in: 149..<40000), signatureThreshold: 100000)
    
    static var previews: some View {
        Group {
            
            ContentView()
                .environment(\.colorScheme, .light)
                .ignoresSafeArea(.all)
            
            ContentView()
                .environment(\.colorScheme, .dark)
                .ignoresSafeArea(.all)
            
            PetitionDetailView(petition: petition)
                .environment(\.colorScheme, .light)
                .ignoresSafeArea(.all)
            
            PetitionDetailView(petition: petition)
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
    let emoji = ["🔐","🧘🏿‍♂️","🧨","💡","🚁","🎯","🎨", "🛺", "🚦"].randomElement()!
    
    var body: some View {
        HStack {
            
            Text("\(emoji)").font(.largeTitle)
            
            VStack(alignment: .leading) {
                
                Text(petition.title)
                    .foregroundColor(.title)
                    .bold()
                
                PetitionProgressView(petition: petition)
          
                
            }
        }
        .listRowBackground(Color.background)
    }
}

struct PetitionProgressView: View {
    let petition: Petition
    var isBelowThreshold: Bool {
        petition.signatureCount < 40000
    }
    
    var body: some View {
        HStack {
            
            Image(systemName: "person.3.sequence.fill")
                .foregroundColor(.accent)
                .padding(.trailing, 5)
            
            Text("\(petition.signatureCount)")
                .foregroundColor(isBelowThreshold ? .pink : .progess).font(.body).bold()
                .padding(.all, -6)
            
            Text("/ \(petition.signatureThreshold)")
                .foregroundColor(.accent)
                .bold()
            
            Spacer()
            
        }
        .padding(.top, 1)
        
        ProgressView(value: Double(petition.signatureCount), total: Double(petition.signatureThreshold))
            .tint(isBelowThreshold ? .pink : .progess)
            .progressViewStyle(.linear)
    }
}

struct PetitionDetailView: View {
    let petition: Petition
    
    var body: some View {
        VStack {
            
            Text("🔐").font(.system(size: 48))
            
            VStack(alignment: .leading) {
                
                Text(petition.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.title)
                    
                
                PetitionProgressView(petition: petition)
                
            }
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
