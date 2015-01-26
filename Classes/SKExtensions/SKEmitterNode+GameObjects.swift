//
//  SKEmitterNode+GameObjects.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Nov 30.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit


public extension SKEmitterNode
{
    public func runOnceForDuration(duration:NSTimeInterval)
    {
        let action = oneShotActionWithDuration(duration)
        runAction(action)
    }

    public func oneShotActionWithDuration(duration:NSTimeInterval) -> SKAction
    {
        return SKAction.sequence([
            SKAction.waitForDuration(duration),
            SKAction.runBlock { self.particleBirthRate = 0 },
            SKAction.waitForDuration(NSTimeInterval(particleLifetime + particleLifetimeRange)),
            SKAction.removeFromParent(),
        ])
    }
}



