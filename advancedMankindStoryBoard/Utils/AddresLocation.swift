//
//  AddresLocation.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 11/11/21.
//

import Foundation
import CoreLocation

class AddresLocation{
    static func getAddressFromLocation(location : CLLocationCoordinate2D, completion: @escaping (String?) -> Void){
        
        let ceo : CLGeocoder = CLGeocoder()
        
        let loc : CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemark, error) in
            if (error != nil) {
                print("Error")
            }
            let pm = placemark! as [CLPlacemark]
            
            if pm.count > 0{
                let pm = placemark![0]
                if pm.country != nil {
                    completion (pm.country)
                }
            }
        })
    }
}
