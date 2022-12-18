//
//  CALayer+Extensions.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 16.12.2022.
//

import Foundation
import UIKit

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: frame.height/4, width: thickness, height: frame.height/2)
        default:
            break
        }
        border.backgroundColor = color.cgColor
        addSublayer(border)
    }
}
