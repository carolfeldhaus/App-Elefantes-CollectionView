//
//  API.swift
//  Elefantes
//
//  Created by Wilson Baraban Filho on 10/18/21.
//

import Foundation

struct API {
    
    // https://elephant-api.herokuapp.com/elephants
    
    let baseURL = "https://elephant-api.herokuapp.com"
    
    /// Returns the URL string to endpoint: /elephants
    private var elephantsURL: String {
        return "\(self.baseURL)/\(EndPoints.elephants)"
    }
    
    
    func getElephants(completion: @escaping ([Elefante]?, Error?) -> Void) {
        
        // Criar array de elefante
        var arrayDeElefantes : [Elefante] = []
        // Config sessão
        let config: URLSessionConfiguration = .default
        // Sessão
        let session: URLSession = URLSession(configuration: config)
        // URL
        guard let url: URL = URL(string: self.elephantsURL) else {
            completion(nil, ErrorAPI.noURL)
            return
        }
        // URL Request
        var urlRequest: URLRequest = URLRequest(url: url)
        // URL Request -> Method (GET)
        urlRequest.httpMethod = "\(HTTPMethod.GET)"
        // EXEC request HTTP
        let task = session.dataTask(with: urlRequest, completionHandler: { (result, urlResponse, error) in
            
            var statusCode: Int = 0
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            
            guard let data = result else {
                completion(nil, ErrorAPI.noData)
                return
            }
            print(urlRequest)
            do {
                // criar um decoder
                let decoder : JSONDecoder = JSONDecoder()
                // decodificar
                let decodeData: [Elefante] = try decoder.decode([Elefante].self, from: data)
                arrayDeElefantes = decodeData
                completion(arrayDeElefantes, nil)
                
            } catch let error {
                // error
                debugPrint("Status code: \(statusCode), Error: \(error.localizedDescription)")
                completion(nil, ErrorAPI.decodeFailed)
            }
            
        })
        
        task.resume()
    }
    
}



