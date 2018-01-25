//
//  GameScene.swift
//  Pong
//
//  Created by Rafael Rincon on 1/21/18.
//  Copyright © 2018 Rafael Rincon. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	private let leftPaddle = SKShapeNode(paddleSize: K.Paddle.size)
	private let rightPaddle = SKShapeNode(paddleSize: K.Paddle.size)
	
	private let ball = SKShapeNode(circleOfRadius: K.Ball.radius)
	
	private var upperLeftTouch: UITouch?
	private var lowerLeftTouch: UITouch?
	private var upperRightTouch: UITouch?
	private var lowerRightTouch: UITouch?
	
	private let winningScore = 10
	private var leftScore: Int = 0
	private var rightScore: Int = 0
	private let leftScoreLabelNode = SKLabelNode.scoreLabelNode()
	private let rightScoreLabelNode = SKLabelNode.scoreLabelNode()
	
	private var startButton = SKButton()
	
    override func didMove(to view: SKView) {
		super.didMove(to: view)
		scaleMode = .aspectFit

		physicsWorld.gravity = .zero
		physicsWorld.contactDelegate = self
		
		addChild(leftScoreLabelNode)
		leftScoreLabelNode.position.x = size.width / 4
		leftScoreLabelNode.position.y = size.height - leftScoreLabelNode.frame.height / 2 - K.Spacing.large
		
		addChild(rightScoreLabelNode)
		rightScoreLabelNode.position.x = size.width * 3 / 4
		rightScoreLabelNode.position.y = leftScoreLabelNode.position.y
		
		leftPaddle.name = K.NodeName.leftPaddle
		leftPaddle.position.x = K.Paddle.size.width * 1.5
		leftPaddle.position.y = size.height / 2
		leftPaddle.constraints = [SKConstraint.positionX(SKRange(constantValue: K.Paddle.size.width * 1.5), y: SKRange(lowerLimit: K.Paddle.size.height / 2, upperLimit: size.height - K.Paddle.size.height / 2))]
		
		addChild(leftPaddle)
		
		rightPaddle.name = K.NodeName.rightPaddle
		rightPaddle.position.x = size.width - K.Paddle.size.width * 1.5
		rightPaddle.position.y = size.height / 2
		rightPaddle.constraints = [SKConstraint.positionX(SKRange(constantValue: size.width - K.Paddle.size.width * 1.5), y: SKRange(lowerLimit: K.Paddle.size.height / 2, upperLimit: size.height - K.Paddle.size.height / 2))]
		
		addChild(rightPaddle)
		
		ball.name = K.NodeName.ball
		ball.fillColor = K.Ball.color
		ball.strokeColor = K.Ball.color
		
		ball.physicsBody = SKPhysicsBody(circleOfRadius: K.Ball.radius)
		ball.physicsBody?.friction = 0
		ball.physicsBody?.restitution = 1
		ball.physicsBody?.linearDamping = 0
		ball.physicsBody?.collisionBitMask = 1
		ball.physicsBody?.contactTestBitMask = 1

		ball.position.x = size.width / 2
		ball.position.y = size.height / 2
		
		addChild(ball)
		
		let leftWall = SKNode()
		leftWall.name = K.NodeName.leftWall
		leftWall.physicsBody = SKPhysicsBody.wallWithRectangleOf(size: CGSize(width: K.Ball.radius * 2, height: size.height))
		leftWall.position.x = -K.Ball.radius
		leftWall.position.y = size.height / 2
		addChild(leftWall)
		
		let rightWall = SKNode()
		rightWall.name = K.NodeName.rightWall
		rightWall.physicsBody = SKPhysicsBody.wallWithRectangleOf(size: CGSize(width: K.Ball.radius * 2, height: size.height))
		rightWall.position.x = size.width + K.Ball.radius
		rightWall.position.y = size.height / 2
		addChild(rightWall)
		
		let topWall = SKNode()
		topWall.name = K.NodeName.topWall
		topWall.physicsBody = SKPhysicsBody.wallWithRectangleOf(size: CGSize(width: size.width, height: K.Ball.radius * 2))
		topWall.position.x = size.width / 2
		topWall.position.y = size.height + K.Ball.radius
		addChild(topWall)
		
		let bottomWall = SKNode()
		bottomWall.name = K.NodeName.bottomWall
		bottomWall.physicsBody = SKPhysicsBody.wallWithRectangleOf(size: CGSize(width: size.width, height: K.Ball.radius * 2))
		bottomWall.position.x = size.width / 2
		bottomWall.position.y = -K.Ball.radius
		addChild(bottomWall)
		
		startButton = SKButton(title: K.Text.startButtonTitle) { (button: SKButton) in
			self.startGame()
			button.isEnabled = false
		}
		
		addChild(startButton)
		
		startButton.position.x = size.width / 2
		startButton.position.y = startButton.frame.height * 1.5
		
	}
	
	// MARK: Game Control
	
	private func startGame() {
		resetBallPosition()
		resetLabels()
		startBall()
	}
	
	private func startBall() {
		ball.physicsBody?.velocity.dx = arc4random() % 2 == 0 ? K.Ball.speedFactor : -K.Ball.speedFactor
		ball.physicsBody?.velocity.dy = arc4random() % 2 == 0 ? K.Ball.speedFactor : -K.Ball.speedFactor
	}
	
	private func resetBallPosition() {
		// cannot set SKNode position while it has a physicsbody
		let ballPhysicsBody = ball.physicsBody!
		ball.physicsBody = nil
		ball.position = CGPoint(x: size.width / 2, y: size.height / 2)
		ball.physicsBody = ballPhysicsBody
	}
	
	private func resetLabels() {
		rightScoreLabelNode.attributedText = rightScoreLabelNode.attributedText?.with(newString: "0")
		leftScoreLabelNode.attributedText = leftScoreLabelNode.attributedText?.with(newString: "0")
	}
	
	// MARK: - Touch
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
			let location = touch.location(in: self)
			
			if location.x < size.width / 2 {
				if location.y > size.height / 2 && upperLeftTouch == nil {
					upperLeftTouch = touch
					leftPaddle.physicsBody?.velocity.dy = K.Paddle.speed
				} else if lowerLeftTouch == nil {
					lowerLeftTouch = touch
					leftPaddle.physicsBody?.velocity.dy = -K.Paddle.speed
				}
			} else {
				if location.y > size.height / 2 && upperRightTouch == nil {
					upperRightTouch = touch
					rightPaddle.physicsBody?.velocity.dy = K.Paddle.speed
				} else if lowerRightTouch == nil {
					lowerRightTouch = touch
					rightPaddle.physicsBody?.velocity.dy = -K.Paddle.speed
				}
			}
		}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
			if upperLeftTouch != nil && touch == upperLeftTouch! {
				upperLeftTouch = nil
				leftPaddle.physicsBody?.velocity.dy = lowerLeftTouch == nil ? 0 : -K.Paddle.speed
			} else if lowerLeftTouch != nil && touch == lowerLeftTouch! {
				lowerLeftTouch = nil
				leftPaddle.physicsBody?.velocity.dy = upperLeftTouch == nil ? 0 : K.Paddle.speed
			} else if upperRightTouch != nil && touch == upperRightTouch! {
				upperRightTouch = nil
				rightPaddle.physicsBody?.velocity.dy = lowerRightTouch == nil ? 0 : -K.Paddle.speed
			} else if lowerRightTouch != nil && touch == lowerRightTouch! {
				lowerRightTouch = nil
				rightPaddle.physicsBody?.velocity.dy = upperRightTouch == nil ? 0 : K.Paddle.speed
			}
		}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
	
	// MARK: - Physics Contact Delegate
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }

		var bodyNames = Set<String>()
		if nodeA.name != nil {
			bodyNames.insert(nodeA.name!)
		}
		if nodeB.name != nil {
			bodyNames.insert(nodeB.name!)
		}
		
		if bodyNames.contains(K.NodeName.ball) {
			if !bodyNames.intersection(K.NodeName.paddleNames).isEmpty {
				ball.physicsBody?.velocity.dx += K.Ball.speedIncrement
				ball.physicsBody?.velocity.dy += K.Ball.speedIncrement
			} else if !bodyNames.intersection(K.NodeName.verticalWallNames).isEmpty {
				resetBallPosition()
				startBall()
				if bodyNames.contains(K.NodeName.leftWall)  {
					rightScore += 1
					rightScoreLabelNode.attributedText = rightScoreLabelNode.attributedText?.with(newString: "\(rightScore)")
				} else if bodyNames.contains(K.NodeName.rightWall) {
					leftScore += 1
					leftScoreLabelNode.attributedText = leftScoreLabelNode.attributedText?.with(newString: "\(leftScore)")
				}
				
				if leftScore >= winningScore || rightScore >= winningScore {
					ball.physicsBody?.velocity = .zero
					startButton.isEnabled = true
					leftScore = 0
					rightScore = 0
				}
			}
		}
	}

	// MARK: -
}
