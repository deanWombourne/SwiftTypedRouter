//
//  Environment.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 03/02/2020.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct RouterKey: EnvironmentKey {

    public static let defaultValue: Router = Router()
}

@available(iOS 13.0, *)
extension EnvironmentValues {

    public var router: Router {
        get {
            return self[RouterKey.self]
        }
        set {
            self[RouterKey.self] = newValue
        }
    }
}
