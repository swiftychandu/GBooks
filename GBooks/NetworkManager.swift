//
//  NetworkManager.swift
//  GBooks
//
//  Created by chandrasekhar yadavally on 4/13/20.
//  Copyright © 2020 chandrasekhar yadavally. All rights reserved.
//

import Foundation
import SCLAlertView

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://www.googleapis.com/books/v1/volumes?q="

    
    func fetchBooks(for query: String, completion:@escaping (Data?, GBError?) -> Void) {
        let endPoint = baseUrl + query
        guard let url = URL(string: endPoint) else {
            DispatchQueue.main.async {
                let alert = SCLAlertView()
                alert.showError("Invalid Query", subTitle: "Please try again")
            }
            return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, GBError.connectionError)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, GBError.invalidResponse)
                return
            }
            guard let data = data else {
                completion(nil, GBError.invalidData)
                print("Error 2")
                return
            }
            completion(data, nil)
            
        }.resume()
    }
}
