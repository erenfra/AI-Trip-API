//
//  APIManager.swift
//  AI-Trip-API
//
//  Created by Renato Oliveira Fraga on 6/9/23.
//

import Foundation

class APIManager: ObservableObject {
    @Published var plan = [Plan]()
    let country: String = "UK"
    let city: String = "London"
    let days: Int = 3
    
    enum MediaError: Error {
         case requestFailed
         case responseDecodingFailed
         case urlCreationFailed
       }

    func getRate() async throws {
       
        let headers = [
            "X-RapidAPI-Key": "14df2f2c86msh7da077531c8017fp13b66fjsn561ff3066976",
            "X-RapidAPI-Host": "ai-trip-planner.p.rapidapi.com"
        ]


        let request = NSMutableURLRequest(url: NSURL(string: "https://ai-trip-planner.p.rapidapi.com/?days=\(days)&destination=\(city)%2C\(country)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            
            let output = String(data: data!, encoding: .utf8)
            
            if let decodedResponse = try? JSONDecoder().decode(APIModel.self, from: data!) {
                self.plan = decodedResponse.plan
            }
        })

        dataTask.resume()
        
        
    }
    
    
}
