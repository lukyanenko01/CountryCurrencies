//
//  APIService.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import Foundation

struct APIService {
    
    private let apiKey = "3844894a731115138aa742ea"
    
    public func fetchExchangeRate(baseCurrency: String, completion: @escaping ((ExchangeRateResponse?) -> Void)) {
        let urlString = "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(baseCurrency)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ExchangeRateResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
        }.resume()
    }
}
