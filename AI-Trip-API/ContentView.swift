//
//  ContentView.swift
//  AI-Trip-API
//
//  Created by Renato Oliveira Fraga on 6/9/23.
//
import StoreKit
import SwiftUI

struct ContentView: View {
  @Environment(\.requestReview)
  var requestReview
  @ObservedObject var apiManager: APIManager
  @State private var city: String = ""
  @State private var numberOFDays = 2
  @FocusState private var cityIsFocused: Bool
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Number of Days")) {
          Stepper("Days:  \(numberOFDays)", value: $numberOFDays, in: 1...10)
        }
        HStack {
          TextField("", text: $city)
            .focused($cityIsFocused)
          Spacer()
//          Button {
//            Task {
//              try await apiManager.getItinerary(city: city, days: numberOFDays)
//            }
//          } label: {
//            Image(systemName: "magnifyingglass.circle")
//          }
//
          Button {
            requestReview()
          } label: {
            Image(systemName: "star")
          }

        }
        List {
          ForEach(apiManager.plan, id: \.day) { section in
            Section(header: Text("Day: \(section.day)")) {
              ForEach(section.activities, id: \.time) { item in

                Text(item.description)
                  .font(.headline)

              }
            }
          }
        }
      }.navigationTitle("City Itinerary")
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(apiManager: APIManager())
  }
}
