//
//  Song.swift
//  Playlist24
//
//  Created by Deniz Tutuncu on 1/23/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import Foundation


class Song: Equatable, Codable {
  
    
    
    //Memberwise Initilizer
    init(name: String, artist: String) {
        self.name = name
        self.artist = artist
    }
    let name: String
    let artist: String
    
    
    
    // MARK: - Equatable Method
    static func == (lhs: Song, rhs: Song) -> Bool {
        return (lhs.name == rhs.name) && (lhs.artist == rhs.artist)
    }
}

// extension yapabilirin ya da yukaridaki gibi protocolu class a ekleyip, static func kurabilirsin.

//extension Song: Equatable {
//
//    static func == (lhs: Song, rhs: Song) -> Bool {
//        if lhs.name != rhs.name { return false }
//        if lhs.artist != rhs.artist { return false }
//
//        return true
//    }
//}


