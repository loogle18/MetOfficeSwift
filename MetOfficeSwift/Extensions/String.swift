//
//  String.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import Foundation

extension String {
    var trimed: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func trimed(from symbol: String) -> String {
        return components(separatedBy: symbol).joined()
    }
    
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = NSString(string: self)
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range) }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
