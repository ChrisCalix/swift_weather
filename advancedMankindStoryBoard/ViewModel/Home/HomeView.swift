//
//  Home.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 11/11/21.
//

import Foundation
import MaterialComponents
import CoreLocation

class HomeView: UIViewController {
    
    private var locationMAnager: CLLocationManager?
    var textController: MDCTextInputControllerOutlined!
    private var mLocation : CLLocationCoordinate2D?
    
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tfCity: MDCTextField!
    @IBOutlet weak var btnMap: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserLocation()
        
        guard let tfCity = tfCity as? MDCTextField else {
            return
        }
        
        self.textController = MDCTextInputControllerOutlined(textInput: tfCity)
        self.textController.textInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        self.textController.activeColor = UIColor.lightGray
        self.textController.floatingPlaceholderActiveColor = UIColor.systemGreen
    }
    
    func getUserLocation(){
        locationMAnager = CLLocationManager()
        locationMAnager?.requestAlwaysAuthorization()
        locationMAnager?.startUpdatingLocation()
        locationMAnager?.delegate = self
       // locationMAnager?.allowsBackgroundLocationUpdates = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toWeather"){
            if let destination = segue.destination as? WeatherView {
                destination.setup(setupLocation: tfCity.text!)
            }
        }
        if (segue.identifier == "toMap"){
            if let destination = segue.destination as? MapView{
                destination.setup(location: mLocation)
            }
        }
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        if tfCity.text!.count > 3 {
            performSegue(withIdentifier: "toWeather", sender: nil)
        }
        
    }
    @IBAction func actionMap(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    
    
    
}

extension HomeView : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            mLocation = location.coordinate
            AddresLocation.getAddressFromLocation(location : mLocation!, completion: {
                response in
                guard let response = response else {
                    return
                }
                DispatchQueue.main.async {
                   
                    self.tfCity.text = response
                }
            })
          //  self.getAddressFromLocation(lat: location.coordinate.latitude, long: location.coordinate.longitude)
            //self.tfCity.text = "\(location.coordinate.latitude) , \(location.coordinate.longitude)"
        }
    }
}
