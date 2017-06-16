//
//  GroupRide.swift
//  RideApp
//
//  Created by Yan Futerman on 16/06/2017.
//  Copyright © 2017 Yan Futerman. All rights reserved.
//

import Foundation

struct GroupRide {
    var groupName: String?
    var groupDestination: String?
    var groupOrigin: String?
    
    init(groupName: String?, groupDestination: String?, groupOrigin: String?) {
        self.groupName = groupName
        self.groupDestination = groupDestination
        self.groupOrigin = groupOrigin
    }
}
