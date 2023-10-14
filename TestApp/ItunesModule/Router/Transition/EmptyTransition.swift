//
//  EmptyTransition.swift
//  TestApp
//
//  Created by sidzhe on 13.10.2023.
//

import UIKit

//MARK: - EmptyTransition

final class EmptyTransition: Transition {
    func open(_ viewController: UIViewController, from: UIViewController) {}
    func close(_ viewController: UIViewController) {}
}
