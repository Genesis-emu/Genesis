//
//  PVGameLibraryCollectionFlowLayout.swift
//  Genesis
//
//  Created by Joseph Mattiello on 11/13/18.
//  Copyright © 2018 Genesis Emu. All rights reserved.
//

import Foundation

final class PVGameLibraryCollectionFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        #if os(iOS)
            self.sectionHeadersPinToVisibleBounds = true
        #elseif os(tvOS)
            sectionHeadersPinToVisibleBounds = true
        #endif
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
