//
//  Router.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit

//MARK: - Protocol Routable

protocol Routable {
    func route(to viewController: UIViewController, as transition: Transition)
}

//MARK: - Protocol Router

protocol Router: Routable {
    var root: UIViewController? { get set }
}
