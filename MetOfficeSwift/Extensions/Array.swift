//
//  Array.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

extension Array where Element: FloatingPoint {
    var total: Element {
        return reduce(0, +)
    }

    var average: Element {
        return isEmpty ? 0 : total / Element(count)
    }
}
