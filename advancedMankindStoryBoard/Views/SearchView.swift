//
//  SearchView.swift
//  advancedMankindStoryBoard
//
//  Created by Christian Calixto on 11/11/21.
//

import Foundation
import UIKit
import CoreLocation

protocol SearchViewDelegate: AnyObject{
    func serachView(_ vc: SearchView, country: String?, didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}

class SearchView : UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate : SearchViewDelegate?
    
    private let leabel : UILabel = {
        let label = UILabel()
        label.text = "Where To"
        label.font = .systemFont(ofSize: 24,weight: .semibold)
        return label
    }()
    private let field: UITextField = {
       let field = UITextField()
        field.placeholder = "Enter destination"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        field.leftViewMode = .always
        return field
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(leabel)
        view.addSubview(field)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
    
        field.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        leabel.sizeToFit()
        leabel.frame = CGRect(x: 10, y: 10, width: leabel.frame.size.width, height: leabel.frame.size.height)
        field.frame = CGRect(x: 10, y: 20 + leabel.frame.size.height, width: view.frame.size.width-20, height: 50)
        let tableY: CGFloat = field.frame.origin.y  + field.frame.size.height + 5
        tableView.frame = CGRect(x: 0, y: tableY, width: view.frame.size.width, height: view.frame.size.height-tableY)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = field.text, !text.isEmpty {
            LocationManager.shared.findLocation(with: text){  [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Notifiy map controller to show pin at seletected
        let coordinate = locations[indexPath.row].coordinates
        
        delegate?.serachView(self, country: locations[indexPath.row].title, didSelectLocationWith: coordinate)
    }
}
