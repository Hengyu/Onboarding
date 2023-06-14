//
//  UIEdgeInsets.swift
//
//
//  Created by hengyu on 2020/10/9.
//

import UIKit

extension UIEdgeInsets {

    func with(bottom: CGFloat) -> UIEdgeInsets {
        var result = self
        result.bottom = bottom
        return result
    }

    var directional: NSDirectionalEdgeInsets {
        .init(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
