//
//  View.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 02/02/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0.0, macOS 10.15, *)
extension View {

    func eraseToAnyView() -> AnyView {
        if let any = self as? AnyView { return any }
        return AnyView(self)
    }
}
