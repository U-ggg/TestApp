//
//  ItunesModel.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import Foundation

//MARK: - ItunesModel

struct ItunesModel: Decodable {
    let results: [SearchTracks]
}

//MARK: - SearchTracks Model

struct SearchTracks: Decodable {
    let artistName: String?
    let trackName: String?
    let previewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
}
