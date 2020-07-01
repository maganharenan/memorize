//
//  Array+Only.swift
//  Memorize
//
//  Created by Renan Maganha on 30/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
