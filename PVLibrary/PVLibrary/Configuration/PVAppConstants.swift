//
//  PVAppConstants.swift
//  Genesis
//
//  Created by David Muzi on 2015-12-16.
//  Copyright © 2015 James Addyman. All rights reserved.
//

import Foundation

public let PVMaxRecentsShortcutCount: Int = 4
public let PVAppGroupId = Bundle.main.infoDictionary?["APP_GROUP_IDENTIFIER"] as? String ?? "group.org.Genesis-emu.Genesis"
public let kInterfaceDidChangeNotification = "kInterfaceDidChangeNotification"
public let PVGameControllerKey = "PlayController"
public let PVGameMD5Key = "md5"
public let PVAppURLKey = "Genesis"
public let UbiquityIdentityTokenKey = (Bundle.main.bundleIdentifier ?? "org.Genesis-emu.Genesis")  + ".UbiquityIdentityToken"

#if os(tvOS)
    public let PVThumbnailMaxResolution: Float = 800.0
#else
    public let PVThumbnailMaxResolution: Float = 200.0
#endif
