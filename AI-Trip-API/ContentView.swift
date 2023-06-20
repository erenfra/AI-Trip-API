//
//  ContentView.swift
//  AI-Trip-API
//
//  Created by Renato Oliveira Fraga on 6/9/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var apiManager: APIManager
    
    var body: some View {
        VStack {
            Text("London Activities")
            List {
                ForEach(apiManager.plan, id: \.self) { activity in
                    
                }
                
            }
            .padding()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiManager: APIManager())
    }
}
