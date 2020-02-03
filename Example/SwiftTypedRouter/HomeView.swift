//
//  ContentView.swift
//  SwiftTypedRouter_Example
//
//  Created by Sam Dean on 03/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {

    @Environment(\.router) var router

    var body: some View {
        VStack {
            Spacer()
            Text("Hello World")
            Spacer()
            Button(action: { print(self.router) }) {
                Text("See a List")
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
