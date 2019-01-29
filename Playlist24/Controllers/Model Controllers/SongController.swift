//
//  SongController.swift
//  Playlist24
//
//  Created by Deniz Tutuncu on 1/23/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import Foundation

class SongController {
    
    static let shared = SongController()
    
    
    
    func createSongWith(name: String, artist: String, playlist: Playlist) {
        let song = Song(name: name, artist: artist)
        
        PlaylistController.shared.add(song: song, toPlaylist: playlist)
        
        
        
    }
  
}
