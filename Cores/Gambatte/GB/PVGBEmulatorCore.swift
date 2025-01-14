//
//  PVGBEmulatorCore.swift
//  PVGB
//
//  Created by Joseph Mattiello on 6/6/18.
//  Copyright © 2018 Genesis. All rights reserved.
//

import Foundation
import PVSupport

extension PVGBEmulatorCore: CoreActions {
    public var coreActions: [CoreAction]? {
        if !isGameboyColor {
            return [CoreAction(title: "Change Palette", options: nil)]
        } else {
            return nil
        }
    }

    public func selected(action: CoreAction) {
        switch action.title {
        case "Change Palette":
            let nextI = currentDisplayMode() + 1
            let next = GBPalette(rawValue: nextI) ?? .peaSoupGreen
            changeDisplayMode(next.rawValue)
        default:
            print("Unknown action: " + action.title)
        }
    }
}
