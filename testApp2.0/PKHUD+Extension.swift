//
//  PKHUD+Extension.swift
//  testApp2.0
//
//  Created by Anastasia on 17.04.17.
//  Copyright © 2017 Anastasia. All rights reserved.
//

import PKHUD

extension HUD {
    
    static func showProgress(hideTimeout: TimeInterval = 30) {
        guard Utils.isInternetAvailable else { return }
        self.show(.progress)
        self.hide(afterDelay: hideTimeout)
    }
    
}
