//
//  PostCellViewModel.swift
//  socialmedia
//
//  Created by Pran Kishore on 14/04/24.
//

import Foundation

protocol PostCellViewModel {
    var postAuthorImagePath: URL? { get }
    var postMessageImagePath: URL? { get }
    var postHeaderText: String { get }
    var postSubheader: String { get }
}
