//
//  TemplateFactoryTests.swift
//  SwiftTypedRouter_Tests
//
//  Created by Sam Dean on 05/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

@testable import SwiftTypedRouter

final class TemplateFactoryTests: XCTestCase {

    var factory: TemplateFactory.FX!

    override func setUp() {
        super.setUp()

        self.factory = TemplateFactory.start()
    }

    override func tearDown() {
        self.factory = nil

        super.tearDown()
    }

    func testTemplateFactory_createSimplePath() {
        let template = factory.path("root").template()

        XCTAssertEqual(template.template, "root")
    }

    func testTemplateFactory_complexPath() {
        let template = factory.path("complex", "path").template()

        XCTAssertEqual(template.template, "complex/path")
    }

    func testTemplateFactory_singlePlaceholder() {
        let template = factory.path("root").placeholder("id", String.self).template()

        XCTAssertEqual(template.template, "root/:id")
    }

    func testTemplateFactory_onlyPlaceholder() {
        let template = factory.placeholder("id", String.self).template()

        XCTAssertEqual(template.template, ":id")
    }

    func testTemplateFactory_multiplePlaceholders() {
        let template2 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .template()
        XCTAssertEqual(template2.template, "1/:p1/2/:p2")

        let template3 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .template()
        XCTAssertEqual(template3.template, "1/:p1/2/:p2/3/:p3")

        let template4 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .path("4").placeholder("p4", Int.self)
            .template()
        XCTAssertEqual(template4.template, "1/:p1/2/:p2/3/:p3/4/:p4")

        let template5 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .path("4").placeholder("p4", Int.self)
            .path("5").placeholder("p5", Int.self)
            .template()
        XCTAssertEqual(template5.template, "1/:p1/2/:p2/3/:p3/4/:p4/5/:p5")

        let template6 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .path("4").placeholder("p4", Int.self)
            .path("5").placeholder("p5", Int.self)
            .path("6").placeholder("p6", Int.self)
            .template()
        XCTAssertEqual(template6.template, "1/:p1/2/:p2/3/:p3/4/:p4/5/:p5/6/:p6")

        let template7 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .path("4").placeholder("p4", Int.self)
            .path("5").placeholder("p5", Int.self)
            .path("6").placeholder("p6", Int.self)
            .path("7").placeholder("p7", Int.self)
            .template()
        XCTAssertEqual(template7.template, "1/:p1/2/:p2/3/:p3/4/:p4/5/:p5/6/:p6/7/:p7")

        let template8 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .path("4").placeholder("p4", Int.self)
            .path("5").placeholder("p5", Int.self)
            .path("6").placeholder("p6", Int.self)
            .path("7").placeholder("p7", Int.self)
            .path("8").placeholder("p8", Int.self)
            .template()
        XCTAssertEqual(template8.template, "1/:p1/2/:p2/3/:p3/4/:p4/5/:p5/6/:p6/7/:p7/8/:p8")

        let template9 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .path("4").placeholder("p4", Int.self)
            .path("5").placeholder("p5", Int.self)
            .path("6").placeholder("p6", Int.self)
            .path("7").placeholder("p7", Int.self)
            .path("8").placeholder("p8", Int.self)
            .path("9").placeholder("p9", Int.self)
            .template()
        XCTAssertEqual(template9.template, "1/:p1/2/:p2/3/:p3/4/:p4/5/:p5/6/:p6/7/:p7/8/:p8/9/:p9")

        let template10 = factory.path("1").placeholder("p1", String.self)
            .path("2").placeholder("p2", Int.self)
            .path("3").placeholder("p3", Bool.self)
            .path("4").placeholder("p4", Int.self)
            .path("5").placeholder("p5", Int.self)
            .path("6").placeholder("p6", Int.self)
            .path("7").placeholder("p7", Int.self)
            .path("8").placeholder("p8", Int.self)
            .path("9").placeholder("p9", Int.self)
            .path("10").placeholder("p10", Int.self)
            .template()
        XCTAssertEqual(template10.template, "1/:p1/2/:p2/3/:p3/4/:p4/5/:p5/6/:p6/7/:p7/8/:p8/9/:p9/10/:p10")
    }
}
