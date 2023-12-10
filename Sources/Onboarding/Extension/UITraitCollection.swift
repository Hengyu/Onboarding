//
//  UITraitCollection.swift
//
//
//  Created by hengyu on 2020/10/8.
//

#if canImport(UIKit)
import UIKit

extension UITraitCollection {

    internal var needsLargeDisplay: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
}
#endif
