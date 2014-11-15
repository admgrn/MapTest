//
//  SessionInfo.swift
//  MapKitTest
//
//  Created by Greenstein on 11/15/14.
//  Copyright (c) 2014 Greenstein. All rights reserved.
//

import UIKit

class SessionInfo: NSObject {
    var id : NSString;
    var time : NSString;
    
    init(id : NSString, withTime time: NSString) {
        self.id = id;
        self.time = time;
        super.init();
    }
}