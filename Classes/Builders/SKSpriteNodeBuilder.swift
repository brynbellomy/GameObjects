//
//  SKSpriteNodeBuilder.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Dec 4.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import SpriteKit
import SwiftConfig
import LlamaKit
import Funky


private func missingValueError(key: String) -> ErrorIO {
    let description = "SKSpriteNodeBuilder: Missing value for key '\(key)'"
    return ErrorIO() <~ NSError(domain: "com.illumntr.GameObjects", code: -1, userInfo: [ NSLocalizedDescriptionKey: description ])
}


public class SKSpriteNodeBuilder: IConfigurableBuilder
{
    var textureAtlasName:   String?
    var defaultTextureName: String?
    var anchorPoint:        CGPoint? = CGPoint(x:0.5, y:0.0)
    var size:               CGSize?
    var xScale:             CGFloat? = 1
    var yScale:             CGFloat? = 1

    public required init() {
    }

    public func configure(config:Config)
    {
        textureAtlasName   =?? config.get("texture atlas")
        defaultTextureName =?? config.get("texture name")
        anchorPoint        =?? config.get("anchor point")
//        size               =?? config.pluck("width", "height")
        xScale             =?? config.get("x scale")
        yScale             =?? config.get("y scale")
    }


    public func build() -> Result<SKSpriteNode>
    {
        return (buildSpriteNode <^> (buildTexture <^> textureAtlasName   ?± failure(missingValueError("texture atlas"))
                                                  <*> defaultTextureName ?± failure(missingValueError("texture name"))))
                    >>- { spriteNode in

                            spriteNode.anchorPoint  =?? self.anchorPoint
                            spriteNode.size         =?? self.size
                            spriteNode.xScale       =?? self.xScale
                            spriteNode.yScale       =?? self.yScale

                            return success(spriteNode)
                        }
    }
}


private func buildTexture(atlasName:String)(textureName:String) -> SKTexture {
    return SKTextureAtlas(named:atlasName).textureNamed(textureName)
}


private func buildSpriteNode(texture:SKTexture) -> SKSpriteNode {
    return SKSpriteNode(texture:texture, color:nil, size:texture.size())
}



