//
//  Transaction.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import Foundation
import EVReflection

class Transaction: EVObject {
    var stadium: Stadium?
    var id: Int = 0
    var stadiumId: Int = 0
    var periodOfTime: String?
    var bookedDate: Date?
    var note: String?
}
