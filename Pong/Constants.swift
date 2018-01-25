//
//  Constants.swift
//  Pong
//
//  Created by Rafael Rincon on 1/23/18.
//  Copyright © 2018 Rafael Rincon. All rights reserved.
//

import UIKit

struct K {
	struct Paddle {
		static let size = CGSize(width: 20, height: 150)
		static let color = UIColor.white
		
		static let speed: CGFloat = 800
	}
	
	struct Ball {
		static let radius: CGFloat = 15
		static let color = UIColor.white
		static let speedFactor: CGFloat = 200
		static let speedIncrement: CGFloat = 50
	}
	
	struct NodeName {
		static let topWall = "topWall"
		static let rightWall = "rightWall"
		static let bottomWall = "bottomWall"
		static let leftWall = "leftWall"
		static let ball = "ball"
		static let leftPaddle = "leftPaddle"
		static let rightPaddle = "rightPaddle"
		
		static let verticalWallNames = Set<String>(arrayLiteral: leftWall, rightWall)
		static let paddleNames = Set<String>(arrayLiteral: leftPaddle, rightPaddle)
	}
	
	struct Text {
		static let startButtonTitle = "Start!"
	}
	
	struct Spacing {
		static let small: CGFloat = 8
		static let large: CGFloat = 16
	}
	
	struct Label {
		static let stringAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 32),
																	 NSAttributedStringKey.foregroundColor : UIColor.white]
	}
	
	struct Button {
		static let font = UIFont.boldSystemFont(ofSize: 16)
		static let size = CGSize(width: 100, height: 40)
		static let titleColor = UIColor.black
		static let backgroundColor = UIColor.white
	}
}

