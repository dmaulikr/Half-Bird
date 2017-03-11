//
//  Stadium.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import Foundation

class Stadium: NSObject {
    var thumbnailUrl: String?
    var name: String?
    var address: String?
    var opennedTime: String?
    var closedTime: String?
    var rating: Double = 0
    var numberOfSubYards: Int = 0
    
    static var periodOfTime: [String] = [
        "06:00-08:00",
        "08:00-10:00",
        "10:00-12:00",
        "12:00-14:00",
        "14:00-16:00",
        "16:00-18:00",
        "18:00-20:00",
        "20:00-22:00",
    ]
}
