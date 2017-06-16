//
//  CompanyRide.swift
//  RideApp
//
//  Created by Yan Futerman on 16/06/2017.
//  Copyright © 2017 Yan Futerman. All rights reserved.
//

import Foundation


struct CompanyRide {
    var rideTime: String?
    var rideDestination: String?
    var rideOrigin: String?
    
    init(rideOrigin: String?, rideDestination: String?, rideTime: String?) {
        self.rideOrigin = rideOrigin
        self.rideDestination = rideDestination
        self.rideTime = rideTime
    }
}
