//
//  SKButton.swift
//  Pong
//
//  Created by Rafael Rincon on 1/23/18.
//  Copyright © 2018 Rafael Rincon. All rights reserved.
//

import SpriteKit

class SKButton: SKShapeNode {
	
	private var action: ((SKButton) -> Void)?
	private let titleLabelNode = SKLabelNode()
	
	var isEnabled = true {
		willSet(newValue) {
			print("setting isEnabled to \(newValue)")
			if newValue {
				isHidden = false
				titleLabelNode.isHidden = false
			} else {
				isHidden = true
				titleLabelNode.isHidden = true
			}
		}
	}
	private var tappingTouch: UITouch?
	
	convenience init(title: String, action: @escaping (SKButton) -> Void) {
		self.init(rect: CGRect(origin: CGPoint(x: -K.Button.size.width / 2, y: -K.Button.size.height / 2), size: K.Button.size))
		self.action = action
		
		isUserInteractionEnabled = true
		
		fillColor = K.Button.backgroundColor
		strokeColor = K.Button.backgroundColor
	
		titleLabelNode.verticalAlignmentMode = .center
		titleLabelNode.attributedText = NSAttributedString(string: K.Text.startButtonTitle, attributes:
			[.font: K.Button.font,
			 .foregroundColor: UIColor.black])
		addChild(titleLabelNode)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard isEnabled && tappingTouch == nil else { return }
		
		if !touches.isEmpty {
			tappingTouch = touches.first!
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard isEnabled && tappingTouch != nil else { return }
		
		if touches.contains(tappingTouch!) {
			tappingTouch = nil
			action?(self)
		}
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard isEnabled && tappingTouch != nil else { return }
		
		if touches.contains(tappingTouch!) {
			tappingTouch = nil
		}
	}
}
