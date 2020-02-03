//
//  ListView.swift
//  SwiftTypedRouter_Example
//
//  Created by Sam Dean on 03/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

import struct SwiftTypedRouter.Path
import SwiftTypedRouter

extension Template {

    static let productList = TemplateFactory.start().path("list").template()
}

extension Path {

    static let productList = Template.productList.path()
}

struct ListView: View {

    var body: some View {
        Text("This needs to be a list, really")
    }
}
