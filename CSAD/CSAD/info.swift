//
//  info.swift
//  CSAD
//
//  Created by Sarthak Mangla on 12/17/18.
//  Copyright © 2018 Sarthak Mangla. All rights reserved.
//

import UIKit
import CoreLocation

class info: UIViewController, UIImagePickerControllerDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate {
    var locationManager = CLLocationManager()
    var proof: Bool = false
    static var serverUrl = URL(string: "http://127.0.0.1:5000")
    static var request = URLRequest(url:info.serverUrl!)
    @IBOutlet weak var takepic: UIButton!
    @IBOutlet weak var lolcation: UILabel!
    @IBAction func gopressed(_ sender: Any) {
        info.request.httpMethod = "POST";
        info.request.setValue("x:\(locationManager.location?.coordinate.latitude)", forHTTPHeaderField: "lat")
        info.request.setValue("x:\(locationManager.location?.coordinate.longitude)", forHTTPHeaderField: "long")
        info.request.setValue("x:\(locationManager.location?.timestamp)", forHTTPHeaderField: "time")
        let task = URLSession.shared.dataTask(with: info.request) {
            data, response, error in
            if error != nil {
                print(error)
                return
            }
        }
        task.resume()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        }
        takepic.setImage(UIImage(named :"ButtonPressed2"), for: .normal)
        //var test1 = 1;
        //var test2 = 1;
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            proof = true
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
            //request.setValue(test1, forHTTPHeaderField: "username")
            //request.setValue(test2, forHTTPHeaderField: "")
        }
        performSegue(withIdentifier: "done",sender: (Any).self)
    }
    var img: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        info.request.setValue("x:\(locations.last?.coordinate.latitude)", forHTTPHeaderField: "lat")
        info.request.setValue("x:\(locations.last?.coordinate.longitude)", forHTTPHeaderField: "long")
        info.request.setValue("x:\(locations.last?.timestamp)", forHTTPHeaderField: "time")
    }
}


