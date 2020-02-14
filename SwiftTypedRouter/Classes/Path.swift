//
//  Path.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 02/02/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation

/// Represents a path to be passed into a Router.
///
/// Essentially a typesafe wrapper around `String`.
public struct Path: Hashable {

    public let path: String

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
