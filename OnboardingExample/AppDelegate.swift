//
//  AppDelegate.swift
//  OnboardingExample
//
//  Created by hengyu on 2020/10/7.
//

#if os(macOS) || os(visionOS)
import SwiftUI

@main
struct OnboardingExample: App {
    @State var showsOnboarding: Bool = false
    private let items: [TipsItem] = [
        .init(
            title: "Lorem Ipsum",
            content: "Simple text with empty image."
        ),
        .init(
            title: "Lorem Amet",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            image: OBImage(named: "screenshot_0")
        ),
        .init(
            title: "Lorem Dolor",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n",
            image: OBImage(named: "screenshot_1")
        )
    ]

    var body: some Scene {
        WindowGroup {
            VStack(alignment: .center) {
                Button("Show Help Page") {
                    showsOnboarding = true
                }
            }
            .sheet(isPresented: $showsOnboarding) {
                HelpView(items: items)
                    .frame(width: 720, height: 480, alignment: .center)
            }
        }
    }
}

#else
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if !os(visionOS)
        window = UIWindow(frame: UIScreen.main.bounds)
        #else
        window = UIWindow()
        #endif
        window!.rootViewController = ViewController(nibName: nil, bundle: nil)
        window!.makeKeyAndVisible()
        return true
    }
}
#endif
