//
//  ViewTests.swift
//  SwiftTypedRouter_Example
//
//  Created by Sam Dean on 05/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import SwiftUI

@testable import SwiftTypedRouter

@available(iOS 13.0, *)
final class ViewTests: XCTestCase {

    func testView_willEraseToAnyView() {
        let view = Text("This isn't AnyView")
        let erased: some View = view.eraseToAnyView()
        XCTAssertTrue(erased is AnyView)
    }

    func testView_willNotNestAnyViews() {
        let view = Text("This isn't AnyView")
        let erased = view.eraseToAnyView().eraseToAnyView().eraseToAnyView().eraseToAnyView().eraseToAnyView()

        // The description of AnyView looks like AnyView(storage: SwiftUI.(unknown context at $7fff2c6a75a0).AnyViewStorage<SwiftUI.Text>)

        // If we were nested AnyView we would have something like AnyViewStorage<AnyView> recursing down
        XCTAssertFalse(String(describing: erased).contains("AnyViewStorage<SwiftUI.AnyView"))
        XCTAssertFalse(String(describing: erased).contains("AnyViewStorage<AnyView"))

        // Sanity check the debug description is still helpful
        XCTAssertTrue(String(describing: erased).contains("AnyViewStorage<SwiftUI.Text>"))
    }
}
