# Onboarding

`Onboarding` provides a fluent user-interface for app onboarding experience.

## Screenshots

<img src="/OnboardingExample/screenshot.JPEG" width="320"/>

## Requirements

`Onboarding` supports for iOS, macCatalyst and tvOS. The minimal system requirements are:

iOS 11.0, macCatalyst 13.0+, tvOS 11.0

## Installation

#### Manual

Download the .zip from this repo and drag the `/Sources/Onboarding` folder into your project.

#### Swift Package Manager

In Xcode 11 or newer versions you can add packages by going to *File \> Swift Packages \> Add Package Dependency*. Copy in this repos [URL][1] and go from there.

## Usage

`Onboarding` is super easy to get started with.

Simply follow the usage in the [example file][2].

```Swift
import Onboarding

// 1. Prepare a set of tips items
let items: [TipsItem] = [
    .init(title: "Intro", content: "This is the summary of the app", image: UIImage(named: "intro"))
]

// 2. Create a help page using the tips items
let helpPage: HelpPageViewController = .init(items: items)

// 3. Present the help page
presentingViewController.present(helpPage, animated: true)
```

## Contribution

Contributions are welcomed, please feel free to submit pull requests.

## License

`Onboarding` is published under MIT License. See the [LICENSE][3] file for more.

[1]:	https://github.com/hengyu/Onboarding.git
[2]:	/OnboardingExample/ViewController.swift
[3]:	/LICENSE
