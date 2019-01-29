//
//  Playlist.swift
//  Playlist24
//
//  Created by Deniz Tutuncu on 1/23/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import Foundation

class Playlist: Codable {
    
 
    var name: String
    var songs: [Song]
    // var songs: [Song] = []
    
    init(name: String) {
        self.name = name
        self.songs = []
    }
}

extension Playlist: Equatable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        if lhs.name != rhs.name { return false }
        if lhs.songs != rhs.songs { return false }
        return true
    }
    
    
}


