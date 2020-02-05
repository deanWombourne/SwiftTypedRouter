//
//  PathTests.swift
//  SwiftTypedRouter_Tests
//
//  Created by Sam Dean on 05/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

@testable import SwiftTypedRouter

final class PathTests: XCTestCase {

    func testPath_isStringLiteralConvertable() {
        let path1 = Path("Hello")
        let path2 = Path(path1.description)

        XCTAssertEqual(path1, path2)
    }
}
