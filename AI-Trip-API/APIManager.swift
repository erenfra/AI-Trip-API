//
//  APIManager.swift
//  AI-Trip-API
//
//  Created by Renato Oliveira Fraga on 6/9/23.
//

import Foundation

class APIManager: ObservableObject {
  @Published var plan = [Plan]()

  enum MediaError: Error {
    case requestFailed
    case responseDecodingFailed
    case urlCreationFailed
  }

  func getItinerary(city: String, days: Int = 3) async throws {

    let headers = [
      "X-RapidAPI-Key": "apy-key",
      "X-RapidAPI-Host": "ai-trip-planner.p.rapidapi.com"
    ]

    let urlString = String("https://ai-trip-planner.p.rapidapi.com/?days=\(days)&destination=\(city)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)

    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error as Any)
      } else {
        let _ = response as? HTTPURLResponse
      }

      if let decodedResponse = try? JSONDecoder().decode(APIModel.self, from: data!) {
        self.plan = decodedResponse.plan

      }
    })
    dataTask.resume()
  }
}
