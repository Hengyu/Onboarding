//
//  Compatible.swift
//  Onboarding
//
//  Created by hengyu on 2023/12/10.
//

import SwiftUI

enum MoveDirection {
    case left
    case right
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
extension View {
    @ViewBuilder func adaptiveSizeBasedScrollBouncesBehavior(_ axes: Axis.Set) -> some View {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            scrollBounceBehavior(.basedOnSize, axes: axes)
        } else {
            self
        }
    }

    @ViewBuilder func adaptiveFocusable() -> some View {
        if #available(iOS 17.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            focusable()
        } else {
            self
        }
    }

    @ViewBuilder func adaptiveOnMoveKeyPress(perform: @escaping (MoveDirection) -> Void) -> some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, *) {
            onKeyPress { keyPress in
                if keyPress.key == .rightArrow {
                    perform(.right)
                    return .handled
                } else if keyPress.key == .leftArrow {
                    perform(.left)
                    return .handled
                }
                return .ignored
            }
        } else {
            self
        }
    }
}
