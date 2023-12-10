//
//  SwiftTipsView.swift
//  Onboarding
//
//  Created by hengyu on 2023/12/10.
//

import SwiftUI

@available(iOS 15.0, macCatalyst 15.0, macOS 12.0, tvOS 15.0, visionOS 1.0, *)
struct SwiftTipsView: View {
    private let tips: any TipsItemType

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @FocusState private var focus

    init(tips: any TipsItemType) {
        self.tips = tips
    }

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .center) {
                    if let image = tips.image {
                        Image(obImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(
                    width: proxy.size.width,
                    height: getImageRatio(isHorizontalCompact: horizontalSizeClass == .compact) * proxy.size.height,
                    alignment: .center
                )

                // 1. make each item focusable to enable scrolling on tvOS;
                // 2. align the item width to its container so user can move focus to
                // the dismiss button on the top trailing of the `HelpView`.
                VStack(alignment: .leading, spacing: Constants.Dimension.baseUnit) {
                    Text(tips.title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        #if os(tvOS) || os(macOS)
                        .focusable()
                        #endif
                        .focused($focus)

                    Text(tips.content)
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        #if os(tvOS) || os(macOS)
                        .focusable()
                        #endif
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                #if os(tvOS)
                .padding(.horizontal, Constants.Dimension.horizontalLarge)
                #else
                .padding(.horizontal, Constants.Dimension.horizontalRegular)
                #endif
                .padding(.vertical, Constants.Dimension.verticalRegular)
            }
            .adaptiveSizeBasedScrollBouncesBehavior(.vertical)
        }
        .onAppear {
            // we need to focus any of an item in view to make it scrollable on tvOS
            // note: the view is embedded in a `TabView` and the transition between
            // sibiling views may not update the focus state properly when scrolling
            // to the destination view on tvOS platform, thus we should explicitly focus
            // focus an item on view appear.
            focus = true
        }
    }
}
