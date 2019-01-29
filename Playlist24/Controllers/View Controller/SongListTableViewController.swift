//
//  SongListTableViewController.swift
//  Playlist24
//
//  Created by Deniz Tutuncu on 1/23/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class SongListTableViewController: UITableViewController {

    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var songArtistTextField: UITextField!
    
    // MARK: - Landing Pad
    var playList: Playlist?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let playlistName = playList?.name else { return }
        self.title = playlistName
        
        //self.title = playlist?.name ?? "Playlist"

    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = songNameTextField.text, name != "",
            let artist = songArtistTextField.text, artist != "",
            let playlist = playList else { return }
        
        SongController.shared.createSongWith(name: name, artist: artist, playlist: playlist)
        songNameTextField.text = ""
        songArtistTextField.text = ""
        self.tableView.reloadData()
        
    }
    
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playList?.songs.count ?? 0
    }
    
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        
        
        let song = playList?.songs[indexPath.row]
        cell.textLabel?.text = song?.name
        cell.detailTextLabel?.text = song?.artist

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let playlist = playList else { return }
            
            let song = playlist.songs[indexPath.row]
            PlaylistController.shared.remove(song: song, fromPlaylist: playlist)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
    }
}
