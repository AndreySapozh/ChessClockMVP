//
//  SettingsModel.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 04.12.2022.
//

import Foundation

struct TimeChess {
    var timeChess: String
}

var defaultTime: [TimeChess] = [TimeChess(timeChess: "Bullet"),
                                TimeChess(timeChess: "Fischer Blitz 5|0"),
                                TimeChess(timeChess: "Fischer 5|5"),
                                TimeChess(timeChess: "Tournament 40/2hr, 1hr")]
