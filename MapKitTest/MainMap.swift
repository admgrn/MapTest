//
//  MainMap.swift
//  MapKitTest
//
//  Created by Greenstein on 10/23/14.
//  Copyright (c) 2014 Greenstein. All rights reserved.
//

import UIKit
import MapKit

class MainMap: MKMapView, MKMapViewDelegate {
    var dist = CLLocationDistance(0);
    
    override init() {
        super.init();
        mapType = MKMapType.Standard;
        delegate = self;
        mapType = MKMapType.Standard;
        zoomEnabled = true;
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        delegate = self;
        mapType = MKMapType.Standard;
        zoomEnabled = true;
    }
    
    
    func updatePoints(coordinates : NSMutableArray) {
        var points = UnsafeMutablePointer<CLLocationCoordinate2D>.alloc(coordinates.count);
        
        var distance = CLLocationDistance(0);
        
        for (var i = 0; i < coordinates.count; ++i)
        {
            points[i] = (coordinates.objectAtIndex(i) as CLLocation).coordinate;
            
            if (i + 1 < coordinates.count)
            {
                distance += (coordinates.objectAtIndex(i) as CLLocation).distanceFromLocation((coordinates.objectAtIndex(i + 1) as CLLocation));
            }
        }
        
        var item = MKPolyline(coordinates: points, count: coordinates.count);
        addOverlay(item, level: MKOverlayLevel.AboveLabels);
        setVisibleMapRect(item.boundingMapRect, animated: true);
        points.dealloc(coordinates.count);
        dist = distance;
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let rend = MKPolylineRenderer(overlay: overlay);
        rend.strokeColor = UIColor.blueColor();
        rend.lineWidth = 2;
        return rend;
        
    }
    
}