//
//  Extensions.swift
//  Pong
//
//  Created by Rafael Rincon on 1/23/18.
//  Copyright © 2018 Rafael Rincon. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
	
	convenience init(paddleSize: CGSize) {
		let paddleRect = CGRect(origin: CGPoint(x: -paddleSize.width / 2, y: -paddleSize.height / 2), size: paddleSize)
		self.init(rect: paddleRect, cornerRadius: paddleSize.width / 2)
		
		fillColor = K.Paddle.color
		strokeColor = K.Paddle.color
		
		physicsBody = SKPhysicsBody(polygonFrom: self.path!)
		physicsBody?.allowsRotation = false
		physicsBody?.friction = 0
		physicsBody?.restitution = 1
		physicsBody?.linearDamping = 0
		physicsBody?.collisionBitMask = 0
		physicsBody?.contactTestBitMask = 1
	}
}

extension SKPhysicsBody {
	
	static func wallWithRectangleOf(size: CGSize) -> SKPhysicsBody {
		let physicsBody = SKPhysicsBody(rectangleOf: size)
		physicsBody.isDynamic = false
		physicsBody.restitution = 1
		physicsBody.friction = 0
		physicsBody.collisionBitMask = 0
		physicsBody.contactTestBitMask = 1
		return physicsBody
	}
}

extension SKLabelNode {
	static func scoreLabelNode() -> SKLabelNode {
		let labelNode = SKLabelNode(attributedText: NSAttributedString(string: "0", attributes: K.Label.stringAttributes))
		labelNode.color = .clear
		labelNode.verticalAlignmentMode = .center
		return labelNode
	}
}

extension NSAttributedString {
	func with(newString: String) -> NSAttributedString {
		let mutableAttributedString = NSMutableAttributedString(attributedString: self)
		mutableAttributedString.mutableString.setString(newString)
		return mutableAttributedString
	}
}


