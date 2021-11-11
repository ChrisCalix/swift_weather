//
//  WeatherViewModel.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 10/11/21.
//

import Foundation
class WeatherViewModel{
    
    //var users: Observable<[UserTableViewCellViewModel]> = Observable([])
    
    var weatherModel: Observable<WeatherModel> = Observable(nil)
    
    func getWeather(location: String, completion: @escaping (Bool) -> Void){
        ApiService.getWeather(parameters: ["q":location,"appid":"8e92712caf6e1f09280f4888fb910173"], completion: {response, error in
            if error != nil {
                completion(true)
                return
            }
            guard let response = response else{
                print("error _ viewModel \(error) desconocido" )
                return
            }
            self.weatherModel.value = response
        })
    }
}
