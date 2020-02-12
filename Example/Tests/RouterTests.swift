//
//  RouterTests.swift
//  SwiftTypedRouter_Tests
//
//  Created by Sam Dean on 12/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import SwiftUI

@testable import SwiftTypedRouter

final class RouterTests: XCTestCase {

    private var router: Router!

    override func setUp() {
        super.setUp()

        self.router = Router(identifier: "TestRouter" + UUID().uuidString)
    }

    override func tearDown() {
        self.router = nil

        super.tearDown()
    }

    func testRouter_shouldCreateWithIdentifier() {
        let router = Router(identifier: "TestRouter")
        XCTAssertEqual(router.identifier, "TestRouter")
    }

    func testRouter_shouldCreateWithoutIdentifier() {
        let router = Router()
        XCTAssertNil(router.identifier)
    }
}
