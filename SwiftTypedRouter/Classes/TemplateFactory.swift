//
//  TemplateFactory.swift
//  SwiftTypedRouter
//
//  Created by Sam Dean on 02/02/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation

// MARK: - Template factory

public class TemplateFactoryStart: CustomStringConvertible {

    public static func start() -> TemplateFactory.FX { TemplateFactory.FX() }

    public var description: String {
        "TemplateFactory.Start()"
    }
}

public class TemplateFactory: TemplateFactoryStart {

    public let components: [String]

    public required init(_ components: [String] = []) {
        self.components = components
    }

    public func path(_ path: String...) -> Self {
        return Self(self.components + path)
    }

    override public var description: String {
        "TemplateFactory.\(type(of: self))(path: \"" + self.components.joined(separator: "/") + "\")"
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

        public func path(_ path: String...) -> F0 {
            F0(path)
        }
    }

    public final class F0: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T0

        public func placeholder<T: LosslessStringConvertible>(_ name: String, _ type: T.Type) -> F1<T> {
            F1(self.components + [":" + name])
        }
    }

    public final class F1<T: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T1<T>

        public func placeholder<U: LosslessStringConvertible>(_ name: String, _ type: U.Type) -> F2<T, U> {
            F2(self.components + [":" + name])
        }
    }

    public final class F2<T: LosslessStringConvertible, U: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T2<T, U>

        public func placeholder<V: LosslessStringConvertible>(_ name: String, _ type: V.Type) -> F3<T, U, V> {
            F3(self.components + [":" + name])
        }
    }

    public final class F3<T: LosslessStringConvertible, U: LosslessStringConvertible, V: LosslessStringConvertible>: TemplateFactory, TemplateFactoryMake {
        public typealias TemplateType = Template.T3<T, U, V>
    }
}
