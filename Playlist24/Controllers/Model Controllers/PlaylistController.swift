//
//  PlaylistController.swift
//  Playlist24
//
//  Created by Deniz Tutuncu on 1/23/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import Foundation

class PlaylistController {
    
    // MARK: Shared Instances / Singleton
    static let shared = PlaylistController()
    
    
    
    // MARK: Source of Truth
    var playlists: [Playlist] = []
    
    //    init() {
    //       // _ = findURL()
    // ya da bu method du playlistTableViewController icinde bu classiin singleton ina ulasarak cagirabilirsinb.
    //        loadFromPersistentStore()
    //    }
    
    
    
    func createPlaylistWith(name: String) {
        let playlist = Playlist(name: name)
        playlists.append(playlist)
        saveToPersistenceStore()
        
        
    }
    
    
    func deletePlaylist(playlist: Playlist) {
        guard let index = playlists.index(of: playlist) else { return }
        playlists.remove(at: index)
        saveToPersistenceStore()
    }
    
    func add(song: Song, toPlaylist playlist: Playlist) {
        playlist.songs.append(song)
        saveToPersistenceStore()
        
    }
    
    func remove(song: Song, fromPlaylist playlist: Playlist) {
        guard let index = playlist.songs.index(of : song) else { return }
        playlist.songs.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    
    // Get the url where we are saving our data
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "playlists.json"
        let fullURL = documentDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    // Save the data at the url
    func saveToPersistenceStore() {
        //Create an instance of JSONEncoder
        let encoder = JSONEncoder()
        
        do {
            //Encode our data so that it can be saved
            let playlistAsData = try encoder.encode(playlists)
            //            print(data)
            //            print(String(data: data, encoding: .utf8)!)
            try playlistAsData.write(to: fileURL())
            
        } catch let error {
            print(error)
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    //Fetch the data from the url
    func loadFromPersistentStore() {
        
        // Create an Instance of JSONDecoder
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedPlaylists = try decoder.decode([Playlist].self, from: data)
            // Set our source of truth
            self.playlists = decodedPlaylists
        } catch let error {
            print(error)
            print("There was an error loading from the persistent store: \(error.localizedDescription)")
        }
        
    }
}
