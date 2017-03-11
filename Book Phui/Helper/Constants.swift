//
//  Constants.swift
//  XLProjectName
//
//  Created by XLAuthorName ( XLAuthorWebsite )
//  Copyright (c) 2016 XLOrganizationName. All rights reserved.
//

import Foundation

struct Constants {

	struct Network {
        static let baseUrl = NSURL(string: "https://api.github.com")!
        static let AuthTokenName = "Authorization"
        static let SuccessCode = 200
        static let successRange = 200..<300
        static let Unauthorized = 401
        static let NotFoundCode = 404
        static let ServerError = 500
    }
    
    struct Debug {
        static let crashlytics = false
        static let jsonResponse = false
    }
    
    struct StoryBoardID {
        static let MainViewControllerID = "MainViewController"
        static let LoginViewControllerID = "LoginViewController"
        static let ListFieldViewControllerID = "ListFieldViewController"
        static let FieldCellID = "FieldCell"
        static let TimeCellID = "TimeCell"
        static let StadiumViewCellID = "StadiumViewCell"
    }
    
    struct ConstantsString {
        static let GoogleMapAPIKey = "AIzaSyCDsnW_PJz4w72JSNMAwZU-ShGv19BFxQ0"
        
    }
}
