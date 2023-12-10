//
//  HelpView.swift
//  Onboarding
//
//  Created by hengyu on 2023/12/9.
//

import SwiftUI
import UIKit

@available(iOS 15.0, macCatalyst 15.0, macOS 12.0, tvOS 15.0, visionOS 1.0, *)
public struct HelpView: View {
    public let items: [TipsItem]
    @State private var selection: Int = 0
    @Environment(\.dismiss) private var dismiss

    public init(items: [TipsItem]) {
        self.items = items
    }

    public var body: some View {
        ZStack(alignment: .topTrailing) {
            TabView(selection: $selection) {
                ForEach(0 ..< items.count, id: \.self) { index in
                    SwiftTipsView(tips: items[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            #if os(iOS) || os(tvOS) || os(visionOS)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            #endif
            .animation(.easeInOut, value: selection)
            .transition(.slide)

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.semibold))
                    #if os(iOS) || os(macOS)
                    .foregroundColor(Color(white: 0.8))
                    .padding(7)
                    .background(Color.gray.opacity(0.95), in: Circle())
                    #endif
            }
            #if os(iOS) || os(macOS)
            .buttonStyle(.borderless)
            .keyboardShortcut(.cancelAction)
            #elseif os(visionOS)
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
            #endif
            .padding(Constants.Dimension.verticalSmall)
        }
        #if os(macOS) || os(tvOS)
        .onMoveCommand(perform: movePage)
        #elseif os(iOS)
        // detect key press event for iOS
        .adaptiveOnMoveKeyPress(perform: movePage)
        #endif
    }

    #if os(macOS) || os(tvOS)
    private func movePage(_ direction: MoveCommandDirection) {
        switch direction {
        case .left: selection = max(0, selection - 1)
        case .right: selection = min(items.count - 1, selection + 1)
        case .up, .down: break
        @unknown default: debugPrint("Encounter unknown move direction \(direction)")
        }
    }
    #elseif os(iOS)
    private func movePage(_ direction: MoveDirection) {
        switch direction {
        case .left: selection = max(0, selection - 1)
        case .right: selection = min(items.count - 1, selection + 1)
        }
    }
    #endif
}
