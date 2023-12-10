//
//  ViewController.swift
//  OnboardingExample
//
//  Created by hengyu on 2020/10/7.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

class ViewController: UIViewController {

    private let items: [TipsItem] = [
        .init(
            title: "Lorem Ipsum",
            content: "Simple text with empty image."
        ),
        .init(
            title: "Lorem Amet",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            image: UIImage(named: "screenshot_0")
        ),
        .init(
            title: "Lorem Dolor",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n",
            image: UIImage(named: "screenshot_1")
        )
    ]

    private let button: UIButton = .init(type: .system)
    private lazy var helpPage: HelpPageViewController = .init(items: items)

    override func viewDidLoad() {
        super.viewDidLoad()
        #if os(tvOS)
        view.backgroundColor = .clear
        #else
        view.backgroundColor = .systemBackground
        #endif

        if #available(iOS 15.0, tvOS 15.0, visionOS 1.0, *) {
            button.configuration = .bordered()
        }
        button.setTitle("Show Help Page", for: .normal)
        button.addTarget(self, action: #selector(showHelpPage(_:)), for: .primaryActionTriggered)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc
    private func showHelpPage(_ sender: UIButton) {
        if #available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, visionOS 1.0, *) {
            let helpView = HelpPageViewControllerV2(items: items)
            present(helpView, animated: true)
        } else {
            present(helpPage, animated: true)
        }
    }
}
#endif
