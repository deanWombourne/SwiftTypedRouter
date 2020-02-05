//
//  Template.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 03/02/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation

public protocol FactoryTemplate {

    init(template: String)
}

public class Template {

    let template: String

    fileprivate init(template: String) {
        self.template = template
    }

    static func createMatcherExpression(path: String) -> NSRegularExpression? {
        let comps = path
            .split(separator: "/")
            .map { (component: Substring) -> Substring in
                guard component.hasPrefix(":") else { return component }
                return "([\\w])"
        }

        do {
            let expression = try NSRegularExpression(pattern: comps.joined(separator: "/"),
                                                     options: [ .caseInsensitive ])
            return expression
        } catch {
            print("WARNING Could not create matcher expression from ", path)
            print(error)
            return nil
        }
    }

    static func createBaseMatcher(path: String) -> (String) -> [String]? {
        guard let expression = createMatcherExpression(path: path) else {
            return { _ in return nil }
        }

        return { candidate in
            let matches = expression.matches(in: candidate, options: [ ], range: NSRange(location: 0, length: candidate.count))
            guard let match = matches.first else { return nil }

            return (1..<match.numberOfRanges)
                .map { match.range(at: $0) }
                .filter { $0.location != NSNotFound }
                .compactMap { Range($0, in: candidate) }
                .map { candidate[$0] }
                .map(String.init)
        }
    }

    fileprivate func createPath(template: String, parameters: Any...) -> Path {
        // Stringify the parameters - they should all be LosslessStringConvertable so this is fine.
        let parameters = parameters.map { String(describing: $0) }

        let components = template.split(separator: "/")

        // Some sanity please
        let placeholderCount = components.filter { $0.hasPrefix(":") }.count
        guard parameters.count >= placeholderCount else {
            print("Warning - not eonugh placeholders to form route from " + template)
            return ""
        }

        var paramIndex = 0
        let replaced = components.map { (component: Substring) -> String in
            guard component.hasPrefix(":") else { return String(component) }

            guard parameters.count > paramIndex else { return String(component) }

            let parameter = parameters[paramIndex]
            paramIndex += 1

            return String(describing: parameter)
        }

        return Path(replaced.joined(separator: "/"))
    }
}

extension Template {

    public final class T0: Template, FactoryTemplate {
        let matcher: (String) -> ()?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = { candidate in
                guard baseMatcher(candidate) != nil else { return nil }
                return ()
            }

            super.init(template: template)
        }

        public func path() -> Path {
            createPath(template: self.template)
        }
    }

    public final class T1<A: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 1 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                return (a)
            }

            super.init(template: template)
        }

        public func path(_ a: A) -> Path {
            createPath(template: self.template, parameters: a)
        }
    }

    // list/hats/3    - A: String, B: Int
    // list/([/w])/([/w])
    public final class T2<A: LosslessStringConvertible, B: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 2 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                return (a, b)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B) -> Path {
            createPath(template: self.template, parameters: a, b)
        }
    }

    public final class T3<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 3 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                return (a, b, c)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C) -> Path {
            createPath(template: self.template, parameters: a, b, c)
        }
    }
}
