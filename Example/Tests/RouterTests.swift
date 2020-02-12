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

class RouterTest: XCTestCase {

    fileprivate var router: Router!

    override func setUp() {
        super.setUp()

        self.router = Router(identifier: "TestRouter" + UUID().uuidString)
    }

    override func tearDown() {
        self.router = nil

        super.tearDown()
    }
}

final class RouterTests: RouterTest {

    func testRouter_shouldCreateWithIdentifier() {
        let router = Router(identifier: "TestRouter")
        XCTAssertEqual(router.identifier, "TestRouter")
    }

    func testRouter_shouldCreateWithoutIdentifier() {
        let router = Router()
        XCTAssertNil(router.identifier)
    }

}

final class RouterCanMatchTests: RouterTest {

    func testRouter_canMatchShouldReturnTrue() {
        router.add(path: "a/b/:c") { (value: String) -> EmptyView in
            EmptyView()
        }

        XCTAssertTrue(router.canMatch("a/b/hello"))
        XCTAssertTrue(router.canMatch("a/b/3"))
    }

    func testRouter_canMatchShouldReturnFalse() {
        router.add(path: "a/b/:c") { (value: String) -> EmptyView in
            EmptyView()
        }

        XCTAssertFalse(router.canMatch("a/b/"))
        XCTAssertFalse(router.canMatch("a/b"))
        XCTAssertFalse(router.canMatch("a//c"))
    }
}

final class RouterPathMatchingTests: RouterTest {

    func testRouter_shouldMatchSimplePath() {
        let router = Router()
        var matched = false
        router.add(path: "home") { () -> EmptyView in matched = true; return EmptyView() }

        XCTAssertNotNil(router.view("home"))

        XCTAssertTrue(matched)
    }

    func testRouter_shouldMatchPlaceholderPath1() {
        var matched: String? = nil

        router.add(path: "path/:p1") { (matched1: String) -> EmptyView in
            matched = matched1
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/hats"))

        XCTAssertEqual(matched, "hats")
    }

    func testRouter_shouldMatchPlaceholderPath2() {
        var matched: (String, String)? = nil

        router.add(path: "path/:p1/:p2") { (m1: String, m2: String) -> EmptyView in
            matched = (m1, m2)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/hats/boots"))

        XCTAssertEqual(matched?.0, "hats")
        XCTAssertEqual(matched?.1, "boots")
    }

    func testRouter_shouldMatchPlaceholderPath3() {
        var matched: (String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3") { (m1: String, m2: String, m3: String) -> EmptyView in
            matched = (m1, m2, m3)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
    }

    func testRouter_shouldMatchPlaceholderPath4() {
        var matched: (String, String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3/:p4") { (m1: String, m2: String, m3: String, m4: String) -> EmptyView in
            matched = (m1, m2, m3, m4)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc/ddd"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
        XCTAssertEqual(matched?.3, "ddd")
    }

    func testRouter_shouldMatchPlaceholderPath5() {
        var matched: (String, String, String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3/:p4/:p5") { (m1: String, m2: String, m3: String, m4: String, m5: String) -> EmptyView in
            matched = (m1, m2, m3, m4, m5)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc/ddd/eee"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
        XCTAssertEqual(matched?.3, "ddd")
        XCTAssertEqual(matched?.4, "eee")
    }

    func testRouter_shouldMatchPlaceholderPath6() {
        var matched: (String, String, String, String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3/:p4/:p5/:p6") { (m1: String, m2: String, m3: String, m4: String, m5: String, m6: String) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc/ddd/eee/fff"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
        XCTAssertEqual(matched?.3, "ddd")
        XCTAssertEqual(matched?.4, "eee")
        XCTAssertEqual(matched?.5, "fff")
    }

    func testRouter_shouldMatchPlaceholderPath7() {
        var matched: (String, String, String, String, String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3/:p4/:p5/:p6/:p7") { (m1: String, m2: String, m3: String, m4: String, m5: String, m6: String, m7: String) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc/ddd/eee/fff/ggg"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
        XCTAssertEqual(matched?.3, "ddd")
        XCTAssertEqual(matched?.4, "eee")
        XCTAssertEqual(matched?.5, "fff")
        XCTAssertEqual(matched?.6, "ggg")
    }

    func testRouter_shouldMatchPlaceholderPath8() {
        var matched: (String, String, String, String, String, String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3/:p4/:p5/:p6/:p7/:p8") { (m1: String, m2: String, m3: String, m4: String, m5: String, m6: String, m7: String, m8: String) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7, m8)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc/ddd/eee/fff/ggg/hhh"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
        XCTAssertEqual(matched?.3, "ddd")
        XCTAssertEqual(matched?.4, "eee")
        XCTAssertEqual(matched?.5, "fff")
        XCTAssertEqual(matched?.6, "ggg")
        XCTAssertEqual(matched?.7, "hhh")
    }

    func testRouter_shouldMatchPlaceholderPath9() {
        var matched: (String, String, String, String, String, String, String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3/:p4/:p5/:p6/:p7/:p8/:p9") { (m1: String, m2: String, m3: String, m4: String, m5: String, m6: String, m7: String, m8: String, m9: String) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7, m8, m9)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc/ddd/eee/fff/ggg/hhh/iii"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
        XCTAssertEqual(matched?.3, "ddd")
        XCTAssertEqual(matched?.4, "eee")
        XCTAssertEqual(matched?.5, "fff")
        XCTAssertEqual(matched?.6, "ggg")
        XCTAssertEqual(matched?.7, "hhh")
        XCTAssertEqual(matched?.8, "iii")
    }

    func testRouter_shouldMatchPlaceholderPath10() {
        var matched: (String, String, String, String, String, String, String, String, String, String)? = nil

        router.add(path: "path/:p1/:p2/:p3/:p4/:p5/:p6/:p7/:p8/:p9/:p10") { (m1: String, m2: String, m3: String, m4: String, m5: String, m6: String, m7: String, m8: String, m9: String, m10: String) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7, m8, m9, m10)
            return EmptyView()
        }

        XCTAssertNotNil(router.view("path/aaa/bbb/ccc/ddd/eee/fff/ggg/hhh/iii/jjj"))

        XCTAssertEqual(matched?.0, "aaa")
        XCTAssertEqual(matched?.1, "bbb")
        XCTAssertEqual(matched?.2, "ccc")
        XCTAssertEqual(matched?.3, "ddd")
        XCTAssertEqual(matched?.4, "eee")
        XCTAssertEqual(matched?.5, "fff")
        XCTAssertEqual(matched?.6, "ggg")
        XCTAssertEqual(matched?.7, "hhh")
        XCTAssertEqual(matched?.8, "iii")
        XCTAssertEqual(matched?.9, "jjj")
    }

    func testRouter_shouldMatchSimpleTemplate() {
        var matched = false

        let template = Template.T0(template: "home")

        router.add(template) { () -> EmptyView in
            matched = true
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path()))

        XCTAssertTrue(matched)
    }

    func testRouter_shouldMatchTemplate1() {
        var matched: String? = nil

        let template = Template.T1<String>(template: ":p1")

        router.add(template) { (m1) -> EmptyView in
            matched = m1
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1")))

        XCTAssertEqual(matched, "m1")
    }

    func testRouter_shouldMatchTemplate2() {
        var matched: (String, String)? = nil

        let template = Template.T2<String, String>(template: ":p1/:p2")

        router.add(template) { (m1, m2) -> EmptyView in
            matched = (m1, m2)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
    }

    func testRouter_shouldMatchTemplate3() {
        var matched: (String, String, String)? = nil

        let template = Template.T3<String, String, String>(template: ":p1/:p2/:p3")

        router.add(template) { (m1, m2, m3) -> EmptyView in
            matched = (m1, m2, m3)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
    }

    func testRouter_shouldMatchTemplate4() {
        var matched: (String, String, String, String)? = nil

        let template = Template.T4<String, String, String, String>(template: ":p1/:p2/:p3/:p4")

        router.add(template) { (m1, m2, m3, m4) -> EmptyView in
            matched = (m1, m2, m3, m4)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3", "m4")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
        XCTAssertEqual(matched?.3, "m4")
    }

    func testRouter_shouldMatchTemplate5() {
        var matched: (String, String, String, String, String)? = nil

        let template = Template.T5<String, String, String, String, String>(template: ":p1/:p2/:p3/:p4/:p5")

        router.add(template) { (m1, m2, m3, m4, m5) -> EmptyView in
            matched = (m1, m2, m3, m4, m5)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3", "m4", "m5")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
        XCTAssertEqual(matched?.3, "m4")
        XCTAssertEqual(matched?.4, "m5")
    }

    func testRouter_shouldMatchTemplate6() {
        var matched: (String, String, String, String, String, String)? = nil

        let template = Template.T6<String, String, String, String, String, String>(template: ":p1/:p2/:p3/:p4/:p5/:p6")

        router.add(template) { (m1, m2, m3, m4, m5, m6) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3", "m4", "m5", "m6")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
        XCTAssertEqual(matched?.3, "m4")
        XCTAssertEqual(matched?.4, "m5")
        XCTAssertEqual(matched?.5, "m6")
    }

    func testRouter_shouldMatchTemplate7() {
        var matched: (String, String, String, String, String, String, String)? = nil

        let template = Template.T7<String, String, String, String, String, String, String>(template: ":p1/:p2/:p3/:p4/:p5/:p6/:p7")

        router.add(template) { (m1, m2, m3, m4, m5, m6, m7) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3", "m4", "m5", "m6", "m7")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
        XCTAssertEqual(matched?.3, "m4")
        XCTAssertEqual(matched?.4, "m5")
        XCTAssertEqual(matched?.5, "m6")
        XCTAssertEqual(matched?.6, "m7")
    }

    func testRouter_shouldMatchTemplate8() {
        var matched: (String, String, String, String, String, String, String, String)? = nil

        let template = Template.T8<String, String, String, String, String, String, String, String>(template: ":p1/:p2/:p3/:p4/:p5/:p6/:p7/:p8")

        router.add(template) { (m1, m2, m3, m4, m5, m6, m7, m8) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7, m8)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3", "m4", "m5", "m6", "m7", "m8")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
        XCTAssertEqual(matched?.3, "m4")
        XCTAssertEqual(matched?.4, "m5")
        XCTAssertEqual(matched?.5, "m6")
        XCTAssertEqual(matched?.6, "m7")
        XCTAssertEqual(matched?.7, "m8")
    }

    func testRouter_shouldMatchTemplate9() {
        var matched: (String, String, String, String, String, String, String, String, String)? = nil

        let template = Template.T9<String, String, String, String, String, String, String, String, String>(template: ":p1/:p2/:p3/:p4/:p5/:p6/:p7/:p8/:p9")

        router.add(template) { (m1, m2, m3, m4, m5, m6, m7, m8, m9) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7, m8, m9)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3", "m4", "m5", "m6", "m7", "m8", "m9")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
        XCTAssertEqual(matched?.3, "m4")
        XCTAssertEqual(matched?.4, "m5")
        XCTAssertEqual(matched?.5, "m6")
        XCTAssertEqual(matched?.6, "m7")
        XCTAssertEqual(matched?.7, "m8")
        XCTAssertEqual(matched?.8, "m9")
    }

    func testRouter_shouldMatchTemplate10() {
        var matched: (String, String, String, String, String, String, String, String, String, String)? = nil

        let template = Template.T10<String, String, String, String, String, String, String, String, String, String>(template: ":p1/:p2/:p3/:p4/:p5/:p6/:p7/:p8/:p9/:p10")

        router.add(template) { (m1, m2, m3, m4, m5, m6, m7, m8, m9, m10) -> EmptyView in
            matched = (m1, m2, m3, m4, m5, m6, m7, m8, m9, m10)
            return EmptyView()
        }

        XCTAssertNotNil(router.view(template.path("m1", "m2", "m3", "m4", "m5", "m6", "m7", "m8", "m9", "m10")))

        XCTAssertEqual(matched?.0, "m1")
        XCTAssertEqual(matched?.1, "m2")
        XCTAssertEqual(matched?.2, "m3")
        XCTAssertEqual(matched?.3, "m4")
        XCTAssertEqual(matched?.4, "m5")
        XCTAssertEqual(matched?.5, "m6")
        XCTAssertEqual(matched?.6, "m7")
        XCTAssertEqual(matched?.7, "m8")
        XCTAssertEqual(matched?.8, "m9")
        XCTAssertEqual(matched?.9, "m10")
    }
}
