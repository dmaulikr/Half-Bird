//
//  DataManager.swift
//  Book Phui
//
//  Created by Thanh Tran on 3/11/17.
//  Copyright © 2017 Half Bird. All rights reserved.
//

import Foundation

class Api {
    private static var transactions: [Transaction] = []
    static let sharedInstance = Api()
    
    static func getAroundStadiums(completion: @escaping ([Stadium]) -> Void) {
        Util.delay(0.2) {
            if let data = Util.readFile(name: "001", type: "json") {
                let arrayDictRaw = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [NSDictionary]
                if let arrayDict = arrayDictRaw {
                    var result: [Stadium] = []
                    
                    for dict in arrayDict {
                        result.append(Stadium(dictionary: dict))
                    }
                    
                    completion(result)
                }
            }
        }
    }
    
    static func getHistory(completion: @escaping ([Transaction]) -> Void) {
        Util.delay(0.2) {
            if transactions.isEmpty, let data = Util.readFile(name: "002", type: "json") {
                let arrayDictRaw = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [NSDictionary]
                if let arrayDict = arrayDictRaw {
                    var result: [Transaction] = []
                    
                    for dict in arrayDict {
                        result.append(Transaction(dictionary: dict))
                    }
                    
                    completion(result)
                }
            }
            else {
                completion(Api.transactions)
            }
        }
    }
}
