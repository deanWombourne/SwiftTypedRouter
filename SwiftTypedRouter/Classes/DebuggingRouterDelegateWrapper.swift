//
//  DebuggingRouterDelegateWrapper.swift
//  Pods-SwiftTypedRouter_Example
//
//  Created by Sam Dean on 11/02/2020.
//

import Foundation

@available(iOS 13.0, *)
public final class DebuggingRouterDelegateWrapper {

    let wrapping: RouterDelegate?
    let prefix: String

    public init(_ wrapping: RouterDelegate? = nil, prefix: String = "🗺") {
        self.wrapping = wrapping
        self.prefix = prefix
    }

    fileprivate func output(_ router: Router, _ vars: String..., separator: String = ",", terminator: String = "\n") {
        print(self.prefix + " \(router) " + vars.joined(separator: separator), terminator: terminator)
    }
}

@available(iOS 13.0, *)
extension DebuggingRouterDelegateWrapper: RouterDelegate {

    public func router(_ router: Router, willMatchPath path: Path) {
        self.output(router, "will match path \(path)")
        self.wrapping?.router(router, willMatchPath: path)
    }

    public func router(_ router: Router, didMatchPath path: Path, duration: TimeInterval) {
        self.output(router, String(format: "did match path \(path) in %.4fs", duration))
        self.wrapping?.router(router, didMatchPath: path, duration: duration)
    }

    public func router(_ router: Router, failedToMatchPath path: Path, duration: TimeInterval) {
        self.output(router, String(format: "failed to match path \(path) in %.4fs", duration))
        self.wrapping?.router(router, failedToMatchPath: path, duration: duration)
    }

    public func router(_ router: Router, willMatchAliasWithIdentifier identifier: String) {
        self.output(router, "will match alias \(identifier)")
        self.wrapping?.router(router, willMatchAliasWithIdentifier: identifier)
    }

    public func router(_ router: Router,
                       didMatchAliasWithIdentifier identifier: String,
                       forPath path: Path,
                       duration: TimeInterval) {
        self.output(router, String(format: "did match alias \(identifier) to path \(path) in %.4fs", duration))
        self.wrapping?.router(router, didMatchAliasWithIdentifier: identifier, forPath: path, duration: duration)
    }

    public func router(_ router: Router,
                       failedToMatchAliasWithIdentifier identifier: String,
                       reason: AliasMatchError,
                       duration: TimeInterval) {
        self.output(router, String(format: "failed to match alias \(identifier) beacuse \(reason) in %.4fs", duration))
        self.wrapping?.router(router, failedToMatchAliasWithIdentifier: identifier, reason: reason, duration: duration)
    }
}
