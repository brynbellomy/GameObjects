//
//  ExplosionFX.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2015 Jan 28.
//  Copyright (c) 2015 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit


public struct ExplosionFX
{
    public let emitter:  SKEmitterNode
    public let duration: NSTimeInterval

    public init(emitter e:SKEmitterNode, duration d:NSTimeInterval) { //, radius r:CGFloat) {
        emitter = e
        duration = d
    }

    public func explode() {
        emitter.zPosition = 999
        emitter.runOnceForDuration(duration)
    }
}


