//
//  AppLevelView.swift
//  testBin
//
//  Created by ZIV LEVY on 03/12/2019.
//  Copyright © 2019 Yamasee. All rights reserved.
//

import Foundation
import UIKit
import Yamasee

class AppLevelView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // YMSHOW - User touches screen
        // 1. when user touches screen - notify YamaseeCore
        YamaseeCore.shared.screenTouched()
        // 2. important - return false to let touch go through
        return false
    }
}
