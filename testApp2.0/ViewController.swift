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
        let url = URL(string: "https://d1wst0behutosd.cloudfront.net/videos/14832798/47815650.mp4?Expires=1491998672&Signature=Ummr9nHd6CQEa3HfyNxXm1L7e-3-a7mITPRGjzNVCt~yn-EK19fMRax6zPbBdOt8XYXJuGnzzBoLhC6fm8CNjN0w6UZnXFv9Z40H-d42sakfT6uH24mzFcKo6CVyGcSGhUAHLtfe8-3AL-QjE76onP1qF5J3FAAEpyDYHLDg4i7IMffSQ-7zPeaLajc7goeJFS~02H6p~uKaPeOyVaEybj-kZgym9mS-pIUes~D1-OiJvnE2TVUmNXTYZDCAhzoh5LIsJGPEJAOWT17hkjWfdXYAMjEjnpev5dNv-qhtHW8hyxhNvsiQXD44bfelpWyAkb6REg8C9Iz20MNBLu7PMg__&Key-Pair-Id=APKAJJ6WELAPEP47UKWQ" + videoCode)
        myWebView.loadRequest(URLRequest(url: url!))
    }
    
    


}

