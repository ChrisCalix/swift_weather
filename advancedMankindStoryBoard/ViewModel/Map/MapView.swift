//
//  MapView.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 11/11/21.
//

import Foundation
import MapKit
import FloatingPanel
import CoreLocation

class MapView : UIViewController , SearchViewDelegate{
    
    private var mLocation: CLLocationCoordinate2D?
    private var mCountry: String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblCountry: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchV = SearchView()
        searchV.delegate = self
        let panel = FloatingPanelController()
        panel.set(contentViewController: searchV)
        panel.addPanel(toParent: self)
    }
    
    func setup(location: CLLocationCoordinate2D?){
        self.mLocation = location
    }
    
    func setMap(){
        guard let mLocation = mLocation else {
            return
        }
        let regionRadius : CLLocationDistance = 1000.0
        let region = MKCoordinateRegion(center: mLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        
        AddresLocation.getAddressFromLocation(location: mLocation, completion: {
            response in
            guard let response = response else {
                return
            }
            DispatchQueue.main.async {
                self.lblCountry.text = response
            }
        })
    }
    
    func serachView(_ vc: SearchView, country: String?, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        guard  let coordinates = coordinates else {
            return
        }
        
        guard let country = country else {
            return
        }
        mCountry = country
        //mCoordinates = coordinates
        
        lblCountry.text = country
        
        mapView.removeAnnotations(mapView.annotations)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        
        mapView.setRegion(MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(
                latitudeDelta: 0.7,
                longitudeDelta: 0.7
            )
        ), animated: true
        )
    }
    
    
    @IBAction func actionWeather(_ sender: Any) {
        guard let mLocation = mLocation else {
            return
        }
        
        performSegue(withIdentifier: "SearchtoWeather", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SearchtoWeather"){
            if let destination = segue.destination as? WeatherView {
                guard let mCountry = mCountry else {
                    return
                }
                destination.setup(setupLocation: mCountry)
            }
        }
    }
}
