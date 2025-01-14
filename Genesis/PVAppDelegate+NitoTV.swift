//
//  PVAppDelegate+NitoTV.swift
//  GenesisTV
//
//  Created by Joseph Mattiello on 10/5/21.
//  Copyright © 2021 Genesis Emu. All rights reserved.
//

import Foundation
import UIKit
import PVSupport

@objc
extension PVAppDelegate {
    public func importFile(atURL url: URL) {

        let man = FileManager.default
        ILOG("[Genesis] host: \(url.host ?? "nil") path: \(url.path)")
        let cache = uploadDirectory
        do {
            let attrs = try man.attributesOfItem(atPath: cache.path)
            ILOG("[Genesis] cache attrs: \(attrs),  cache path: \(cache)")
            let last = url.lastPathComponent
            let newPath = cache.appendingPathComponent(last)
            let originalPath = url
            try man.copyItem(at: originalPath, to: newPath)
        } catch {
            ELOG("\(error.localizedDescription)")
        }
    }

    var uploadDirectory: URL {
        let man = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let first: URL = URL(string: paths.first!)!
        let cache: URL = first.appendingPathComponent("Imports")
        let path = cache.path
        if !man.fileExists(atPath: path) {
            WLOG("this path wasnt found; \(cache)")
            let folderAttrs: [FileAttributeKey: Any] = [
                .groupOwnerAccountName: "staff",
                .ownerAccountName: "mobile"
            ]
            do {
                try man.createDirectory(at: cache, withIntermediateDirectories: true, attributes: folderAttrs)
            } catch {
                ELOG("\(error.localizedDescription)")
            }
        }
        return cache
    }
}
