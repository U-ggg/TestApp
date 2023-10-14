//
//  AVKitService.swift
//  TestApp
//
//  Created by sidzhe on 13.10.2023.
//

import Foundation
import AVKit

//MARK: - Protocol AVKitProtocol

protocol AVKitProtocol: AnyObject {
    func playPause()
    func playTrack(track: String)
    func stopPlay()
}


//MARK: - AVKit

final class AVKitPlayer: AVKitProtocol {
    
    //MARK: - Properties
    
    private lazy var avPlayer: AVPlayer = {
        var player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    //MARK: - Methods
    
    func playPause() {
        let isPlaying = avPlayer.timeControlStatus == .playing
        isPlaying ? avPlayer.pause() : avPlayer.play()
    }
    
    func playTrack(track: String) {
        guard let urlTrack = URL(string: track) else { return }
        let playerItem = AVPlayerItem(url: urlTrack)
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()
    }
    
    func stopPlay() {
        avPlayer.pause()
        avPlayer.replaceCurrentItem(with: nil)
    }
}
