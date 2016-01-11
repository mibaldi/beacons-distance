//
//  ViewController.swift
//  ejemploibeacons
//
//  Created by mikel balduciel diaz on 20/12/15.
//  Copyright © 2015 mikel balduciel diaz. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "2f234454-cf6d-4a0f-adf2-f4911ba9ffa6")!, identifier: "RadBeacon Mikel")

    let colors = [
        
        354523: UIColor(red: 67/255, green: 33/255, blue: 160/255, alpha:1),
        646456: UIColor(red: 67/255, green: 33/255, blue: 160/255, alpha:1),
        997566: UIColor(red: 67/255, green: 33/255, blue: 160/255, alpha:1),
        
    ]
    @IBOutlet weak var cajadistancia: UITextView!
    
    @IBOutlet weak var cajatexto: UITextView!
    @IBOutlet weak var nombre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate=self
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
            cajatexto.text="hola2"
        }
        locationManager.startRangingBeaconsInRegion(region)
        cajatexto.text="hola3"
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion){
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if knownBeacons.count > 0 {
            let closestBeacon = knownBeacons[0] as CLBeacon
            var t = ""
            nombre.text = region.identifier
            //print( closestBeacon.accuracy.description)
            var texto = "\(closestBeacon.accuracy)"
            self.cajadistancia.text = "\(cajadistancia.text) \(texto)"
            if closestBeacon.accuracy > 3 {
                cajatexto.text = "se alejo"
            }else{
                cajatexto.text = "sige cerca"
            }
        }
        else {
            
            cajatexto.text = "no se encuentran dispositivos"
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.locationManager.startRangingBeaconsInRegion(self.region)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.locationManager.stopRangingBeaconsInRegion(self.region)
    }

    


}

