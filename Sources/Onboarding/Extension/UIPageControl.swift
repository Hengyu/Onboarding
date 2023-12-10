//
//  UIPageControl.swift
//
//
//  Created by hengyu on 2020/10/13.
//

#if canImport(UIKit)
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
            backgroundStyle = .prominent
            return true
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
#endif
