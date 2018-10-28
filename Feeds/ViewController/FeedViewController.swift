//
//  ViewController.swift
//  Feeds
//
//  Created by Abhishek Singh on 28/10/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSONFile()
    }
    
    func parseJSONFile() {
        if let path = Bundle.main.path(forResource: "jsonResponse", ofType: "txt") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let feedResponse = try decoder.decode(FeedResponse.self, from: data)
                debugPrint(feedResponse.resource.count)
                for feed in feedResponse.resource {
                    debugPrint(feed.mediatype)
                    debugPrint(feed.linkurl)
                }
            } catch let err {
                debugPrint(err)
            }
        }
    }

}

