//
//  String+AddText.swift
//  MyLocations
//
//  Created by Mohammed Hamdi on 11/19/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import Foundation

extension String {
    mutating func add(text: String?, separatedBy separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}
