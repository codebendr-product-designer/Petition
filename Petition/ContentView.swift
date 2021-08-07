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
                    VStack {
                        HStack {
                            Text("🔐").font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(petition.title).bold()
                                HStack {
                                    
                                    Image(systemName: "person.3.sequence.fill")
                                       
                                    Text("540")
                                        .foregroundColor(.green).font(.body).bold()
                                    Text("/").bold()
                                    Text("340,987").bold()
                                    
                                    HStack {
                                        Spacer()
                                        Text("STATUS").font(.system(size: 10)).bold()
                                        Text("-").font(.caption).bold()
                                        Image(systemName: "checkmark.circle.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.green)
                                            .padding(.trailing, 10)
                                    }
                                
                                 
                                }
                                .padding(.top, 1)
                            }
                        }
                    }
                    .padding(.top, 20)
                }
               
          //  .navigationTitle("Petition")
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
            Spacer()
        }
        
    }
    
    func petitions() async throws -> [Petition] {
        try await URLSession.shared.decode(from: URL(string: "https://hws.dev/petitions.json")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().ignoresSafeArea(.all)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            Text("✊🏿").font(.system(size: 48))
            Text("Let\'s Enact Change")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
        }
        .frame(width: 155)
        .padding()
    }
}
