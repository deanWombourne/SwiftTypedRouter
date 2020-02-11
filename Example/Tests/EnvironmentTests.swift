//
//  EnvironmentTests.swift
//  SwiftTypedRouter_Tests
//
//  Created by Sam Dean on 05/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

import XCTest

import SwiftUI

@testable import SwiftTypedRouter

@available(iOS 13.0, *)
private struct TestView: View {

    @Environment(\.router) var router

    weak var delegate: TestViewDelegate?

    var body: some View {
        delegate?.hasRouter(self, router: self.router)
        return Text("Hello")
    }
}

@available(iOS 13.0, *)
private protocol TestViewDelegate: class {
    func hasRouter(_ view: TestView, router: Router)
}

@available(iOS 13.0, *)
private final class TestViewDelegateClass: TestViewDelegate {
    private(set) var router: Router?

    func hasRouter(_ view: TestView, router: Router) {
        self.router = router
    }
}

@available(iOS 13.0, *)
final class EnvironmentTests: XCTestCase {

    func testEnvironment_hasDefaultRouter() {
        let view = TestView()
        XCTAssertNotNil(view.router)
    }

    func testEnvironment_canOverrideDefaultRouter() {
        let delegate = TestViewDelegateClass()

        let router = Router()

        // Create our test view and become it's delegate. We need to use delegation becuase by the time we have added
        // the environment object, our TestView isn't the one being rendered - it's a struct so it's going to be copied
        // all over the place :|
        var testView = TestView()
        testView.delegate = delegate

        // Apply our router to the view hierarchy, hopefully replacing the default one :)
        let view = testView.environment(\.router, router)

        // Get the body - this should trigger the TestView to inform the delegate what it's router is.
        // There are a fair amount of hoops to jump through just to get the view to render :)
        let container = UIHostingController(rootView: view)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()

        container.willMove(toParentViewController: window.rootViewController)
        window.rootViewController?.addChildViewController(container)
        window.rootViewController?.view.addSubview(container.view)

        window.layoutIfNeeded()

        XCTAssertTrue(delegate.router === router)

        // Make the previous window key again
        UIApplication.shared.windows.dropLast().first?.makeKeyAndVisible()
    }
}
