//
//  SKPhysicsBodyShape.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Dec 6.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import protocol SwiftConfig.IConfigRepresentable


public enum SKPhysicsBodyShape : String, IConfigRepresentable
{
    case Circle    = "Circle"
    case Rectangle = "Rectangle"
    case Polygon   = "Polygon"
    case EdgeLoop  = "EdgeLoop"
    case EdgeChain = "EdgeChain"

    public static func fromConfigValue(configValue:String) -> SKPhysicsBodyShape? {
        return SKPhysicsBodyShape(rawValue:configValue)
    }
}






