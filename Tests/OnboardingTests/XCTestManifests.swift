import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(OnboardingTests.allTests)
    ]
}
#endif
