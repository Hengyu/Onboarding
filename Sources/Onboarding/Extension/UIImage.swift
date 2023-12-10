//
//  UIImage.swift
//
//
//  Created by hengyu on 2020/10/8.
//

#if canImport(UIKit)
import UIKit

private class CustomImage {

    struct LocalCache {
        /// Cache of close image
        static var closeImage: UIImage?
        /// Cache of larger close image
        static var closePlusImage: UIImage?
    }

    class func drawClose(
        frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 25, height: 25),
        resizing: ResizingBehavior = .aspectFit
    ) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 25, height: 25), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 25, y: resizedFrame.height / 25)

        /// Close
        let close2 = UIBezierPath()
        close2.move(to: CGPoint(x: 9.5, y: 0))
        close2.addCurve(
            to: CGPoint(x: 11, y: 1.5),
            controlPoint1: CGPoint(x: 10.33, y: 0),
            controlPoint2: CGPoint(x: 11, y: 0.67)
        )
        close2.addLine(to: CGPoint(x: 11, y: 8))
        close2.addLine(to: CGPoint(x: 17.5, y: 8))
        close2.addCurve(
            to: CGPoint(x: 19, y: 9.5),
            controlPoint1: CGPoint(x: 18.33, y: 8),
            controlPoint2: CGPoint(x: 19, y: 8.67)
        )
        close2.addCurve(
            to: CGPoint(x: 17.5, y: 11),
            controlPoint1: CGPoint(x: 19, y: 10.33),
            controlPoint2: CGPoint(x: 18.33, y: 11)
        )
        close2.addLine(to: CGPoint(x: 11, y: 11))
        close2.addLine(to: CGPoint(x: 11, y: 17.5))
        close2.addCurve(
            to: CGPoint(x: 9.5, y: 19),
            controlPoint1: CGPoint(x: 11, y: 18.33),
            controlPoint2: CGPoint(x: 10.33, y: 19)
        )
        close2.addCurve(
            to: CGPoint(x: 8, y: 17.5),
            controlPoint1: CGPoint(x: 8.67, y: 19),
            controlPoint2: CGPoint(x: 8, y: 18.33)
        )
        close2.addLine(to: CGPoint(x: 8, y: 11))
        close2.addLine(to: CGPoint(x: 1.5, y: 11))
        close2.addCurve(
            to: CGPoint(x: 0, y: 9.5),
            controlPoint1: CGPoint(x: 0.67, y: 11),
            controlPoint2: CGPoint(x: 0, y: 10.33)
        )
        close2.addCurve(
            to: CGPoint(x: 1.5, y: 8),
            controlPoint1: CGPoint(x: 0, y: 8.67),
            controlPoint2: CGPoint(x: 0.67, y: 8)
        )
        close2.addLine(to: CGPoint(x: 8, y: 8))
        close2.addLine(to: CGPoint(x: 8, y: 1.5))
        close2.addCurve(
            to: CGPoint(x: 9.5, y: 0),
            controlPoint1: CGPoint(x: 8, y: 0.67),
            controlPoint2: CGPoint(x: 8.67, y: 0)
        )
        close2.close()
        context.saveGState()
        context.translateBy(x: 12.5, y: 12.5)
        context.rotate(by: 405 * CGFloat.pi/180)
        context.translateBy(x: -9.5, y: -9.5)
        close2.usesEvenOddFillRule = true
        UIColor(white: 0.85, alpha: 1).setFill()
        close2.fill()
        context.restoreGState()

        context.restoreGState()
    }

    class func drawClosePlus(
        frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 25, height: 25),
        resizing: ResizingBehavior = .aspectFit
    ) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 25, height: 25), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 25, y: resizedFrame.height / 25)

        /// Close
        let close = UIBezierPath()
        close.move(to: CGPoint(x: 11.5, y: 0))
        close.addCurve(
            to: CGPoint(x: 13, y: 1.5),
            controlPoint1: CGPoint(x: 12.33, y: 0),
            controlPoint2: CGPoint(x: 13, y: 0.67)
        )
        close.addLine(to: CGPoint(x: 13, y: 10))
        close.addLine(to: CGPoint(x: 21.5, y: 10))
        close.addCurve(
            to: CGPoint(x: 23, y: 11.5),
            controlPoint1: CGPoint(x: 22.33, y: 10),
            controlPoint2: CGPoint(x: 23, y: 10.67)
        )
        close.addCurve(
            to: CGPoint(x: 21.5, y: 13),
            controlPoint1: CGPoint(x: 23, y: 12.33),
            controlPoint2: CGPoint(x: 22.33, y: 13)
        )
        close.addLine(to: CGPoint(x: 13, y: 13))
        close.addLine(to: CGPoint(x: 13, y: 21.5))
        close.addCurve(
            to: CGPoint(x: 11.5, y: 23),
            controlPoint1: CGPoint(x: 13, y: 22.33),
            controlPoint2: CGPoint(x: 12.33, y: 23)
        )
        close.addCurve(
            to: CGPoint(x: 10, y: 21.5),
            controlPoint1: CGPoint(x: 10.67, y: 23),
            controlPoint2: CGPoint(x: 10, y: 22.33)
        )
        close.addLine(to: CGPoint(x: 10, y: 13))
        close.addLine(to: CGPoint(x: 1.5, y: 13))
        close.addCurve(
            to: CGPoint(x: 0, y: 11.5),
            controlPoint1: CGPoint(x: 0.67, y: 13),
            controlPoint2: CGPoint(x: 0, y: 12.33)
        )
        close.addCurve(
            to: CGPoint(x: 1.5, y: 10),
            controlPoint1: CGPoint(x: 0, y: 10.67),
            controlPoint2: CGPoint(x: 0.67, y: 10)
        )
        close.addLine(to: CGPoint(x: 10, y: 10))
        close.addLine(to: CGPoint(x: 10, y: 1.5))
        close.addCurve(
            to: CGPoint(x: 11.5, y: 0),
            controlPoint1: CGPoint(x: 10, y: 0.67),
            controlPoint2: CGPoint(x: 10.67, y: 0)
        )
        close.close()
        context.saveGState()
        context.translateBy(x: 12.5, y: 12.5)
        context.rotate(by: 405 * CGFloat.pi/180)
        context.translateBy(x: -11.5, y: -11.5)
        close.usesEvenOddFillRule = true
        UIColor(white: 0.85, alpha: 1).setFill()
        close.fill()
        context.restoreGState()

        context.restoreGState()
    }

    class func imageOfClose() -> UIImage {
        if let image = LocalCache.closeImage {
            return image
        }

        var image: UIImage

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 25, height: 25), false, 0)
        CustomImage.drawClose()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        LocalCache.closeImage = image
        return image
    }

    class func imageOfClosePlus() -> UIImage {
        if let image = LocalCache.closePlusImage {
            return image
        }

        var image: UIImage

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 25, height: 25), false, 0)
        CustomImage.drawClosePlus()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        LocalCache.closePlusImage = image
        return image
    }

    enum ResizingBehavior {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}

extension UIImage {

    #if os(tvOS)
    static let close: UIImage = CustomImage.imageOfClosePlus()
    #else
    static let close: UIImage = CustomImage.imageOfClose()
    #endif
}
#endif
