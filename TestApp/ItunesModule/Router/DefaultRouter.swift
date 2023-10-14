//
//  DefaultRouter.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit

final class DefaultRouter: Router {
    
    //MARK: - Properties
    
    weak var root: UIViewController?
    private var rootTransition: Transition
    
    //MARK: - Init
    
    init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }
    
    func route(to viewController: UIViewController, as transition: Transition) {
        guard let root = root else { return }
        transition.open(viewController, from: root)
    }
}
