import Foundation
import SwiftUI

// MARK: - Router

@available(iOS 13.0, *)
public protocol RouterDelegate: class {

    func router(_ router: Router, willMatchPath path: Path)

    func router(_ router: Router, didMatchPath path: Path, duration: TimeInterval)

    func router(_ router: Router, failedToMatchPath path: Path, duration: TimeInterval)

    func router(_ router: Router, willMatchAliasWithIdentifier identifier: String)

    func router(_ router: Router, didMatchAliasWithIdentifier identifier: String, forPath path: Path, duration: TimeInterval)

    func router(_ router: Router, failedToMatchAliasWithIdentifier identifier: String, reason: AliasMatchError, duration: TimeInterval)
}

@available(iOS 13.0, *)
public enum AliasMatchError: Error {
    case notFound
    case contextReturnedNil
}

@available(iOS 13.0, *)
public class Router: CustomStringConvertible {

    internal private(set) var routes: [AnyRoute] = []

    internal private(set) var aliases: [AnyAlias] = []

    public weak var delegate: RouterDelegate?

    /// A value used to identify this instance of `Router`. This is useful for debugging (it's included in the description when printed to the console).
    /// It's value doesn't affect the operation of the `Router` at all.
    public let identifier: String?

    /// Create a new (empty) Router with the given identifier.
    ///
    /// - parameter identifier: _(optional)_ This parameter can be used to identify the Router being created.
    public init(identifier: String? = nil) {
        self.identifier = identifier
    }

    public var description: String {
        self.identifier.map { "Router(\($0))" } ?? "Router"
    }
}

@available(iOS 13.0, *)
extension Router {

    private func time<T>(work: () -> T) -> (T, TimeInterval) {
        let start = DispatchTime.now()
        let result = work()
        let end = DispatchTime.now()
        return (result, Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000.0)
    }

    private func unmatchedRouteView(path: String) -> AnyView {
        NotFoundView(path: path, router: self).eraseToAnyView()
    }

    public func view(_ path: Path) -> AnyView {
        self.delegate?.router(self, willMatchPath: path)

        let (potentialMatch, duration) = time {
            self.routes.reversed().lazy.compactMap({ $0.matches(path.path) }).first
        }

        guard let match = potentialMatch else {
            print("[Router] Failed to match path '\(path)'")
            self.delegate?.router(self, failedToMatchPath: path, duration: duration)
            return unmatchedRouteView(path: path.path)
        }

        self.delegate?.router(self, didMatchPath: path, duration: duration)

        return match
    }

    /// Wrapper around `view(_:Path)` to accept `String`s
    ///
    /// Even though Path is `StringLiteralConvertable`, we also want `router.view("a/b/"+id)` to work.
    public func view(_ string: String) -> AnyView {
        self.view(Path(string))
    }

    public func view<C>(_ alias: Alias<C>, context: C) -> AnyView {
        let identifier = alias.identifier

        self.delegate?.router(self, willMatchAliasWithIdentifier: identifier)

        let (result, duration) = time { () -> (Result<Path, AliasMatchError>) in
            guard let potential = self.aliases.first(where: { $0.identifier == identifier }) else {
                return .failure(.notFound)
            }

            guard let applied = potential.apply(context) else {
                return .failure(.contextReturnedNil)
            }

            return .success(applied)
        }

        switch result {
        case .failure(let reason):
            self.delegate?.router(self, failedToMatchAliasWithIdentifier: identifier, reason: reason, duration: duration)
            return unmatchedRouteView(path: identifier)
        case .success(let path):
            self.delegate?.router(self, didMatchAliasWithIdentifier: identifier, forPath: path, duration: duration)
            return self.view(path)
        }
    }

    public func view(_ alias: Alias<Void>) -> AnyView {
        self.view(alias, context: ())
    }
}

@available(iOS 13.0, *)
extension Router {

// sourcery:inline:auto:Router.Add
    // Generated add method for templates with 0 generic types
    public func add<V: View>(_ template: Template.T0, action: @escaping () -> V)  {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 0 generic types
    public func add<V: View>(path: String, action: @escaping () -> V)  {
        self.add(Template.T0(template: path), action: action)
    }

    // Generated add method for templates with 1 generic types
    public func add<A, V: View>(_ template: Template.T1<A>, action: @escaping (A) -> V) where A: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 1 generic types
    public func add<A, V: View>(path: String, action: @escaping (A) -> V) where A: LosslessStringConvertible {
        self.add(Template.T1(template: path), action: action)
    }

    // Generated add method for templates with 2 generic types
    public func add<A, B, V: View>(_ template: Template.T2<A, B>, action: @escaping (A, B) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 2 generic types
    public func add<A, B, V: View>(path: String, action: @escaping (A, B) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible {
        self.add(Template.T2(template: path), action: action)
    }

    // Generated add method for templates with 3 generic types
    public func add<A, B, C, V: View>(_ template: Template.T3<A, B, C>, action: @escaping (A, B, C) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 3 generic types
    public func add<A, B, C, V: View>(path: String, action: @escaping (A, B, C) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible {
        self.add(Template.T3(template: path), action: action)
    }

    // Generated add method for templates with 4 generic types
    public func add<A, B, C, D, V: View>(_ template: Template.T4<A, B, C, D>, action: @escaping (A, B, C, D) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 4 generic types
    public func add<A, B, C, D, V: View>(path: String, action: @escaping (A, B, C, D) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible {
        self.add(Template.T4(template: path), action: action)
    }

    // Generated add method for templates with 5 generic types
    public func add<A, B, C, D, E, V: View>(_ template: Template.T5<A, B, C, D, E>, action: @escaping (A, B, C, D, E) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 5 generic types
    public func add<A, B, C, D, E, V: View>(path: String, action: @escaping (A, B, C, D, E) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible {
        self.add(Template.T5(template: path), action: action)
    }

    // Generated add method for templates with 6 generic types
    public func add<A, B, C, D, E, F, V: View>(_ template: Template.T6<A, B, C, D, E, F>, action: @escaping (A, B, C, D, E, F) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 6 generic types
    public func add<A, B, C, D, E, F, V: View>(path: String, action: @escaping (A, B, C, D, E, F) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible {
        self.add(Template.T6(template: path), action: action)
    }

    // Generated add method for templates with 7 generic types
    public func add<A, B, C, D, E, F, G, V: View>(_ template: Template.T7<A, B, C, D, E, F, G>, action: @escaping (A, B, C, D, E, F, G) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 7 generic types
    public func add<A, B, C, D, E, F, G, V: View>(path: String, action: @escaping (A, B, C, D, E, F, G) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible {
        self.add(Template.T7(template: path), action: action)
    }

    // Generated add method for templates with 8 generic types
    public func add<A, B, C, D, E, F, G, H, V: View>(_ template: Template.T8<A, B, C, D, E, F, G, H>, action: @escaping (A, B, C, D, E, F, G, H) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 8 generic types
    public func add<A, B, C, D, E, F, G, H, V: View>(path: String, action: @escaping (A, B, C, D, E, F, G, H) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible {
        self.add(Template.T8(template: path), action: action)
    }

    // Generated add method for templates with 9 generic types
    public func add<A, B, C, D, E, F, G, H, I, V: View>(_ template: Template.T9<A, B, C, D, E, F, G, H, I>, action: @escaping (A, B, C, D, E, F, G, H, I) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 9 generic types
    public func add<A, B, C, D, E, F, G, H, I, V: View>(path: String, action: @escaping (A, B, C, D, E, F, G, H, I) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible {
        self.add(Template.T9(template: path), action: action)
    }

    // Generated add method for templates with 10 generic types
    public func add<A, B, C, D, E, F, G, H, I, J, V: View>(_ template: Template.T10<A, B, C, D, E, F, G, H, I, J>, action: @escaping (A, B, C, D, E, F, G, H, I, J) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible, J: LosslessStringConvertible {
        self.routes.append(AnyRoute(template: template, action: action))
    }

    // Generated add method for paths with 10 generic types
    public func add<A, B, C, D, E, F, G, H, I, J, V: View>(path: String, action: @escaping (A, B, C, D, E, F, G, H, I, J) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible, J: LosslessStringConvertible {
        self.add(Template.T10(template: path), action: action)
    }
// sourcery:end
}

@available(iOS 13.0, *)
extension Router {

    public func alias<C>(_ alias: Alias<C>, apply: @escaping (C) -> Path?) {
        if let index = self.aliases.firstIndex(where: { $0.identifier == alias.identifier }) {
            aliases.remove(at: index)
        }
        self.aliases.append(AnyAlias(alias, apply))
    }

    public func alias(_ alias: Alias<Void>, apply: @escaping () -> Path?) {
        if let index = self.aliases.firstIndex(where: { $0.identifier == alias.identifier }) {
            aliases.remove(at: index)
        }
        self.aliases.append(AnyAlias(alias, { _ in apply() }))
    }
}

@available(iOS 13.0, *)
extension Router {

    struct AnyRoute: CustomStringConvertible {
        let description: String
        let debugView: () -> AnyView
        let matches: (String) -> AnyView?

        // sourcery:inline:auto:Router.AnyRoute.Init
        // Generated init method for templates with 0 generic types
        init<V: View>(template: Template.T0, action: @escaping () -> V)  {
            self.description = Self.createDescription(template: template.template, outputType: V.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action().eraseToAnyView()
            }
        }

        // Generated init method for templates with 1 generic types
        init<A, V: View>(template: Template.T1<A>, action: @escaping (A) -> V) where A: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches).eraseToAnyView()
            }
        }

        // Generated init method for templates with 2 generic types
        init<A, B, V: View>(template: Template.T2<A, B>, action: @escaping (A, B) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1).eraseToAnyView()
            }
        }

        // Generated init method for templates with 3 generic types
        init<A, B, C, V: View>(template: Template.T3<A, B, C>, action: @escaping (A, B, C) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2).eraseToAnyView()
            }
        }

        // Generated init method for templates with 4 generic types
        init<A, B, C, D, V: View>(template: Template.T4<A, B, C, D>, action: @escaping (A, B, C, D) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2, matches.3).eraseToAnyView()
            }
        }

        // Generated init method for templates with 5 generic types
        init<A, B, C, D, E, V: View>(template: Template.T5<A, B, C, D, E>, action: @escaping (A, B, C, D, E) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2, matches.3, matches.4).eraseToAnyView()
            }
        }

        // Generated init method for templates with 6 generic types
        init<A, B, C, D, E, F, V: View>(template: Template.T6<A, B, C, D, E, F>, action: @escaping (A, B, C, D, E, F) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2, matches.3, matches.4, matches.5).eraseToAnyView()
            }
        }

        // Generated init method for templates with 7 generic types
        init<A, B, C, D, E, F, G, V: View>(template: Template.T7<A, B, C, D, E, F, G>, action: @escaping (A, B, C, D, E, F, G) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2, matches.3, matches.4, matches.5, matches.6).eraseToAnyView()
            }
        }

        // Generated init method for templates with 8 generic types
        init<A, B, C, D, E, F, G, H, V: View>(template: Template.T8<A, B, C, D, E, F, G, H>, action: @escaping (A, B, C, D, E, F, G, H) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self, H.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self, H.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2, matches.3, matches.4, matches.5, matches.6, matches.7).eraseToAnyView()
            }
        }

        // Generated init method for templates with 9 generic types
        init<A, B, C, D, E, F, G, H, I, V: View>(template: Template.T9<A, B, C, D, E, F, G, H, I>, action: @escaping (A, B, C, D, E, F, G, H, I) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self, H.self, I.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self, H.self, I.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2, matches.3, matches.4, matches.5, matches.6, matches.7, matches.8).eraseToAnyView()
            }
        }

        // Generated init method for templates with 10 generic types
        init<A, B, C, D, E, F, G, H, I, J, V: View>(template: Template.T10<A, B, C, D, E, F, G, H, I, J>, action: @escaping (A, B, C, D, E, F, G, H, I, J) -> V) where A: LosslessStringConvertible, B: LosslessStringConvertible, C: LosslessStringConvertible, D: LosslessStringConvertible, E: LosslessStringConvertible, F: LosslessStringConvertible, G: LosslessStringConvertible, H: LosslessStringConvertible, I: LosslessStringConvertible, J: LosslessStringConvertible {
            self.description = Self.createDescription(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self, H.self, I.self, J.self)
            self.debugView = Self.createDebugView(template: template.template, outputType: V.self, args: A.self, B.self, C.self, D.self, E.self, F.self, G.self, H.self, I.self, J.self)
            self.matches = { (toMatch: String) in
                guard let matches = template.matcher(toMatch) else { return nil }
                return action(matches.0, matches.1, matches.2, matches.3, matches.4, matches.5, matches.6, matches.7, matches.8, matches.9).eraseToAnyView()
            }
        }
        // sourcery:end

        private static func createDescription(template: String, outputType: Any.Type, args: Any.Type...) -> String {
            let args = args.isEmpty ? " ()" : " (" + args.map { String(describing: $0) }.joined(separator: ", ") + ")"
            return "Route('\(template)'\(args) -> \(outputType))"
        }

        private static func createDebugView(template: String, outputType: Any.Type, args: Any.Type...) -> () -> AnyView {
            {
                HStack {
                    Text(template)
                        .font(Font.body.weight(.semibold))
                    Text("(" + args.map { String(describing: $0) }.joined(separator: ", ") + ") -> " + String(describing: outputType.self))
                        .font(.body)
                }
                    .fixedSize(horizontal: true, vertical: false)
                    .eraseToAnyView()
            }
        }
    }
}

@available(iOS 13.0, *)
extension Router {

    struct AnyAlias: CustomStringConvertible {
        let identifier: String
        let description: String
        let debugView: () -> AnyView
        let apply: (Any) -> Path?

        init<C>(_ wrapping: Alias<C>, _ map: @escaping (C) -> Path?) {
            self.identifier = wrapping.identifier
            self.description = "Alias<\(C.self)>('\(wrapping.identifier)')"

            self.debugView = {
                HStack {
                    Text(wrapping.identifier)
                        .font(Font.body.weight(.semibold))
                        .fixedSize(horizontal: false, vertical: false)
                    if C.self != Void.self {
                        Text("<\(String(describing: C.self))>")
                            .font(.body)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
                    .fixedSize(horizontal: true, vertical: false)
                    .eraseToAnyView()
            }

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
