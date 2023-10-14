//
//  Transition.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit

//MARK: - Transition

protocol Transition: AnyObject {
    func open(_ viewController: UIViewController, from: UIViewController)
    func close(_ viewController: UIViewController)
}
