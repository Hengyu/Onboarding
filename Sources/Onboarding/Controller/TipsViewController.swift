//
//  TipsViewController.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

import UIKit

public final class TipsViewController<T: TipsItemType>: UIViewController {

    public var tips: T? {
        didSet {
            if let tips, tips != oldValue {
                tipsView.configure(with: tips)
            }
        }
    }

    public var enableSeparatorLine: Bool = true {
        didSet {
            separatorLine.isHidden = !enableSeparatorLine
        }
    }

    #if os(tvOS)

    public var contentOffset: CGPoint {
        get { tipsView.contentOffset }
        set { tipsView.contentOffset = newValue }
    }

    public var adjustedContentInset: UIEdgeInsets {
        tipsView.adjustedContentInset
    }

    public var contentSize: CGSize {
        get { tipsView.contentSize }
        set { tipsView.contentSize = newValue }
    }

    public var visibleSize: CGSize {
        tipsView.visibleSize
    }

    #endif

    private let separatorLine: UIView = .init()
    private let tipsView: TipsView = .init(frame: .zero)

    public init(tips: T) {
        self.tips = tips
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }

    private func configureSubviews() {
        separatorLine.frame = CGRect(x: view.bounds.width - 1, y: 0, width: 1, height: view.bounds.height)
        separatorLine.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
        separatorLine.backgroundColor = .groupedBackground
        separatorLine.isUserInteractionEnabled = false
        view.addSubview(separatorLine)
        separatorLine.isHidden = !enableSeparatorLine

        tipsView.frame = CGRect(origin: CGPoint.zero, size: view.bounds.size)
        tipsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tipsView)
        if let tips {
            tipsView.configure(with: tips)
        }
    }
}
