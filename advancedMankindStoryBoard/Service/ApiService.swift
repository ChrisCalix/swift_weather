//
//  ApiService.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 11/11/21.
//

import Foundation
class ApiService {
    private static let baseUrl : String = "https://api.openweathermap.org/"
    private static let epGetWeather: String = "data/2.5/weather"
    
    static func getWeather(parameters: [String: String], completion: @escaping (WeatherModel?, Error?) -> Void){
        var components = URLComponents(string: baseUrl + epGetWeather)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200 ..< 300 ~= response.statusCode,
                  error == nil
            else {
                completion(nil,error)
                return
            }
            do{
                let responseObject = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(responseObject, nil)
            }catch let error {
                print ("Error consume service \(error)")
            }
        }.resume()
    }
    
}
