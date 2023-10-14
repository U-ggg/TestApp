//
//  PlayerPresenter.swift
//  TestApp
//
//  Created by sidzhe on 13.10.2023.
//

import Foundation

//MARK: - Protocols

protocol PlayerPresenterInput: AnyObject {
    var output: PlayerPresenterOutput? { get set }
}

protocol PlayerPresenterOutput: AnyObject {
    
}


//MARK: - PlayerPresenter

final class PlayerPresenter: PlayerViewControllerOutput {
    
    //MARK: - Properties
    
    weak var output: PlayerPresenterOutput?
    
    private let interactor: PlayerInteractorInput
    private let view: PlayerViewControllerInput
    
    //MARK: - Init
    
    init(view: PlayerViewControllerInput, interactor: PlayerInteractorInput) {
        self.interactor = interactor
        self.view = view
    }
    
    //MARK: - Player methods
    
    func playTrack(track: String) {
        interactor.playTrack(track: track)
    }
    
    func playPause() {
        interactor.playPause()
    }
    
    func stopPlaying() {
        interactor.stopPlaying()
    }
}

extension PlayerPresenter: PlayerInteractorOutput {}

