//
//  Connectivity.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 18.12.2022.
//

import Foundation
import Alamofire


struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        let connected = self.sharedInstance.isReachable
        return connected
    }
}
