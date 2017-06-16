//
//  SampleData.swift
//  RideApp
//
//  Created by Yan Futerman on 16/06/2017.
//  Copyright © 2017 Yan Futerman. All rights reserved.
//

import Foundation

//Set up sample data

let eventRidesData = [
    EventRide(eventName:"Shdema test", eventDateTime:"July 5, 12:00", tmpRating: 4),
    EventRide(eventName: "HF congress", eventDateTime: "August 3, 10:00", tmpRating: 5),
    EventRide(eventName: "C# course", eventDateTime: "July 14, 9:00", tmpRating: 2) ]


let groupsData = [
    GroupRide(groupName:"Nofit", groupDestination:"", groupOrigin: "Nofit"),
    GroupRide(groupName:"Technion", groupDestination:"Technion", groupOrigin: ""),
    GroupRide(groupName:"Shimshit", groupDestination:"", groupOrigin: "Shimshit") ]


let companyRidesData = [
    CompanyRide(rideOrigin:"Leshem", rideDestination:"David", rideTime: "20.06.2017, 12:00"),
    CompanyRide(rideOrigin:"David", rideDestination:"Leshem", rideTime: "25.06.2017, 10:00"),
    CompanyRide(rideOrigin:"Leshem", rideDestination:"David", rideTime: "30.06.2017, 15:00") ]


