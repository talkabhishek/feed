//
//  ViewController.swift
//  Feeds
//
//  Created by Abhishek Singh on 28/10/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation
import AVKit

class FeedViewController: UIViewController {

    var feeds:[Feed] = []
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = 310
        parseJSONFile()
    }
    
    func parseJSONFile() {
        if let path = Bundle.main.path(forResource: "jsonResponse", ofType: "txt") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let feedResponse = try decoder.decode(FeedResponse.self, from: data)
                debugPrint(feedResponse.resource.count)
                feeds = feedResponse.resource
                feedTableView.reloadData()
            } catch let err {
                debugPrint(err)
            }
        }
    }

}

extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let feed = feeds[indexPath.row]
        if feed.mediatype == 1 {
            if let image = SDImageCache.shared().imageFromDiskCache(forKey: feed.linkurl) {
                let imageCrop = image.getCropRatio()
                return tableView.frame.width / imageCrop + 110
            }
            else if let image = SDImageCache.shared().imageFromMemoryCache(forKey: feed.linkurl) {
                let imageCrop = image.getCropRatio()
                return tableView.frame.width / imageCrop + 110
            }
            return tableView.frame.width + 110
        }
        else if let url = URL(string: feed.linkurl) {
            let asset = AVAsset(url: url)
            let track = asset.tracks(withMediaType: .video)[0]
            let ratio = track.naturalSize.width / track.naturalSize.height
            return tableView.frame.width / ratio + 110
        }
        return tableView.frame.width + 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let feed = feeds[indexPath.row]
        let url = URL(string: feed.linkurl)
        if feed.mediatype == 1 {
            cell.mediaVideoView.isHidden = true
            cell.mediaImageView.isHidden = false
            cell.mediaImageView.sd_setImage(with: url, completed: nil)
        } else if let url = url {
            cell.mediaImageView.isHidden = true
            cell.mediaVideoView.isHidden = false
            debugPrint(url)
            let playerItem = CachingPlayerItem(url: url)
            playerItem.download()
            playerItem.delegate = self
            let player = AVPlayer(playerItem: playerItem)
            player.automaticallyWaitsToMinimizeStalling = false
            cell.mediaVideoView.playerLayer.player = player
            cell.mediaVideoView.player?.play()
        }
        return cell
    }
    
}
extension FeedViewController: CachingPlayerItemDelegate {
    
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded and ready for storing")
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, didDownloadBytesSoFar bytesDownloaded: Int, outOf bytesExpected: Int) {
        print("\(bytesDownloaded)/\(bytesExpected)")
    }
    
    func playerItemPlaybackStalled(_ playerItem: CachingPlayerItem) {
        print("Not enough data for playback. Probably because of the poor network. Wait a bit and try to play later.")
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, downloadingFailedWith error: Error) {
        print(error)
    }
    
}
