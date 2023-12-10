//
//  HelpView.swift
//  Onboarding
//
//  Created by hengyu on 2023/12/9.
//

import SwiftUI

@available(iOS 15.0, macCatalyst 15.0, macOS 12.0, tvOS 15.0, visionOS 1.0, *)
public struct HelpView: View {
    public let items: [TipsItem]
    @State private var selection: Int = 0
    @Environment(\.dismiss) private var dismiss

    public init(items: [TipsItem]) {
        self.items = items
    }

    public var body: some View {
        #if os(macOS)
        tabView
            .padding(Constants.Dimension.horizontalSmall)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    dismissButton
                }
            }
        #else
        ZStack(alignment: .topTrailing) {
            tabView

            dismissButton
                .padding(Constants.Dimension.verticalSmall)
        }
        #endif
    }

    private var tabView: some View {
        TabView(selection: $selection) {
            ForEach(0 ..< items.count, id: \.self) { index in
                SwiftTipsView(tips: items[index])
                    .tabItem { Text("\(index + 1)") }
                    .tag(index)
            }
        }
        #if os(iOS) || os(tvOS) || os(visionOS)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        #else
        .tableStyle(.automatic)
        #endif
        .animation(.easeInOut, value: selection)
        .transition(.slide)
        #if os(tvOS)
        .onMoveCommand(perform: movePage)
        #elseif os(iOS)
            // detect key press event for iOS
        .adaptiveOnMoveKeyPress(perform: movePage)
        #endif
    }

    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                #if os(iOS)
                .font(.body.weight(.semibold))
                .foregroundColor(Color(white: 0.8))
                .padding(7)
                .background(Color.gray.opacity(0.95), in: Circle())
                #endif
        }
        #if os(iOS)
        .buttonStyle(.borderless)
        .keyboardShortcut(.cancelAction)
        #elseif os(visionOS)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        #endif
    }

    #if os(tvOS)
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
