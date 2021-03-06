//
//  HelpPageViewController.swift
//  
//
//  Created by hengyu on 2020/10/7.
//

import UIKit

public final class HelpPageViewController: UIPageViewController {

    public let items: [TipsItem]

    private var currentPage: Int = 0
    private var tipsViewControllers: [TipsViewController<TipsItem>] = []

    private let cancelBtn: UIButton = .makeClose()
    private let pageContentView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .light))
    private let pageControl: UIPageControl = .init(frame: .zero)

    public init(items: [TipsItem]) {
        if items.isEmpty {
            assertionFailure("Tips items for help page should not be empty")
            self.items = [.mock]
        } else {
            self.items = items
        }
        for tips in items {
            tipsViewControllers.append(TipsViewController(tips: tips))
        }
        tipsViewControllers.last!.enableSeparatorLine = false
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    public required init?(coder: NSCoder) {
        items = [.mock]
        super.init(coder: coder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupConstraints()
        setupPages()
        setupFocus()
        setupGesture()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateConditionalLayout(using: traitCollection)
    }

    private func setupComponents() {
        view.backgroundColor = .defaultBackground

        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked(_:)), for: .primaryActionTriggered)
        cancelBtn.isHidden = navigationController != nil
        view.addSubview(cancelBtn)

        pageControl.numberOfPages = items.count
        pageControl.currentPageIndicatorTintColor = .currentPageIndicator
        pageControl.pageIndicatorTintColor = .pageIndicator
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        if pageControl.setProminentBackground() {
            pageContentView.effect = nil
        }

        let pageSize = pageControl.roundedRectSize(forNumberOfPages: items.count)
        pageContentView.layer.masksToBounds = true
        pageContentView.layer.cornerRadius = pageSize.height / 2
        pageContentView.contentView.addSubview(pageControl)
        view.addSubview(pageContentView)
    }

    private func setupConstraints() {
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.Dimension.verticalSmall
        ).isActive = true
        cancelBtn.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constants.Dimension.verticalSmall
        ).isActive = true
        #if os(iOS) || os(macOS) || targetEnvironment(macCatalyst)
        // tvOS has its own style for `UIButton`
        cancelBtn.widthAnchor.constraint(equalToConstant: Constants.Dimension.iconSmall).isActive = true
        cancelBtn.heightAnchor.constraint(equalTo: cancelBtn.widthAnchor).isActive = true
        #endif

        pageContentView.translatesAutoresizingMaskIntoConstraints = false
        pageContentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        pageContentView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        let pageSize = pageControl.roundedRectSize(forNumberOfPages: items.count)
        pageContentView.widthAnchor.constraint(equalToConstant: pageSize.width).isActive = true
        pageContentView.heightAnchor.constraint(equalToConstant: pageSize.height).isActive = true

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: pageContentView.contentView.centerXAnchor).isActive = true
        pageControl.centerYAnchor.constraint(equalTo: pageContentView.contentView.centerYAnchor).isActive = true
        // Explicitly specify width for `UIPageControl` to enable its touch area
        pageControl.widthAnchor.constraint(equalToConstant: pageSize.width).isActive = true

        updateConditionalLayout(using: traitCollection)
    }

    private func setupPages() {
        setViewControllers([tipsViewControllers.first!], direction: .forward, animated: true, completion: nil)
        dataSource = self
        delegate = self

        tipsViewControllers.forEach {
            $0.additionalSafeAreaInsets = UIEdgeInsets.zero.with(bottom: Constants.Dimension.verticalPaddingSmall)
        }
    }

    private func setupFocus() {
        addFocusGuide(from: cancelBtn, to: view, direction: .bottom)
        addFocusGuide(from: view, to: cancelBtn, direction: .top)
    }

    /// Setup gesture to control the offset change of `TipsViewController` in tvOS.
    ///
    /// - NOTE: According to the [documentation](https://developer.apple.com/documentation/uikit/uipageviewcontroller),
    /// a user cannot interact with or move focus between items on each page.
    private func setupGesture() {
        #if os(tvOS)
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        view.addGestureRecognizer(swipeGesture)
        #endif
    }

    private func updateConditionalLayout(using traitCollection: UITraitCollection) {
        var lagoutMarginsBlock = {
            self.view.layoutMargins = traitCollection.needsLargeDisplay
                ? Constants.Dimension.regularEdgeInsets
                : Constants.Dimension.compactEdgeInsets
        }
        switch traitCollection.userInterfaceIdiom {
        #if targetEnvironment(macCatalyst)
        case .pad, .phone:
            lagoutMarginsBlock()
        #else
        case .mac, .pad, .phone:
            lagoutMarginsBlock()
        #endif
        case .carPlay, .tv, .unspecified:
            fallthrough
        @unknown default:
            break
        }
    }

    // https://www.enekoalonso.com/articles/understanding-and-visualizing-uifocusguide-on-tvos
    @discardableResult
    private func addFocusGuide(
        from origin: UIView,
        to destination: UIView,
        direction: UIRectEdge
    ) -> UIFocusGuide {
        let focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        focusGuide.preferredFocusEnvironments = [destination]

        // Configure size to match origin view
        focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

        switch direction {
        case .bottom: // swipe down
            focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .top: // swipe up
            focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .left: // swipe left
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.rightAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .right: // swipe right
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.rightAnchor).isActive = true
        default:
            // Not supported :(
            break
        }
        return focusGuide
    }

    #if os(tvOS)
    @objc
    private func panGestureRecognized(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard
            let currentPage = viewControllers?.first as? TipsViewController<TipsItem>,
            currentPage.contentSize.height > currentPage.visibleSize.height -
                currentPage.adjustedContentInset.top -
                currentPage.adjustedContentInset.bottom,
            let gestureView = gestureRecognizer.view
        else { return }

        if gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: gestureView)
            gestureRecognizer.setTranslation(translation, in: gestureView)

            let inset = currentPage.adjustedContentInset
            var offset =  currentPage.contentOffset

            let maxOffsetY = max(
                currentPage.contentSize.height - currentPage.visibleSize.height + inset.bottom,
                -inset.top
            )
            offset.y = max(min(offset.y + translation.y, maxOffsetY), -inset.top)
            currentPage.contentOffset = offset
        }
    }
    #endif

    @objc
    internal func selectBackwardPage() {
        let previous = max(0, pageControl.currentPage - 1)
        pageControl.currentPage = previous
        selectPage(at: previous)
    }

    @objc
    internal func selectForwardPage() {
        let next = min(items.count - 1, pageControl.currentPage + 1)
        pageControl.currentPage = next
        selectPage(at: next)
    }

    @objc
    private func pageControlValueChanged(_ control: UIPageControl) {
        selectPage(at: control.currentPage)
    }

    private func selectPage(at index: Int) {
        guard
            let page = viewControllers?.first as? TipsViewController<TipsItem>,
            let currentIndex = tipsViewControllers.firstIndex(of: page),
            currentIndex != index
        else { return }

        let tipsPage = tipsViewControllers[index]
        setViewControllers(
            [tipsPage],
            direction: index > currentIndex ? .forward : .reverse,
            animated: true,
            completion: nil
        )
    }

    @objc
    private func cancelBtnClicked(_ btn: UIButton) {
        dismissPage()
    }

    @objc
    internal func dismissPage() {
        if let nav = navigationController {
            if nav.viewControllers.first !== self {
                nav.popViewController(animated: true)
            } else {
                nav.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        } else {
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension HelpPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    public func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard
            completed,
            let page = pageViewController.viewControllers?.first as? TipsViewController<TipsItem>,
            let index = tipsViewControllers.firstIndex(of: page)
        else { return }

        pageControl.currentPage = index
    }

    public func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        if
            let tipsVC = viewController as? TipsViewController<TipsItem>,
            let tips = tipsVC.tips,
            let index = items.firstIndex(of: tips)
        {
            let currentIndex = index - 1
            if currentIndex > -1 && currentIndex < items.count {
                return tipsViewControllers[currentIndex]
            }
        }
        return nil
    }

    public func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        if
            let tipsVC = viewController as? TipsViewController<TipsItem>,
            let tips = tipsVC.tips,
            let index = items.firstIndex(of: tips)
        {
            let currentIndex = index + 1
            if currentIndex > -1 && currentIndex < items.count {
                return tipsViewControllers[currentIndex]
            }
        }
        return nil
    }
}
