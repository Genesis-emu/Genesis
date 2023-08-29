//
//  OptionDependency.swift
//  PVSupport
//
//  Created by Joseph Mattiello on 1/22/22.
//  Copyright © 2022 Genesis Emu. All rights reserved.
//

import Foundation

public struct OptionDependency<OptionType: COption> {
    let option: OptionType
    let mustBe: OptionType.Type?
    let mustNotBe: OptionType.Type?
}
