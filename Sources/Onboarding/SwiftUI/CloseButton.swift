//
//  CloseButton.swift
//  Onboarding
//
//  Created by hengyu on 2023/12/11.
//

import SwiftUI

#if os(visionOS) || os(macOS) || os(tvOS)
struct CloseButton: View {
    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
        }
        #if os(visionOS)
        .buttonBorderShape(.circle)
        #endif
    }
}
#elseif os(iOS)

import UIKit

/// We want to recreate a SwiftUI view that looks like the Apple system close button.
///
/// - Remark: See at [Stack Overflow](https://stackoverflow.com/questions/73302804)
struct CloseButton: UIViewRepresentable {
    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .close)
        button.addTarget(context.coordinator, action: #selector(Coordinator.perform), for: .primaryActionTriggered)
        return button
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        context.coordinator.action = action
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }

    class Coordinator {
        var action: () -> Void

        init(action: @escaping () -> Void) {
            self.action = action
        }

        @objc func perform() {
            action()
        }
    }
}
#endif
