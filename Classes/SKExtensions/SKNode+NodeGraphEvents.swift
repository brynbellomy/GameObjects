//
//  SKNode+NodeGraphEvents.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Nov 25.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit
import BrynSwift
import Funky
import Signals
import SwiftConfig


private let SignalsKey = AssociatedObjectComponent.CreateKey()

public extension SKNode
{
    /**
        MARK: Signals
     */
    public class Signals
    {
        public init() {}
        let didMoveToParent    = Signal<Void>()
        let willMoveFromParent = Signal<Void>()
    }

    public var signals : SKNode.Signals {
        return self.bk_associatedObjects.valueForKey(SignalsKey) { Signals() }
    }

    public func didMoveToScene() {
        for child in children {
            child.didMoveToScene()
        }
    }

    public func willMoveFromScene() {
        for child in children {
            child.willMoveFromScene()
        }
    }

    /** This method is intended to be overridden by subclasses. */
    public func didMoveToParent() {
        signals.didMoveToParent.fire()
    }

    /** This method is intended to be overridden by subclasses. */
    public func willMoveFromParent() {
        signals.willMoveFromParent.fire()
    }

    public func addChildAndNotify(child:SKNode)
    {
        addChild(child)

        child.didMoveToParent()
        if let scene = scene? {
            child.didMoveToScene()
        }
    }


    public func insertChildAndNotify(child:SKNode, atIndex index:Int)
    {
        insertChild(child, atIndex:index)

        child.didMoveToParent()
        if let scene = scene? {
            child.didMoveToScene()
        }
    }


    // @@TODO : how to call this with generics?
    public func removeFromParentAndNotify()
    {
        willMoveFromParent()
        willMoveFromScene()
        removeFromParent()
    }


    public func removeAllChildrenAndNotify()
    {
        for child in self.children as [SKNode] {
            child.willMoveFromParent()
            child.willMoveFromScene()
        }

        removeAllChildren()
    }


    public func removeChildrenInArrayAndNotify(childrenToRemove:[SKNode])
    {
        let nodeChildren = children as [SKNode]

        for child in childrenToRemove
        {
            assert(contains(nodeChildren, child))

            if contains(nodeChildren, child) {
                child.willMoveFromParent()
                child.willMoveFromScene()
            }
        }

        removeChildrenInArray(childrenToRemove)
    }
}





