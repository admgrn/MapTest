//
//  DataAccess.swift
//  MapKitTest
//
//  Created by Greenstein on 11/15/14.
//  Copyright (c) 2014 Greenstein. All rights reserved.
//

import UIKit
import Parse

class DataAccess: NSObject {
    
    func SaveCoordinates(coordinates : NSArray) {
        var pfCoordArray : [PFGeoPoint] = [];
        
        for coordinate in coordinates {
            let realCoord = coordinate as CLLocation;
            let newCoord = PFGeoPoint(latitude: realCoord.coordinate.latitude, longitude: realCoord.coordinate.longitude);
            pfCoordArray.append(newCoord);
        }
        
        var coord = PFObject(className: "Coordinates");
        coord.addObjectsFromArray(pfCoordArray, forKey: "Location");
        coord.saveInBackgroundWithBlock(nil);
    }
    
    func GetObjects() -> [SessionInfo] {
        var outputList : [SessionInfo] = [];
        
        var query = PFQuery(className: "Coordinates");
        query.limit = 50;
        var objects = query.findObjects();
        let format = NSDateFormatter();
        format.dateFormat = "dd-MM-yyyy hh:mm";
        
        for obj in objects {
            let realObj = obj as PFObject;
            let date = realObj.updatedAt;
            let id = realObj.objectId;
            
            if (date != nil) {
                let sess = SessionInfo(id: id, withTime: format.stringFromDate(date));
                outputList.append(sess);
            }
        }
        return outputList;
    }
    
    func GetCoordinates(objectID : NSString) -> NSMutableArray {
        var coordinates = NSMutableArray();
        
        var coords = PFQuery(className: "Coordinates");
        var object = coords.getObjectWithId(objectID);
        var objects = object.objectForKey("Location") as NSArray;
        
        for coordinate in objects {
            let objCoord = coordinate as PFGeoPoint;
            var realCoord = CLLocation(latitude: objCoord.latitude, longitude: objCoord.longitude);
            
            coordinates.addObject(realCoord);
        }
        
        return coordinates;
    }
}