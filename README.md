# Onboarding

![](https://img.shields.io/badge/iOS-12%2B-green)
![](https://img.shields.io/badge/tvOS-12%2B-green)
![](https://img.shields.io/badge/visionOS-1%2B-green)
![](https://img.shields.io/badge/Swift-5-orange?logo=Swift&logoColor=white)
![](https://img.shields.io/github/last-commit/hengyu/onboarding)

<img src="/OnboardingExample/screenshot.JPEG" width="320"/>

**Onboarding** provides a fluent user-interface for app onboarding experience.

## Table of contents

* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [License](#license)

## Requirements

- Swift 5.9
- iOS 12.0+, tvOS 12.0+, visionOS 1.0+

## Installation

#### Manual

Download the .zip from this repo and drag the `/Sources/Onboarding` folder into your project.

#### Swift Package Manager

[Onboarding](https://github.com/hengyu/Onboarding.git) could be installed via [Swift Package Manager](https://www.swift.org/package-manager/). Open Xcode and go to **File** -> **Add Packages...**, search `https://github.com/hengyu/Onboarding.git`, and add the package as one of your project's dependency.

## Usage

`Onboarding` is super easy to get started with.

Simply follow the usage in the [example file](/OnboardingExample/ViewController.swift).

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

## License

**Onboarding** is released under the [MIT License](LICENSE).
