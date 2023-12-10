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
    private let cancelButton: UIButton = .makeClose()
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
        setupKeyCommands()
        setupGesture()
        registerTraitsUpdate()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // reset the cancel button's visibility due to
        // the view controller could be reused in elsewhere
        cancelButton.isHidden = navigationController != nil
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
        view.backgroundColor = .defaultBackground

        cancelButton.addTarget(self, action: #selector(cancelBtnClicked(_:)), for: .primaryActionTriggered)
        view.addSubview(cancelButton)

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
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.Dimension.verticalSmall
        ).isActive = true
        cancelButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constants.Dimension.verticalSmall
        ).isActive = true
        #if os(iOS) || os(visionOS) || targetEnvironment(macCatalyst)
        // tvOS has its own style for `UIButton`
        cancelButton.widthAnchor.constraint(equalToConstant: Constants.Dimension.iconSmall).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
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
        addFocusGuide(from: cancelButton, to: view, direction: .bottom)
        addFocusGuide(from: view, to: cancelButton, direction: .top)
    }

    private func setupKeyCommands() {
        let esc = UIKeyCommand(
            input: UIKeyCommand.inputEscape,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(dismissPage)
        )
        let backward = UIKeyCommand(
            input: UIKeyCommand.inputLeftArrow,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(selectBackwardPage)
        )
        let forward = UIKeyCommand(
            input: UIKeyCommand.inputRightArrow,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(selectForwardPage)
        )
        if #available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, *) {
            esc.wantsPriorityOverSystemBehavior = true
            backward.wantsPriorityOverSystemBehavior = true
            forward.wantsPriorityOverSystemBehavior = true
        }
        addKeyCommand(esc)
        addKeyCommand(backward)
        addKeyCommand(forward)
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

    private func registerTraitsUpdate() {
        if #available(iOS 17.0, tvOS 17.0, visionOS 1.0, *) {
            registerForTraitChanges([UITraitHorizontalSizeClass.self]) { [unowned self] (traitEnvironment: Self, _) in
                updateConditionalLayout(using: traitEnvironment.traitCollection)
            }
        }
    }

    private func updateConditionalLayout(using traitCollection: UITraitCollection) {
        switch traitCollection.userInterfaceIdiom {
        case .pad, .phone:
            view.layoutMargins = traitCollection.needsLargeDisplay
            ? Constants.Dimension.regularEdgeInsets
            : Constants.Dimension.compactEdgeInsets
        case .mac, .tv, .vision, .carPlay:
            view.layoutMargins = Constants.Dimension.largeEdgeInsets
        case .unspecified:
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
            var offset = currentPage.contentOffset

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
        if let navigationController {
            if navigationController.viewControllers.first !== self {
                navigationController.popViewController(animated: true)
            } else {
                navigationController.presentingViewController?.dismiss(animated: true, completion: nil)
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
