//
//  MapViewController.swift
//  MapKitTest
//
//  Created by Greenstein on 11/14/14.
//  Copyright (c) 2014 Greenstein. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var mapView: MainMap!
    
    var coordinates = NSMutableArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.updatePoints(coordinates);
        distance.text = NSString(format: "Distance: %.2f miles", mapView.dist * 0.000621371);
    }
    
    @IBAction func Back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}