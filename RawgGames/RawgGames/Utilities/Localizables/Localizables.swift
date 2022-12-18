//
//  Localizables.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 17.12.2022.
//

import Foundation

protocol GenericValueProtocol{
    associatedtype value
    var value: value {get}
}

enum Localizables: String, GenericValueProtocol{
    typealias value = String
    
    var value: String{
        return rawValue.toLocalize()
    }
    
    case favoritesPlaceHolderTitle  = "favoritesPlaceHolderTitle"
    case thousandShortening = "thousandShortening"
    case reviews = "reviews"
    case released = "released"
    case downloads = "downloads"
    case developers = "developers"
    case unknown = "unknown"
    case noDescription = "noDescription"
    case search = "search"
    case browseGames = "browseGames"
    case tryAgain = "tryAgain"
    case warning = "warning"
    case emptyNoteMessage = "emptyNoteMessage"
    case highestRating = "highestRating"
    case mostReviewed = "mostReviewed"
    case favoritesNotificationTitle = "favoritesNotificationTitle"
    case favoritesNotificationBody = "favoritesNotificationBody"
    case gameNotFound = "gameNotFound";
    case error = "error"

}
