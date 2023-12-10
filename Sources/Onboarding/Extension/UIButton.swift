//
//  UIButton.swift
//
//
//  Created by hengyu on 2020/10/7.
//

#if canImport(UIKit)
import UIKit

extension UIButton.ButtonType {

    static var adaptiveClose: UIButton.ButtonType {
        #if os(tvOS)
        return .contactAdd
        #else
        return .close
        #endif
    }
}

extension UIButton {

    static func makeClose() -> UIButton {
        let button = UIButton(type: .adaptiveClose)

        #if os(tvOS)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        #elseif os(visionOS)
        button.configuration = .bordered()
        #endif

        return button
    }
}
#endif
