//
//  ItunesInteractor.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit

//MARK: - Protocols

protocol ItunesInteractorInput: AnyObject {
    var output: ItunesInteractorOutput? { get set }
    func searchTrack(search: String)
    func getRowsCount() -> Int
    func saveCustomModel(_ model: [CustomItunesModel]?)
    func getCustomModel() -> [CustomItunesModel]?
}

protocol ItunesInteractorOutput: AnyObject {
    func sendModes(trackModel: [SearchTracks], images: [UIImage])
    func update()
}

//MARK: - ItunesInteractor

final class ItunesInteractor: ItunesInteractorInput {
    
    //MARK: - Properties
    
    weak var output: ItunesInteractorOutput?
    var networkService: NetworkServiceProtocol
    var searchTracksModel: [SearchTracks]?
    var customItunesModel: [CustomItunesModel]?
    
    //MARK: - Init
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: - Update Custom Model
    
    func saveCustomModel(_ model: [CustomItunesModel]?) {
        output?.update()
        self.customItunesModel = model
    }
    
    //MARK: - Fetch Data
    
    func searchTrack(search: String) {
        
        networkService.searchTrack(search: search) { [weak self] (result: Result<ItunesModel, RequestError>) in
            
            guard let self else { return }
            
            switch result {
                
            case .success(let data):
                self.searchTracksModel = data.results
                loadImages()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Load Image
    
    func loadImages() {
        guard let searchTracksModel = searchTracksModel else { return }
        
        networkService.loadImage(from: searchTracksModel) { [weak self] (result: Result<[UIImage], RequestError>) in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let images):
                sleep(1)
                output?.sendModes(trackModel: searchTracksModel, images: images)
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
    
    //MARK: - Send data from view
    
    func getRowsCount() -> Int {
        guard let customItunesModel = customItunesModel else { return 0 }
        return customItunesModel.count
    }
    
    func getCustomModel() -> [CustomItunesModel]? {
        guard let customItunesModel = customItunesModel else { return nil }
        return customItunesModel
    }
}
