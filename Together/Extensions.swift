//
//  Extensions.swift
//  Together
//
//  Created by Hadir khan on 18/02/2018.
//  Copyright © 2018 Hadir khan. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

