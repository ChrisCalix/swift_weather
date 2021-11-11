//
//  WeatherView.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 11/11/21.
//
import UIKit
import Foundation

class WeatherView : UIViewController{
    
    private let viewModel = WeatherViewModel()
    private var location : String = ""
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblLatLng: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var iv_loading: UIActivityIndicatorView!
    
    @IBOutlet weak var lblThermal: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI
        
        
        viewModel.weatherModel.bind{[weak self] resp in
            guard let data = resp?.name else {
                return
            }
            DispatchQueue.main.async {
                self?.lblCity.text = resp?.name
                let latStr : String = String((resp?.coord?.lat)!)
                let lngStr : String = String((resp?.coord?.lon)!)
                self?.lblLatLng.text = "Lat: "+latStr + " Lng: "+lngStr
                let tempStr: String = String(Int((resp?.main?.temp)! - 273.15))
                self?.lblTemp.text = "\(tempStr) °C"
                
                let feelLikeStr: String = String(Int((resp?.main?.feels_like)! - 273.15))
                self?.lblThermal.text = "\(feelLikeStr) °C"
                self?.lblHumidity.text = String((resp?.main?.humidity)!)
                self?.lblPressure.text = String((resp?.main?.pressure)!)
                self?.lblWind.text = String((resp?.wind?.speed)!)
                
                self?.iv_loading.stopAnimating()
                //self?.et.text = data
            }
        }
        iv_loading.isHidden = false
        iv_loading.startAnimating()
        viewModel.getWeather(location: self.location, completion: {
            error in
            if error == true {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "City Not Found ", message: "Your country weather not found, input other country or choose in Map", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self.navigationController?.popViewController(animated: true)
                            break
                        default:
                            break
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                    self.iv_loading.stopAnimating()
                }
            }
            
        })
    }
    
    func setup(setupLocation: String){
        self.location = setupLocation
    }
}
