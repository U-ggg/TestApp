//
//  PlayerInteractor.swift
//  TestApp
//
//  Created by sidzhe on 13.10.2023.
//

import Foundation

//MARK: - Protocols

protocol PlayerInteractorInput: AnyObject {
    var output: PlayerInteractorOutput? { get set }
    func playTrack(track: String)
    func playPause()
    func stopPlaying()
}

protocol PlayerInteractorOutput: AnyObject {
    
}

//MARK: - PlayerInteractor

final class PlayerInteractor: PlayerInteractorInput {
    
    //MARK: - Properties
    
    weak var output: PlayerInteractorOutput?
    private var avPlayer: AVKitProtocol?
    
    //MARK: - init
    
    init(avPlayer: AVKitProtocol) {
        self.avPlayer = avPlayer
    }
    
    //MARK: - Methods
    
    func playTrack(track: String) {
        avPlayer?.playTrack(track: track)
    }
    
    func playPause() {
        avPlayer?.playPause()
    }
    
    func stopPlaying() {
        avPlayer?.stopPlay()
        avPlayer = nil
    }
}
