//
//  Image.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

#if canImport(UIKit)
import UIKit

public typealias OBImage = UIKit.UIImage

#elseif canImport(AppKit)
import AppKit

public typealias OBImage = AppKit.NSImage

#else

public typealias OBImage = Data

#endif
