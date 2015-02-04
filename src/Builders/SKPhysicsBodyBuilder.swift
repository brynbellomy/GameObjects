//
//  SKPhysicsBodyBuilder.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Dec 4.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit

import LlamaKit
import Funky
import SwiftConfig
import SwiftBitmask


/**
    Builds an `SKPhysicsBody` from the values of its properties.  The builder's properties can either be set manually,
    one at a time, or by passing a `SwiftConfig.Config` object to the `configure()` function.  If the builder is asked
    to `build()` before it has enough parameters to build the physics body, it will return an error indicating which
    parameters it is missing.
 */
public struct SKPhysicsBodyBuilder
    <T: IBitmaskRepresentable where T: IConfigRepresentable, T.BitmaskRawType == UInt32> : IConfigurableBuilder
{
    public var shape: SKPhysicsBodyShape?
    public var radius: CGFloat?
    public var center: CGPoint?
    public var size: CGSize?
    public var path: CGPath?

    public var categoryBitMask    : Bitmask<T>?
    public var collisionBitMask   : Bitmask<T>?
    public var contactTestBitMask : Bitmask<T>?
    public var allowsRotation     : Bool?
    public var dynamic            : Bool?


    /** The designated initializer. */
    public init() {
    }


    /**
        Attempts to build the `SKPhysicsBody` with whatever properties have been supplied to the builder.

        :returns: a `LlamaKit.Result` containing either the `SKPhysicsBody` or an error.
    */
    public func build() -> Result<SKPhysicsBody>
    {
        return initializeBody().flatMap { success(self.applyPropertiesToBody($0)) }
    }


    /**
        Initializes the builder's properties using values in the provided `SwiftConfig.Config`.  The valid property keys
        that the config object is searched for are all `String`s:

        - `categories`: populates the `categoryBitmask` property (`Bitmask<T>`)
        - `collides with`: populates the `categoryBitMask` property (`Bitmask<T>`)
        - `contact test`: populates the `collisionBitMask` property (`Bitmask<T>`)
        - `allows rotation`: populates the `allowsRotation` property (`Bool`)
        - `dynamic`: populates the `dynamic` property (`Bool`)
        - `shape`: populates the `shape` property (`SKPhysicsBodyShape`)
        - `radius`: populates the `radius` property (`CGFloat`)
        - `center x`: populates the `center` property's `x` value (`CGFloat`)
        - `center y`: populates the `center` property's `y` value (`CGFloat`)
        - `width`: populates the `size` property's `width` value (`CGFloat`)
        - `height`: populates the `size` property's `height` value (`CGFloat`)
     */
    public mutating func configure(config:Config)
    {
        categoryBitMask     =?? config.get("categories")
        collisionBitMask    =?? config.get("collides with")
        contactTestBitMask  =?? config.get("contact test")
        allowsRotation      =?? config.get("allows rotation")
        dynamic             =?? config.get("is dynamic")

        shape  =?? config.get("shape")
        radius =?? config.get("radius")
        center =?? config.pluck("center x", "center y")
        size   =?? config.pluck("width", "height")

        // @@TODO: should we somehow include the `path` stuff here too (i.e., make a way for it to be somehow knowably Config-urable separate from the TMX string parsing)?
    }


    private func initializeBody() -> Result<SKPhysicsBody>
    {
        if shape == nil {
            return missingValueFailure("shape")
        }

        switch shape! {
            case let .Circle:       return createCircle(center ?? CGPointZero)    <^> radius ?± missingValueFailure("radius")
            case let .Rectangle:    return createRectangle(center ?? CGPointZero) <^> size   ?± missingValueFailure("size")
            case let .Polygon:      return createPolygon                          <^> path   ?± missingValueFailure("path")
            case let .EdgeLoop:     return createEdgeLoop                         <^> path   ?± missingValueFailure("path")
            case let .EdgeChain:    return createEdgeChain                        <^> path   ?± missingValueFailure("path")
        }
    }

    private func applyPropertiesToBody(body: SKPhysicsBody) -> SKPhysicsBody
    {
        body.categoryBitMask    =?? categoryBitMask?.bitmaskValue
        body.collisionBitMask   =?? collisionBitMask?.bitmaskValue
        body.contactTestBitMask =?? contactTestBitMask?.bitmaskValue
        body.allowsRotation     =?? allowsRotation
        body.dynamic            =?? dynamic
        return body
    }
}

private func missingValueFailure <T> (key: String) -> Result<T> {
    return failure("SKPhysicsBodyBuilder: Missing value for key '\(key)'")
}

/**
    These functions exist to provide curried versions of the various SKPhysicsBody constructors.
 */
private func createCircle(center:CGPoint)(radius:CGFloat) -> SKPhysicsBody {
    return SKPhysicsBody(circleOfRadius: radius, center: center)
}

private func createRectangle(center:CGPoint)(size:CGSize) -> SKPhysicsBody {
    return SKPhysicsBody(rectangleOfSize: size, center: center)
}

private func createPolygon(path:CGPath) -> SKPhysicsBody {
    return SKPhysicsBody(polygonFromPath: path)
}

private func createEdgeLoop(path:CGPath) -> SKPhysicsBody {
    return SKPhysicsBody(edgeLoopFromPath: path)
}

private func createEdgeChain(path:CGPath) -> SKPhysicsBody {
    return SKPhysicsBody(edgeChainFromPath: path)
}









