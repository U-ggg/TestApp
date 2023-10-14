//
//  ModalTransition.swift
//  TestApp
//
//  Created by sidzhe on 13.10.2023.
//

import UIKit

//MARK: - ModalTransition

final class ModalTransition: Transition {
    
    func open(_ viewController: UIViewController, from: UIViewController) {
        from.present(viewController, animated: true)
    }
    
    func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
}
