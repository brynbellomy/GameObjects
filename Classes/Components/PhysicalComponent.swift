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

