//
//  AliasTests.swift
//  SwiftTypedRouter_Example
//
//  Created by Sam Dean on 05/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

@testable import SwiftTypedRouter

final class AliasTests: XCTestCase {

    func testAlias_shouldCreate() {
        let alias = Alias<String>("test.alias")
        XCTAssertEqual(alias.identifier, "test.alias")
    }
}
