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

    fileprivate static func createMatcherExpression(path: String) -> NSRegularExpression? {
        let comps = path
            .split(separator: "/")
            .map { (component: Substring) -> Substring in
                guard component.hasPrefix(":") else { return component }
                return "([\\w]+)"
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

    fileprivate static func createBaseMatcher(path: String) -> (String) -> [String]? {
        guard let expression = createMatcherExpression(path: path) else {
            return { _ in return nil }
        }

        return { candidate in
            let matches = expression.matches(in: candidate, options: [ ], range: NSRange(location: 0, length: candidate.count))
            guard let match = matches.first else { return nil }

            return (1..<match.numberOfRanges)
                .map { match.range(at: $0) }
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

    // sourcery:inline:auto:Template.Subclasses

    // Generated template subclass for templates with 0 generic types
    public final class T0: Template, FactoryTemplate {
        let matcher: (String) -> ()?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 0 else { return nil }
                return ()
            }

            super.init(template: template)
        }

        public func path() -> Path {
            createPath(template: self.template)
        }
    }

    // Generated template subclass for templates with 1 generic types
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

    // Generated template subclass for templates with 2 generic types
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

    // Generated template subclass for templates with 3 generic types
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

    // Generated template subclass for templates with 4 generic types
    public final class T4<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C, D)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 4 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                guard let d = D(matches[3]) else { return nil }
                return (a, b, c, d)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C, _ d: D) -> Path {
            createPath(template: self.template, parameters: a, b, c, d)
        }
    }

    // Generated template subclass for templates with 5 generic types
    public final class T5<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C, D, E)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 5 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                guard let d = D(matches[3]) else { return nil }
                guard let e = E(matches[4]) else { return nil }
                return (a, b, c, d, e)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) -> Path {
            createPath(template: self.template, parameters: a, b, c, d, e)
        }
    }

    // Generated template subclass for templates with 6 generic types
    public final class T6<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C, D, E, F)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 6 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                guard let d = D(matches[3]) else { return nil }
                guard let e = E(matches[4]) else { return nil }
                guard let f = F(matches[5]) else { return nil }
                return (a, b, c, d, e, f)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) -> Path {
            createPath(template: self.template, parameters: a, b, c, d, e, f)
        }
    }

    // Generated template subclass for templates with 7 generic types
    public final class T7<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C, D, E, F, G)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 7 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                guard let d = D(matches[3]) else { return nil }
                guard let e = E(matches[4]) else { return nil }
                guard let f = F(matches[5]) else { return nil }
                guard let g = G(matches[6]) else { return nil }
                return (a, b, c, d, e, f, g)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) -> Path {
            createPath(template: self.template, parameters: a, b, c, d, e, f, g)
        }
    }

    // Generated template subclass for templates with 8 generic types
    public final class T8<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C, D, E, F, G, H)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 8 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                guard let d = D(matches[3]) else { return nil }
                guard let e = E(matches[4]) else { return nil }
                guard let f = F(matches[5]) else { return nil }
                guard let g = G(matches[6]) else { return nil }
                guard let h = H(matches[7]) else { return nil }
                return (a, b, c, d, e, f, g, h)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) -> Path {
            createPath(template: self.template, parameters: a, b, c, d, e, f, g, h)
        }
    }

    // Generated template subclass for templates with 9 generic types
    public final class T9<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C, D, E, F, G, H, I)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 9 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                guard let d = D(matches[3]) else { return nil }
                guard let e = E(matches[4]) else { return nil }
                guard let f = F(matches[5]) else { return nil }
                guard let g = G(matches[6]) else { return nil }
                guard let h = H(matches[7]) else { return nil }
                guard let i = I(matches[8]) else { return nil }
                return (a, b, c, d, e, f, g, h, i)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) -> Path {
            createPath(template: self.template, parameters: a, b, c, d, e, f, g, h, i)
        }
    }

    // Generated template subclass for templates with 10 generic types
    public final class T10<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible, J: LosslessStringConvertible>: Template, FactoryTemplate {
        let matcher: (String) -> (A, B, C, D, E, F, G, H, I, J)?

        override public init(template: String) {
            let baseMatcher = Self.createBaseMatcher(path: template)
            self.matcher = {
                guard let matches = baseMatcher($0) else { return nil }
                guard matches.count >= 10 else { return nil }
                guard let a = A(matches[0]) else { return nil }
                guard let b = B(matches[1]) else { return nil }
                guard let c = C(matches[2]) else { return nil }
                guard let d = D(matches[3]) else { return nil }
                guard let e = E(matches[4]) else { return nil }
                guard let f = F(matches[5]) else { return nil }
                guard let g = G(matches[6]) else { return nil }
                guard let h = H(matches[7]) else { return nil }
                guard let i = I(matches[8]) else { return nil }
                guard let j = J(matches[9]) else { return nil }
                return (a, b, c, d, e, f, g, h, i, j)
            }

            super.init(template: template)
        }

        public func path(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I, _ j: J) -> Path {
            createPath(template: self.template, parameters: a, b, c, d, e, f, g, h, i, j)
        }
    }
    // sourcery:end
}
