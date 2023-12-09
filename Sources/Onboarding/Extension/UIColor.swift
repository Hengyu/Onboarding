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
        return .clear
        #else
        if #available(iOS 13.0, macCatalyst 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
        #endif
    }

    internal class var groupedBackground: UIColor {
        if #available(iOS 13.0, tvOS 13.0, *) {
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
        } else {
            #if os(tvOS) || os(visionOS)
            return UIColor(white: 0.6, alpha: 0.3)
            #else
            return .groupTableViewBackground
            #endif
        }
    }

    internal class var buttonBackground: UIColor {
        .init(white: 0.85, alpha: 0.7)
    }

    internal class var defaultLabel: UIColor {
        if #available(iOS 13.0, macCatalyst 13.0, tvOS 13.0, *) {
            return .label
        } else {
            #if os(tvOS)
            return .black
            #else
            return .darkText
            #endif
        }
    }

    internal class var defaultSecondaryLabel: UIColor {
        if #available(iOS 13.0, macCatalyst 13.0, tvOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .darkGray
        }
    }

    internal class var currentPageIndicator: UIColor {
        defaultLabel
    }

    internal class var pageIndicator: UIColor {
        if #available(iOS 13.0, macCatalyst 13.0, tvOS 13.0, *) {
            return .tertiaryLabel
        } else {
            return .lightGray
        }
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
