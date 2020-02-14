//
//  TemplateRegexMatchable.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 14/02/2020.
//

import Foundation

/// Internal protocol to allow types to provide a cusom regex matching string when creating matches from templates
protocol TemplateRegexMatchable {

    static var regexMatch: String { get }
}

extension Int: TemplateRegexMatchable {

    static var regexMatch: String { "[-\\d]+" }
}

extension UInt: TemplateRegexMatchable {

    static var regexMatch: String { "[\\d]+" }
}

extension Float: TemplateRegexMatchable {

    static var regexMatch: String { "[-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?" }
}

extension Double: TemplateRegexMatchable {

    static var regexMatch: String { "[-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?" }
}
