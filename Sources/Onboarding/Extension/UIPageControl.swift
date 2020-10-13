//
//  UIPageControl.swift
//
//
//  Created by hengyu on 2020/10/13.
//

import UIKit

extension UIPageControl {

    internal func roundedRectSize(forNumberOfPages pages: Int? = nil) -> CGSize {
        assert(pages ?? 0 >= 0, "Number of pages should not less than 0")
        var result = size(forNumberOfPages: max(pages ?? numberOfPages, 0))
        result.width += Constants.Dimension.widthPaddingSmall
        result.height = min(result.height, Constants.Dimension.iconTiny)
        return result
    }

    @discardableResult
    internal func setProminentBackground() -> Bool {
        if #available(iOS 14.0, macCatalyst 14.0, tvOS 14.0, *) {
            #if targetEnvironment(macCatalyst)
            // Temporarily disable for macCatalyst since compiler will
            // throw error when building for macCatalyst 13
            return false
            #else
            backgroundStyle = .prominent
            return true
            #endif
        } else {
            #if os(tvOS)
            // looks like `UIPageControl` has its own visual effect on tvOS
            return true
            #else
            return false
            #endif
        }
    }
}
