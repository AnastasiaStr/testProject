//
//  ViewController.swift
//  testApp2.0
//
//  Created by Anastasia on 11.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVideo(videoCode: "")
    }

    
    func getVideo(videoCode: String) {
        let url = URL(string: "https://d1wst0behutosd.cloudfront.net/videos/14896299/48151590.mp4?Expires=1492117409&Signature=Va3U-cktD7SeIuc19oEFJksIfFYTIrsUhcMFVZTNuNsk78axRAENGTINYjzStSmjYWKZG8wo4MRw22kTZ7iPLvm8DnhWCW~mabI-F7hl2lthROZs4Bo2gLGugmMH9cxdznpxbdvn9fCEX0kELeC31fDdBK7DNo6fu7dDWUU-vlAEBnEdtdQotvx43-mZky10jh84~t1EBatxXollvTspNleYUJNCdcE1t0bjPch-CAJPCyeiJ8mze1u4joXHmEvW6O-MY5jmTg8RpoJ-PtG3UGKnWhmvLgzUr1ISFK-Jrge-Ao0xilNfUA-8Fy-mnKzHznX9sK8IZXT-h1oJzWBnOg__&Key-Pair-Id=APKAJJ6WELAPEP47UKWQ" + videoCode)
        myWebView.loadRequest(URLRequest(url: url!))
    }
    
    


}

