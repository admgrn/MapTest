//
//  StartViewController.swift
//  MapKitTest
//
//  Created by Greenstein on 11/14/14.
//  Copyright (c) 2014 Greenstein. All rights reserved.
//

import UIKit
import MapKit
import Parse

class StartViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var StartStopButton: UIButton!
    
    var IsRunning = false;
    var manager = CLLocationManager();
    var coordinates = NSMutableArray();
    var SessionItems : [SessionInfo] = [];
    var data = DataAccess();
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        manager.delegate = self;
        manager.pausesLocationUpdatesAutomatically = true;
    }
    
    override func viewWillAppear(animated: Bool) {
        SessionItems = data.GetObjects();
    }
    
    @IBAction func StartStop(sender: AnyObject) {
        if (IsRunning) {
            mainTable.hidden = false;
            manager.stopUpdatingLocation();
            StartStopButton.setTitle("Start", forState: UIControlState.Normal);
            IsRunning = false;
        
            var map  = storyboard?.instantiateViewControllerWithIdentifier("MainMap") as MapViewController;
            
            map.coordinates.removeAllObjects();
            map.coordinates = coordinates;
            data.SaveCoordinates(map.coordinates);
            
            presentViewController(map, animated: true, completion: nil);
        } else {
            mainTable.hidden = true;
            manager.requestWhenInUseAuthorization();
            manager.startUpdatingLocation();
            StartStopButton.setTitle("Stop", forState: UIControlState.Normal);
            IsRunning = true;
            coordinates.removeAllObjects();
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        coordinates.addObject(newLocation);
        NSLog("%d", coordinates.count);
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier("MainCell") as UITableViewCell;
            var label = (cell.contentView.viewWithTag(1) as UILabel);
            
            label.text = SessionItems[indexPath.item].time;
            
            return cell;
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return SessionItems.count;
    }
    
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var coordinates = data.GetCoordinates(SessionItems[indexPath.item].id);
        
        var map  = storyboard?.instantiateViewControllerWithIdentifier("MainMap") as MapViewController;
        
        map.coordinates.removeAllObjects();
        map.coordinates = coordinates;
        
        presentViewController(map, animated: true, completion: nil);
    }
}