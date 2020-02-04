//
//  ContentView.swift
//  SwiftTypedRouter_Example
//
//  Created by Sam Dean on 03/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftTypedRouter

let homeButtonTapAlias = Alias<Never>("home.button.tap")

struct HomeView: View {

    @Environment(\.router) var router

    var body: some View {
        VStack {
            Spacer()
            Text("Hello World")
            Spacer()
            NavigationLink(destination: router.view(homeButtonTapAlias)) {
                Text("See a List")
            }
            Spacer()
        }.navigationBarTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
