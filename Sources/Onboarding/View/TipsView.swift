//
//  TipsView.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

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
        if #available(iOS 12.0, macCatalyst 13.0, tvOS 12.0, *) {
            return scrollView.visibleSize
        } else {
            return scrollView.bounds.size
        }
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

    private func setupComponents() {
        backgroundColor = .defaultBackground

        titleLabel.textColor = .defaultLabel
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.font = .preferredFont(forTextStyle: .headline)

        contentLabel.textColor = UIColor.defaultSecondaryLabel
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
        contentLabel.font = .preferredFont(forTextStyle: .body)

        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear

        childStackView.axis = .vertical
        childStackView.alignment = .leading
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
    }

    private func setupConstraints() {
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        #if targetEnvironment(macCatalyst) || os(macOS)
        let multiplier: CGFloat = 1 / 2.0
        #elseif os(tvOS)
        let multiplier: CGFloat = 4 / 7.0
        #else
        let multiplier: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 2 / 3.0 : 3 / 5.0
        #endif
        imageView.heightAnchor.constraint(
            equalTo: scrollView.frameLayoutGuide.heightAnchor,
            multiplier: multiplier
        ).isActive = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.directionalLayoutMargins = .init(
            top: Constants.Dimension.verticalSmall,
            leading: Constants.Dimension.horizontalRegular,
            bottom: Constants.Dimension.verticalSmall,
            trailing: Constants.Dimension.horizontalRegular
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.preservesSuperviewLayoutMargins = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
    }
}

extension TipsView {
    open func configure<T: TipsItemType>(with tips: T) {
        title = tips.title
        content = tips.content
        image = tips.image
    }
}
