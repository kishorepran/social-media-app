//
//  AppConstants.swift
//  socialmedia
//
//  Created by Pran Kishore on 13/04/24.
//

import UIKit

struct Constants {
    struct Text {
        static let phoneGalleryAccess = "Social Media App does not have access to your phone's gallery. Please grant access"
        static let unknownError = "Unknown error"
        static let postMessagePlaceHolder = "Enter your post message here"
    }
    
    struct UI {
        static let screenWidth = UIScreen.main.bounds.width - 16
        static let screenHeight = UIScreen.main.bounds.height / 3
    }
}


enum PostViewMode: String, CaseIterable {
    case mine
    case allPost
}
