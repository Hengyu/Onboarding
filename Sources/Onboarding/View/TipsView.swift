//
//  TipsView.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

import CoreGraphics
#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

@IBDesignable
open class TipsView: UIView, UIFocusItemScrollableContainer {
    @IBInspectable
    open var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    @IBInspectable
    open var content: String? {
        get { contentLabel.text }
        set { contentLabel.text = newValue }
    }

    @IBInspectable
    open var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    public var contentOffset: CGPoint {
        get { scrollView.contentOffset }
        set { scrollView.contentOffset = newValue }
    }

    public var adjustedContentInset: UIEdgeInsets {
        scrollView.adjustedContentInset
    }

    public var contentSize: CGSize {
        get { scrollView.contentSize }
        set { scrollView.contentSize = newValue }
    }

    public var visibleSize: CGSize {
        scrollView.visibleSize
    }

    private let scrollView: UIScrollView = .init(frame: .zero)
    private let stackView: UIStackView = .init(frame: .zero)
    private let childStackView: UIStackView = .init(frame: .zero)
    private let titleLabel: UILabel = .init(frame: .zero)
    private let contentLabel: UILabel = .init(frame: .zero)
    private let imageView: UIImageView = .init(frame: .zero)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
        setupConstraints()
    }

    #if !os(visionOS)
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #unavailable(iOS 17.0, tvOS 17.0) {
            updateConditionalLayout(using: traitCollection)
        }
    }
    #endif

    private func setupComponents() {
        backgroundColor = .defaultBackground

        titleLabel.textColor = .defaultLabel
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        #if targetEnvironment(macCatalyst) || os(macOS)
        let descriptor = UIFont.preferredFont(forTextStyle: .title3).fontDescriptor
        let updated = descriptor.addingAttributes(
            [UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium]]
        )
        titleLabel.font = UIFont(descriptor: updated, size: updated.pointSize)
        #else
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        #endif

        contentLabel.textColor = UIColor.defaultSecondaryLabel
        contentLabel.textAlignment = .natural
        contentLabel.numberOfLines = 0
        contentLabel.font = .preferredFont(forTextStyle: .body)

        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear

        childStackView.axis = .vertical
        childStackView.alignment = .fill
        childStackView.distribution = .fill
        childStackView.spacing = Constants.Dimension.baseUnit
        childStackView.addArrangedSubview(titleLabel)
        childStackView.addArrangedSubview(contentLabel)

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constants.Dimension.horizontalRegular
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(childStackView)

        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(stackView)
        addSubview(scrollView)

        if #available(iOS 17.0, tvOS 17.0, visionOS 1.0, *) {
            registerForTraitChanges([UITraitUserInterfaceIdiom.self]) { [unowned self] (traitEnvironment: Self, _) in
                updateConditionalLayout(using: traitEnvironment.traitCollection)
            }
        }
    }

    private func setupConstraints() {
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        imageView.heightAnchor.constraint(
            equalTo: scrollView.frameLayoutGuide.heightAnchor,
            multiplier: getImageRatio(isHorizontalCompact: traitCollection.horizontalSizeClass == .compact)
        ).isActive = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.preservesSuperviewLayoutMargins = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true

        updateConditionalLayout(using: traitCollection)
    }

    private func updateConditionalLayout(using traitCollection: UITraitCollection) {
        switch traitCollection.userInterfaceIdiom {
        case .pad, .phone:
            scrollView.directionalLayoutMargins = Constants.Dimension.regularEdgeInsets.directional
        case .mac, .tv, .vision, .carPlay:
            scrollView.directionalLayoutMargins = Constants.Dimension.largeEdgeInsets.directional
        case .unspecified:
            fallthrough
        @unknown default:
            break
        }
    }
}

extension TipsView {
    public func configure(with tips: some TipsItemType) {
        title = tips.title
        content = tips.content
        image = tips.image
    }
}
#endif

func getImageRatio(isHorizontalCompact: Bool) -> CGFloat {
    #if targetEnvironment(macCatalyst) || os(macOS)
    1 / 2.0
    #elseif os(tvOS)
    4 / 7.0
    #else
    isHorizontalCompact ? 2 / 3.0 : 3 / 5.0
    #endif
}
