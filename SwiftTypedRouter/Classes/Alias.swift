//
//  Alias.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 03/02/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation

public struct Alias<T>: Hashable {
    let identifier: String

    public init(_ identifier: String) {
        self.identifier = identifier
    }
}
