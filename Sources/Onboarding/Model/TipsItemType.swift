//
//  TipsItemType.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

import Foundation

public protocol TitleContentProviding {
    var title: String { get }
    var content: String { get }
}

public protocol URLProviding {
    var url: URL? { get }
}

public protocol ImageProviding {
    var image: OBImage? { get }
}

public protocol TipsItemType: Hashable,
                              ImageProviding,
                              TitleContentProviding,
                              URLProviding { }
