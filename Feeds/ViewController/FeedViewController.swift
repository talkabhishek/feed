//
//  ViewController.swift
//  Feeds
//
//  Created by Abhishek Singh on 28/10/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import UIKit
import SDWebImage

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
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let feed = feeds[indexPath.row]
        if feed.mediatype == 1 {
            cell.mediaImageView.isHidden = false
            cell.mediaImageView.sd_setImage(with: URL(string: feed.linkurl), completed: nil)
        } else {
            cell.mediaImageView.isHidden = true
        }
        return cell
    }
}
