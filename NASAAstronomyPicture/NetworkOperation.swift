//
//  NetworkOperation.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

import Foundation

class NetworkOperation {
    
    class func fetchAstronomyPicture(of date: String,
                                     completion: @escaping (_ response: PictureOfDateModel?,
                                                            _ error: Error?) -> Void) async {
        // Create GET request
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "date", value: date),
            URLQueryItem(name: "api_key", value: "DEMO_KEY")
        ]
        
        guard let urlComponents = urlComponents,
              let url = urlComponents.url else {
                  completion(nil, ServiceError.unsuppotedURL)
                  return
              }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, ServiceError.unknownError)
                return
            }
            if let response = try? JSONDecoder().decode(PictureOfDateModel.self, from: data) {
                if response.msg == nil,
                   response.date == nil,
                   response.url == nil {
                    completion(nil, ServiceError.unknownError)
                    return
                }
                completion(response, nil)
            }
        }
        task.resume()
    }
}
