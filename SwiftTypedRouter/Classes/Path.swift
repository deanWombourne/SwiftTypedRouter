//
//  Path.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 02/02/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation

public struct Path {

    let path: String

    public init(_ path: String) {
        self.path = path
    }
}

extension Path: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self = Path(value)
    }
}

extension Path: LosslessStringConvertible, CustomStringConvertible {

    public var description: String {
        self.path
    }
}
