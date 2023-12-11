//
//  HelpPageViewControllerV2.swift
//  Onboarding
//
//  Created by hengyu on 2023/12/10.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

@available(iOS 15.0, macCatalyst 15.0, macOS 12.0, tvOS 15.0, visionOS 1.0, *)
public final class HelpPageViewControllerV2: UIHostingController<HelpView> {
    public init(items: [TipsItem]) {
        super.init(rootView: .init(items: items))
    }

    @available(*, unavailable)
    @MainActor required dynamic init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
#elseif canImport(AppKit)
import AppKit

@available(macOS 12.0, *)
public final class HelpPageViewControllerV2: NSHostingController<HelpView> {
    public init(items: [TipsItem]) {
        super.init(rootView: .init(items: items))
    }

    @available(*, unavailable)
    @MainActor required dynamic init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

#endif
