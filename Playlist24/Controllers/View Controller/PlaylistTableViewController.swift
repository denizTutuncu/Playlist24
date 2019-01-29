//
//  PlaylistTableViewController.swift
//  Playlist24
//
//  Created by Deniz Tutuncu on 1/23/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {

    @IBOutlet weak var playlistTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaylistController.shared.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let playlistName = playlistTextField.text,
            playlistName != "" else { return }
        PlaylistController.shared.createPlaylistWith(name: playlistName)
        playlistTextField.text = ""
        self.tableView.reloadData()
        
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlaylistController.shared.playlists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\(playlist.songs.count) Songs"
        
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Identifier
        if segue.identifier == "toPlaylistDetailSegue" {
            //IndexPath
            if let index = tableView.indexPathForSelectedRow {
                //Destination
                if let destinationVC = segue.destination as? SongListTableViewController {
                    // create an object to send
                    let playlistToSend = PlaylistController.shared.playlists[index.row]
                    //set objecto to landing pad
                    destinationVC.playList = playlistToSend
                    
                }
            }
        }
    }
   

}
