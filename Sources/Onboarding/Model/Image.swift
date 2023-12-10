//
//  Image.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

public typealias OBImage = UIKit.UIImage

extension Image {
    init(obImage: OBImage) {
        self.init(uiImage: obImage)
    }
}

#elseif canImport(AppKit)
import AppKit

public typealias OBImage = AppKit.NSImage

extension Image {
    init(obImage: OBImage) {
        self.init(nsImage: obImage)
    }
}

#else

public typealias OBImage = Data

#endif
