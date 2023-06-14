//
//  Constants.swift
//
//
//  Created by hengyu on 2020/10/7.
//

import UIKit

internal enum Constants { }

extension Constants {

    enum Dimension {
        static let baseUnit: CGFloat = 8

        static let verticalTiny: CGFloat = baseUnit * 1.5
        static let verticalSmall: CGFloat = baseUnit * 2
        static let verticalRegular: CGFloat = baseUnit * 3
        static let verticalLarge: CGFloat = baseUnit * 6

        static let horizontalTiny: CGFloat = verticalTiny
        static let horizontalSmall: CGFloat = verticalSmall
        static let horizontalRegular: CGFloat = verticalRegular
        static let horizontalLarge: CGFloat = verticalLarge

        static let verticalPaddingTiny: CGFloat = baseUnit * 3
        static let verticalPaddingSmall: CGFloat = baseUnit * 4
        static let verticalPaddingRegular: CGFloat = baseUnit * 6

        static let widthPaddingTiny: CGFloat = verticalPaddingTiny
        static let widthPaddingSmall: CGFloat = verticalPaddingSmall
        static let widthPaddingRegular: CGFloat = verticalPaddingRegular

        static let iconTiny: CGFloat = verticalPaddingTiny
        static let iconSmall: CGFloat = verticalPaddingSmall
        static let iconRegular: CGFloat = verticalPaddingRegular

        static let compactEdgeInsets: UIEdgeInsets = .init(
            top: verticalSmall,
            left: horizontalSmall,
            bottom: verticalSmall,
            right: horizontalSmall
        )

        static let regularEdgeInsets: UIEdgeInsets = .init(
            top: verticalRegular,
            left: horizontalRegular,
            bottom: verticalRegular,
            right: horizontalRegular
        )

        static let largeEdgeInsets: UIEdgeInsets = .init(
            top: verticalRegular,
            left: horizontalLarge,
            bottom: verticalRegular,
            right: horizontalLarge
        )
    }
}
