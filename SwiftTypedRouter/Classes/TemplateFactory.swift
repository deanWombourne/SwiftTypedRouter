//
//  TemplateFactory.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 02/02/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation

// MARK: - Template factory

public class TemplateFactoryStart {

    public static func start() -> TemplateFactory.FX { TemplateFactory.FX() }
}

public class TemplateFactory: TemplateFactoryStart {

    public let components: [String]

    public required init(_ components: [String] = []) {
        self.components = components
    }

    public func path(_ path: String, _ extraPath: String...) -> Self {
        let allPathComponents = [path] + extraPath
        return Self(self.components + allPathComponents)
    }
}

public protocol TemplateFactoryMake {
    associatedtype TemplateType: Template, FactoryTemplate

    var components: [String] { get }

    func template() -> TemplateType
}

extension TemplateFactoryMake {

    public func template() -> TemplateType {
        TemplateType.init(template: self.components.joined(separator: "/"))
    }
}

extension TemplateFactory {

    public final class FX: TemplateFactoryStart {

        public func placeholder<T: LosslessStringConvertible>(_ name: String, _ type: T.Type) -> F1<T> {
            F1([":" + name])
        }

        public func path(_ path: String, _ extraPath: String...) -> F0 {
            let allPathComponents = [path] + extraPath
            return F0(allPathComponents)
        }
    }

    // sourcery:inline:auto:TemplateFactory.Subclasses

    // Generated factory subclass for templates with 0 generic types
    public final class F0: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T0

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F1<Z> {
            F1(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 1 generic types
    public final class F1<A: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T1<A>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F2<A, Z> {
            F2(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 2 generic types
    public final class F2<A: LosslessStringConvertible, B: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T2<A, B>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F3<A, B, Z> {
            F3(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 3 generic types
    public final class F3<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T3<A, B, C>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F4<A, B, C, Z> {
            F4(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 4 generic types
    public final class F4<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T4<A, B, C, D>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F5<A, B, C, D, Z> {
            F5(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 5 generic types
    public final class F5<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T5<A, B, C, D, E>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F6<A, B, C, D, E, Z> {
            F6(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 6 generic types
    public final class F6<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T6<A, B, C, D, E, F>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F7<A, B, C, D, E, F, Z> {
            F7(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 7 generic types
    public final class F7<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T7<A, B, C, D, E, F, G>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F8<A, B, C, D, E, F, G, Z> {
            F8(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 8 generic types
    public final class F8<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T8<A, B, C, D, E, F, G, H>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F9<A, B, C, D, E, F, G, H, Z> {
            F9(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 9 generic types
    public final class F9<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T9<A, B, C, D, E, F, G, H, I>

        public func placeholder<Z: LosslessStringConvertible>(_ name: String, _ type: Z.Type) -> F10<A, B, C, D, E, F, G, H, I, Z> {
            F10(self.components + [":" + name])
        }
    }

    // Generated factory subclass for templates with 10 generic types
    public final class F10<A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible, J: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T10<A, B, C, D, E, F, G, H, I, J>

    }
    // sourcery:end
}
