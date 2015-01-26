//
//  Helpers.swift
//  GameObjects
//
//  Created by bryn austin bellomy on 2014 Nov 29.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import Funky
import let BrynSwift.τ

public struct Helpers
{
    public enum KeyCode: UInt16
    {
        case Spacebar = 49

        case Number1 = 18
        case Number2 = 19
        case Number3 = 20
        case Number4 = 21
        case Number5 = 22
        case Number6 = 23
        case Number7 = 24
        case Number8 = 25
        case Number9 = 26
        case Number10 = 27

        public init?(keyCode:UInt16) {
            self.init(rawValue:keyCode)
        }
    }


    public static func bundleFilename(filename:String) -> String? {
        let basename = filename.stringByDeletingPathExtension
        let ext = filename.pathExtension
        return bundleFilename(basename, ext)
    }

    public static func bundleFilename(basename:String, _ ext:String) -> String? {
        return NSBundle.mainBundle().pathForResource(basename, ofType:ext)
    }

    public static func normalizeRadians(radians:CGFloat) -> CGFloat {
        return CGFloat(normalizeRadians(Double(radians)))
    }

    public static func normalizeRadians(r:Double) -> Double
    {
        var radians = r
        if radians < 0 {
            radians += τ * (floor(abs(radians / τ)) + 1)
        }

        if fabs(radians) > τ {
            radians = radians % τ
        }

        return radians
    }

    /**
        For some reason, SpriteKit assets import with the positive Y axis facing down.  This function
        offsets the given angle by `1/2 π` (i.e., `1/4 τ`) to get the positive X axis facing right.
    */
    public static func adjustAssetOrientation(r: CGFloat) -> CGFloat {
        return r + CGFloat(0.25 * τ)
    }

    public static func getMainWindowCenterPoint() -> CGPoint? {
        if let window = NSApp.mainWindow? {
            return CGPointMake(window.frame.size.width / 2, window.frame.size.height / 2)
        }
        else { return nil }
    }
}


