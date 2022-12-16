//
//  Extension.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 12.12.2022.
//

import Foundation

extension String {
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
