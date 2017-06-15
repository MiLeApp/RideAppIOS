//
//  EventRide.swift
//  RideApp
//
//  Created by Yan Futerman on 16/06/2017.
//  Copyright © 2017 Yan Futerman. All rights reserved.
//

import Foundation

struct EventRide {
    var eventName: String?
    var eventDateTime: String?
    var tmpRating: Int
    
    init(eventName: String?, eventDateTime: String?, tmpRating: Int) {
        self.eventName = eventName
        self.eventDateTime = eventDateTime
        self.tmpRating = tmpRating
    }
}

