//
//  ViewController.swift
//  AlamofireRSSParser
//
//  Created by Don Angelillo on 03/04/2016.
//  Copyright (c) 2016 Don Angelillo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        // Good old closure example.
        self.closureFetch { rss in
            if let rss = rss {
                /// Do something with your new RSSFeed object!
                for item in rss.items {
                    print(item)
                }
            }
        }

        // Swift concurrency example.
        if #available(iOS 13.0, *) {
            Task.init {
                if let rss = await self.swiftConcurrencyFetch() {
                    print(rss)
                }
            }
        }
    }
    
    func closureFetch(completion: @escaping (_ rss: RSSFeed?) -> ()) {
        let url = "http://feeds.foxnews.com/foxnews/latest?format=xml"
        
        AF.request(url).responseRSS() { (response) -> Void in
            completion(response.value)
        }
    }
    
    
    @available(iOS 13, *)
    func swiftConcurrencyFetch() async -> RSSFeed? {
        let url = "http://feeds.foxnews.com/foxnews/latest?format=xml"
        let rss = await AF.request(url).serializingRSS().response.value
        return rss
    }
}

