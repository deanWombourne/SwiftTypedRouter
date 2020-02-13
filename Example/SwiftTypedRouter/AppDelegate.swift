//
//  AppDelegate.swift
//  SwiftTypedRouter
//
//  Created by deanWombourne on 02/03/2020.
//  Copyright (c) 2020 deanWombourne. All rights reserved.
//

import UIKit

import SwiftUI

import struct SwiftTypedRouter.Path
import SwiftTypedRouter


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //routerExamples()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

// MARK: - Examples of Router usage (SwiftUI)

func routerExamples() {

    // MARK: Creating a Router - initial setup, probably in app delegate / scene delegate

    // Create a router
    let router = Router()

    // Add some routes by hand
    router.add(path: "product/list/:category/:num") { (category: String, pageNumber: Int) -> Text in
        if category == "hats" {
            return Text("This is the Hat Specific product list, for page \(pageNumber)")
        } else {
            return Text("This is the product list \(category), page \(pageNumber)")
        }
    }

    print(router.canMatch("product/details/0"))

    // Add a route for a predefined template
    router.add(Template.productDetails) { productId in
        Text("Product Details screen for product with id \(productId)")
    }

    // MARK: Using the router - in each view which can be customised

    // Get a view for a path (String example)
    print(router.view("product/list/hats/0"))

    // Get a view for a path (type-safe generated example)
    print(router.view(.productDetails(id: "123456")))

    // MARK: Aliases

    router.alias(productListPlusTap) { context in
        if context.category == "hats" {
            return "invalid/action/no/hats/here"
        } else {
            return Template.addProduct.path()
        }
    }

    // Debugging the routes
    print("Known routes in \(router)")
    print("----------")
    print(router.debugRoutes)
    print(router.debugAliases)
    print("----------")

    print(router.canMatch("product/details/0"))
}


// The template for product details, define this in the product details view's file :)
extension Template {
    static let productDetails = TemplateFactory.start().path("product", "details").placeholder("id", String.self).template()

    static let addProduct = TemplateFactory.start().path("product", "add").template()
}

extension Path {

    static func productDetails(id: String) -> Path { Template.productDetails.path(id) }
}


// Create aliases

struct ProductListAliasContext {
    let category: String //!< This can be far more complicated that a string, and probably will be :)
}

let productListPlusTap = Alias<ProductListAliasContext>("product.list.plus")
let productListMinusTap = Alias<ProductListAliasContext>("product.list.minus")
