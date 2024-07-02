//
//  Time.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.
//

import Foundation
import RealmSwift

class TimeExample: Object {
    @objc dynamic var seconds = ""
    @objc dynamic var name = ""
}

struct Time {
    var seconds: Int
    var increment: Int = 0
    var name: String {
        get {
            makeTime(time: seconds, increment: increment)
        }
    }
    private func secondsToHoursToMinutesToSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    private func secondsToSeconds(seconds: Int) -> (Int) {
        return ((seconds % 3600) % 60)
    }
    private func makeTimeIncrementString(seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%2d", seconds)
        timeString += " sec"
        return timeString
    }
    
    private func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        if hours > 0 {
            timeString += String(format: "%2d", hours)
            timeString += " hr "
            timeString += String(format: "%2d", minutes)
            timeString += " min "
            timeString += String(format: "%2d", seconds)
            timeString += " sec"
            return timeString
        } else if seconds > 0 {
            timeString += String(format: "%2d", minutes)
            timeString += " min "
            timeString += String(format: "%2d", seconds)
            timeString += " sec"
            return timeString
        }
        else {
            timeString += String(format: "%2d", minutes)
            timeString += " min"
            return timeString
        }
    }

    private func makeTime(time: Int, increment: Int) -> String {
        let time = self.secondsToHoursToMinutesToSeconds(seconds: time)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        let timeIncrement = self.secondsToSeconds(seconds: increment)
        let timeStringIncrement = makeTimeIncrementString(seconds: timeIncrement)
        guard increment != 0 else { return timeString }
        return timeString + " | " + timeStringIncrement
    }
}

var presets: [Time] = [
    Time(seconds: 20, increment: 2),
    Time(seconds: 180, increment: 3),
    Time(seconds: 300, increment: 5),
    Time(seconds: 600),
    Time(seconds: 61),
    Time(seconds: 182),
    Time(seconds: 303),
    Time(seconds: 605),
    Time(seconds: 7200)
]
