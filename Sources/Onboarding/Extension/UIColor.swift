//
//  UIColor.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

#if canImport(UIKit)
import UIKit

extension UIColor {

    internal class var defaultBackground: UIColor {
        #if os(tvOS)
        .clear
        #else
        .systemBackground
        #endif
    }

    internal class var groupedBackground: UIColor {
        #if os(tvOS)
        return UIColor { trait in
            if trait.userInterfaceStyle == .dark {
                return UIColor(white: 0.4, alpha: 0.3)
            } else {
                return UIColor(white: 0.6, alpha: 0.3)
            }
        }
        #else
        return .tertiarySystemGroupedBackground
        #endif
    }

    internal class var buttonBackground: UIColor {
        .init(white: 0.85, alpha: 0.7)
    }

    internal class var defaultLabel: UIColor {
        .label
    }

    internal class var defaultSecondaryLabel: UIColor {
        .secondaryLabel
    }

    internal class var currentPageIndicator: UIColor {
        defaultLabel
    }

    internal class var pageIndicator: UIColor {
        .tertiaryLabel
    }
}

#elseif canImport(AppKit)
import AppKit

extension NSColor {
    internal class var defaultBackground: NSColor {
        .windowBackgroundColor
    }

    internal class var groupedBackground: NSColor {
        .separatorColor
    }
}

#endif
