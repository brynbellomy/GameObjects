//
//  SKPhysicsContact+GameObjects.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Oct 24.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit


public extension SKPhysicsContact
{
    /** The `SKNode` that `bodyA` is attached to. */
    public var nodeA : SKNode? { return bodyA.node }

    /** The `SKNode` that `bodyB` is attached to. */
    public var nodeB : SKNode? { return bodyB.node }

    /** Returns true if either `bodyA` or `bodyB` are equal to the `body` argument. */
    public func involvesBody(body:SKPhysicsBody?) -> Bool
    {
        if let body = body? {
            return (bodyA === body || bodyB === body)
        }
        return false
    }


    typealias ContactInvolvesBodyClosure = (body:SKPhysicsBody, otherBody:SKPhysicsBody) -> Void

    /** If the physics contact involves the given body, the provided closure (which is passed the value of `body`) is executed. */
    public func ifInvolvesBody(b:SKPhysicsBody?, closure:ContactInvolvesBodyClosure)
    {
        if let body = b?
        {
            if bodyA === body || bodyB === body {
                closure(body:body, otherBody:bodyOtherThan(body))
            }
        }
    }


    /** Returns the body (either `bodyA` or `bodyB` that is not the one given by the `body` argument. */
    public func bodyOtherThan(body:SKPhysicsBody) -> SKPhysicsBody {
        return (body === bodyA) ? bodyB : bodyA
    }
}

public func contactInvolvesBody (body:SKPhysicsBody) (contact:SKPhysicsContact) -> Bool {
    return contact.bodyA === body || contact.bodyB === body
}

public func bodyOtherThan (body:SKPhysicsBody) (contact:SKPhysicsContact) -> SKPhysicsBody {
    return (body === contact.bodyA) ? contact.bodyB : contact.bodyA
}



