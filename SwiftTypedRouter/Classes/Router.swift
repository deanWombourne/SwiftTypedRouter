import Foundation
import SwiftUI

// MARK: - Router

@available(iOS 13.0, *)
public class Router {

    private var routes: [AnyRoute] = []

    private var aliases: [AnyAlias] = []

    public init() { }
}

@available(iOS 13.0, *)
extension Router {

    private var unmatchedRouteView: AnyView { Text("Oh snap, no route matches").eraseToAnyView() }

    public func view(_ path: Path) -> AnyView {
        let matching = self.routes.reversed().lazy.compactMap { $0.matches(path.path) }.first

        if matching == nil {
            print("Failed to match path", path)
        }

        return matching ?? unmatchedRouteView
    }

    public func view<C>(_ alias: Alias<C>, context: C) -> AnyView {
        // If we match any known aliases then use that template
        return aliases
            .first { $0.identifier == alias.identifier }?
            .apply(context)
            .map { self.view($0) } ?? unmatchedRouteView
    }
}

@available(iOS 13.0, *)
extension Router {

    public func add<V: View>(_ template: Template.T0, action: @escaping () -> V) {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    public func add<A, V: View>(_ template: Template.T1<A>, action: @escaping (A) -> V) where A: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    public func add<A, B, V: View>(_ template: Template.T2<A, B>, action: @escaping (A, B) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    public func add<A, B, C, V: View>(_ template: Template.T3<A, B, C>, action: @escaping (A, B, C) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    public func add<V: View>(path: String, action: @escaping () -> V) {
        self.add(Template.T0(template: path), action: action)
    }

    public func add<A, V: View>(path: String, action: @escaping (A) -> V) where A: LosslessStringConvertible {
        self.add(Template.T1(template: path), action: action)
    }

    public func add<A, B, V: View>(path: String, action: @escaping (A, B) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible {
        self.add(Template.T2(template: path), action: action)
    }

    public func add<A, B, C, V: View>(path: String, action: @escaping (A, B, C) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible {
        self.add(Template.T3(template: path), action: action)
    }
}

@available(iOS 13.0, *)
extension Router {

    public func alias<C>(_ alias: Alias<C>, apply: @escaping (C) -> Path?) {
        if let index = self.aliases.firstIndex(where: { $0.identifier == alias.identifier }) {
            aliases.remove(at: index)
        }
        self.aliases.append(AnyAlias(alias, apply))
    }
}

@available(iOS 13.0, *)
extension Router {

    fileprivate struct AnyRoute: CustomStringConvertible {
        let description: String
        let matches: (String) -> AnyView?

        init<V: View>(template: Template.T0, action: @escaping () -> V) {
            self.description = Self.createDescription(template: template.template, outputType: V.self)
            self.matches = { toMatch in
                guard template.matcher(toMatch) != nil else { return nil }
                return action().eraseToAnyView()
            }
        }

        init<A, V: View>(template: Template.T1<A>, action: @escaping (A) -> V) where A: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches).eraseToAnyView()
            }
        }

        init<A, B, V: View>(template: Template.T2<A, B>, action: @escaping (A, B) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1).eraseToAnyView()
            }
        }

        init<A, B, C, V: View>(template: Template.T3<A, B, C>, action: @escaping (A, B, C) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2).eraseToAnyView()
            }
        }

        private static func createDescription(template: String, outputType: Any.Type, args: Any.Type...) -> String {
            let args = args.isEmpty ? " ()" : " (" + args.map { String(describing: $0) }.joined(separator: ", ") + ")"
            return "Route('\(template)'\(args) -> \(outputType))"
        }
    }
}

@available(iOS 13.0, *)
extension Router {

    fileprivate struct AnyAlias: CustomStringConvertible {
        let identifier: String
        let description: String
        let apply: (Any) -> Path?

        init<C>(_ wrapping: Alias<C>, _ map: @escaping (C) -> Path?) {
            self.identifier = wrapping.identifier
            self.description = "Alias<\(C.self)>('\(wrapping.identifier)')"

            self.apply = { context in
                guard let context = context as? C else { return nil }
                return map(context)
            }
        }
    }
}

@available(iOS 13.0, *)
extension Router {

    public var debugRoutes: String {
        self.routes.map { $0.description }.joined(separator: "\n")
    }

    public var debugAliases: String {
        self.aliases.map { $0.description }.joined(separator: "\n")
    }
}
