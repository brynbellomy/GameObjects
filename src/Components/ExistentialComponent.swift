//
//  ExistentialComponent.swift
//  MoarBehaviors
//
//  Created by bryn austin bellomy on 2015 Jan 10.
//  Copyright (c) 2015 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit
import Entish


/** Represents a type that has existential traits, such as a name, a certain number of hit points, and a location in physical space. */
@objc
public protocol IExistent: class
{
    var existentialComponent: ExistentialComponent { get set }
}

/** A component for existential (and semi-existential) traits. */
@objc
public class ExistentialComponent: IComponent
{
    public typealias HPType = Double

    public let systemID: SystemID = 1 << 5
    public var entityID: Entity.EntityID

    public var name: String = "Mishiakuwan"
    public var HP: HPType = 100
    public var position = CGPointZero //? { return node?.position }


//    public weak var node: SKNode?

//    public init(node n:SKNode) {
//        node = n
//    }

    public init(entityID eid:Entity.EntityID) {
        entityID = eid
    }
}






