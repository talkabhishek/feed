//
//  Feed.swift
//  Feeds
//
//  Created by Abhishek Singh on 28/10/18.
//  Copyright © 2018 Abhishek Singh. All rights reserved.
//

import Foundation
import UIKit

struct Feed : Codable {
    let mediatype: Int
    let linkurl: String
    var ratio: CGFloat?
}
