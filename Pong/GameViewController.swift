//
//  GameViewController.swift
//  Pong
//
//  Created by Rafael Rincon on 1/21/18.
//  Copyright © 2018 Rafael Rincon. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view = SKView(frame: view.frame)
		view.isMultipleTouchEnabled = true
		
		if let view = self.view as? SKView {
			let scene = GameScene(size: view.bounds.size)

			view.presentScene(scene)
		}
    }
	
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
