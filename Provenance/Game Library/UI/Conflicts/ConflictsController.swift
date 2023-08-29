//
//  ConflictsController.swift
//  Genesis
//
//  Created by Joseph Mattiello on 1/29/22.
//  Copyright © 2022 Genesis Emu. All rights reserved.
//

import Foundation
import PVLibrary
import RxSwift
import RxCocoa

public protocol ConflictsController {
    typealias Conflict = (path: URL, candidates: [System])
    var conflicts: Observable<[Conflict]> { get }
    func resolveConflicts(withSolutions: [URL: System])
    func deleteConflict(path: URL)
}
