//
//  ExistentialComponent.swift
//  MoarBehaviors
//
//  Created by bryn austin bellomy on 2015 Jan 10.
//  Copyright (c) 2015 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit
import NodeBehaviors


/** A Component for existential (and semi-existential) traits. */

public struct ExistentialComponent
{
    public typealias HPType = Double

    public var name: String = "Mishiakuwan"
    public var HP: HPType = 0
    public var position: CGPoint? { return node?.position }


    public weak var node: SKNode?

    public init() {
    }

    public init(node n:SKNode) {
        node = n
    }
}
