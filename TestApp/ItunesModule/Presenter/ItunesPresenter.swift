//
//  ItunesPresenter.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit

//MARK: - Protocols

protocol ItunesPresenterInput: AnyObject {
    var output: ItunesPresenterOutput? { get set }
}

protocol ItunesPresenterOutput: AnyObject {
    
}

//MARK: - ItunesPresenter

final class ItunesPresenter {
    
    //MARK: - Properties
    
    weak var output: ItunesPresenterOutput?
    
    private let interactor: ItunesInteractorInput
    private let view: ItunesViewControllerInput
    private let router: Router
    
    //MARK: - Init
    
    init(view: ItunesViewControllerInput, interactor: ItunesInteractorInput, router: Router) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    //MARK: - Methods
    
    func searchTrack(search: String) {
        interactor.searchTrack(search: search)
    }
    
    func checkWordsCount(text: String) -> Bool {
        text.split(separator: " ").count >= 3 ? true : false
    }
    
    func startPlaying(at indexPath: IndexPath) {
        guard let model = interactor.getCustomModel()?[indexPath.row] else { return }
        router.route(to: Builder.createPlayerViewController(customItunesModel: model), as: ModalTransition())
    }
    
    private func saveCustomModel(_ model: [CustomItunesModel]) -> [CustomItunesModel] {
        return model
    }
}


//MARK: - Extension ItunesInteractorOutput

extension ItunesPresenter: ItunesInteractorOutput {
    
    func update() {
        view.update()
    }
    
    func sendModes(trackModel: [SearchTracks], images: [UIImage]) {
        
        var customItunesModel = [CustomItunesModel]()
        
        for (modelA, modelB) in zip(trackModel, images) {
            guard let trackName = modelA.trackName, let artistName = modelA.artistName, let url = modelA.previewUrl else { return }
            let element = CustomItunesModel(trackName: trackName, artistName: artistName, image: modelB, trackUrl: url)
            customItunesModel.append(element)
        }
        
        interactor.saveCustomModel(customItunesModel)
    }
}


//MARK: - Extension ItunesViewControllerOutput

extension ItunesPresenter: ItunesViewControllerOutput {
    
    func getRowsCount() -> Int {
        interactor.getRowsCount()
    }
    
    func getCustomModel() -> [CustomItunesModel]? {
        interactor.getCustomModel()
    }
}
