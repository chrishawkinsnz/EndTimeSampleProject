//
//  ViewController.swift
//  EndTimeSampleProject
//
//  Created by Chris Hawkins on 11/11/17.
//  Copyright © 2017 Chris Hawkins. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    @IBAction func didSelectPlayFromAppleMusic(_ sender: Any) {
        let storeId = "14922794"
        let descriptor = MPMusicPlayerStoreQueueDescriptor.init(storeIDs: [storeId])
        
        descriptor.setStartTime(0.0, forItemWithStoreID: storeId)
        descriptor.setEndTime(2.0, forItemWithStoreID: storeId)
        play(descriptor: descriptor)
    }
    
    @IBAction func didSelectPlayLocally(_ sender: Any) {
        guard let songCollection =  MPMediaQuery.songs().collections?.first else { return }
        guard let firstSong = songCollection.items.first else { return }
        
        let descriptor = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: songCollection)
        descriptor.setStartTime(0.0, for: firstSong)
        descriptor.setEndTime(2.0, for: firstSong)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.play(descriptor: descriptor)
        }
    }
    
    func play(descriptor: MPMusicPlayerQueueDescriptor) {
        let player = MPMusicPlayerController.applicationMusicPlayer
        player.setQueue(with: descriptor)
        player.play()
    }
}

