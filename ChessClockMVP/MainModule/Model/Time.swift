//
//  Time.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.
//

import Foundation

struct Time {
    var seconds: Int
    var name: String {
        get {
            return String(seconds) + " seconds"
        }
    }
}


var presets: [Time] = [Time(seconds: 60) , Time(seconds: 180), Time(seconds: 300), Time(seconds: 600)]
