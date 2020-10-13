//
//  UIButton.swift
//
//
//  Created by hengyu on 2020/10/7.
//

import UIKit

extension UIButton.ButtonType {

    static var adaptiveClose: UIButton.ButtonType {
        if #available(iOS 13.0, macCatalyst 13.0, tvOS 13.0, *) {
            #if os(tvOS)
            return .contactAdd
            #else
            return .close
            #endif
        } else {
            return .system
        }
    }
}

extension UIButton {

    static func makeClose() -> UIButton {
        let button = UIButton(type: .adaptiveClose)

        #if os(tvOS)
        button.setImage(.close, for: .normal)
        #else
        if #available(iOS 13.0, macCatalyst 13.0, *) {
        } else {
            button.setImage(.close, for: .normal)
            button.tintColor = .darkGray
            button.backgroundColor = .buttonBackground
            button.layer.masksToBounds = true
            button.layer.cornerRadius = Constants.Dimension.iconSmall / 2
        }
        #endif

        return button
    }
}
