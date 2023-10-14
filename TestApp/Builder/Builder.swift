//
//  Builder.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit
import AVKit

//MARK: - Builder Protocol

protocol BuilderProtocol: AnyObject {
    static func createItunesViewController() -> UIViewController
}

//MARK: - Builder

class Builder: BuilderProtocol {
    
    static func createItunesViewController() -> UIViewController {
        let view = ItunesViewController()
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let networkService = NetworkService()
        let interactor = ItunesInteractor(networkService: networkService)
        let presenter = ItunesPresenter(view: view, interactor: interactor, router: router)
        interactor.output = presenter
        view.output = presenter
        router.root = view
        return view
    }
    
    static func createPlayerViewController(customItunesModel: CustomItunesModel) -> UIViewController {
        let view = PlayerViewController(customItunesModel: customItunesModel)
        let avKit = AVKitPlayer()
        let interactor = PlayerInteractor(avPlayer: avKit)
        let presenter = PlayerPresenter(view: view, interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        return view
    }
}
