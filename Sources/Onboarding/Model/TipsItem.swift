//
//  TipsItem.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

import Foundation

public struct TipsItem: TipsItemType, Identifiable {
    public let title: String
    public let content: String
    public let url: URL?
    public let image: OBImage?

    public var id: Int {
        hashValue
    }

    public init(title: String, content: String, url: URL? = nil, image: OBImage? = nil) {
        self.title = title
        self.content = content
        self.url = url
        self.image = image
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(content)
        hasher.combine(url)
        hasher.combine(image)
    }

    public static func == (lhs: TipsItem, rhs: TipsItem) -> Bool {
        lhs.title == rhs.title &&
        lhs.content == rhs.content &&
        lhs.url == rhs.url &&
        lhs.image == rhs.image
    }
}

extension TipsItem {

    internal static let mock: TipsItem = .init(title: "Intro", content: "Content")
}
