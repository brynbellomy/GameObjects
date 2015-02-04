//
//  PhysicalComponent.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Dec 16.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit
import Funky
import Signals


/**
    A component that serves as the `SKPhysicsContactDelegate` for a scene.  It provides
    two signals: `didBeginContact` and `didEndContact`, which fire any time there is a
    physics contact in the scene.
 */
public class PhysicalComponent: NSObject, SKPhysicsContactDelegate
{
    //
    // MARK: - Signals
    //

    public struct Signals
    {
        public init() {}
        public let didBeginContact = Signal<SKPhysicsContact>()
        public let didEndContact   = Signal<SKPhysicsContact>()
    }

    /** The subscribable signals published by the `PhysicalComponent`.  Subscribe to these to receive notifications when contact events occur in the scene.*/
    public let signals = Signals()

    //
    // MARK: - Lifecycle
    //

    override public init() {
        super.init()
    }


    //
    // MARK: - Physics contact callbacks
    //

    public func didBeginContact(contact:SKPhysicsContact) { signals.didBeginContact.fire(contact) }
    public func didEndContact(contact:SKPhysicsContact)   { signals.didEndContact.fire(contact) }

}

