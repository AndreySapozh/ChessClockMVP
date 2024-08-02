//
//  Time.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.
//

import Foundation
import RealmSwift

class TimeRealm: Object {
    @Persisted var seconds = 0
    @Persisted var increment = 0
    @objc dynamic var name: String {
//    @objc dynamic var seconds = 0
//    @objc dynamic var increment = 0
//    @objc dynamic var name: String {
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

let oneMinute = TimeRealm(value: [60])
let oneMinuteOneSecond = TimeRealm(value: [60, 1])
let threeMinutes = TimeRealm(value: [180])
let threeMinutesTwoSeconds = TimeRealm(value: [180, 2])
let fiveMinutes = TimeRealm(value: [300])
let fiveMinutesThreeSeconds = TimeRealm(value: [300, 3])
let fiveMinutesFiveSeconds = TimeRealm(value: [300, 5])
let tenMinutes = TimeRealm(value: [600])
let tenMinutesFiveSeconds = TimeRealm(value: [600, 5])

let defaultTimeControls: [TimeRealm] = [
    oneMinute,
    oneMinuteOneSecond,
    threeMinutes,
    threeMinutesTwoSeconds,
    fiveMinutes,
    fiveMinutesThreeSeconds,
    fiveMinutesFiveSeconds,
    tenMinutes,
    tenMinutesFiveSeconds
]

var presetsRealm: [TimeRealm] = defaultTimeControls


//[
//    oneMinute,
//    threeMinutesTwoSeconds,
//    fiveMinutesThreeSeconds
//]


//var presetsRealm: [TimeRealm] = [
//    TimeRealm(value: [60, 3]),
//    TimeRealm(value: [180, 3]),
//    TimeRealm(value: [300, 5]),
//    TimeRealm(value: [600]),
//    TimeRealm(value: [61]),
//    TimeRealm(value: [182]),
//    TimeRealm(value: [303]),
//    TimeRealm(value: [605]),
//    TimeRealm(value: [7200])
//]

//StorageManager.shared.save(chessTime: presetsRealm)
//struct TimeRealm {
//    var seconds: Int
//    var increment: Int = 0
//    var name: String {
//        get {
//            makeTime(time: seconds, increment: increment)
//        }
//    }
//    private func secondsToHoursToMinutesToSeconds(seconds: Int) -> (Int, Int, Int) {
//        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
//    }
//    private func secondsToSeconds(seconds: Int) -> (Int) {
//        return ((seconds % 3600) % 60)
//    }
//    private func makeTimeIncrementString(seconds: Int) -> String {
//        var timeString = ""
//        timeString += String(format: "%2d", seconds)
//        timeString += " sec"
//        return timeString
//    }
//    
//    private func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
//        var timeString = ""
//        if hours > 0 {
//            timeString += String(format: "%2d", hours)
//            timeString += " hr "
//            timeString += String(format: "%2d", minutes)
//            timeString += " min "
//            timeString += String(format: "%2d", seconds)
//            timeString += " sec"
//            return timeString
//        } else if seconds > 0 {
//            timeString += String(format: "%2d", minutes)
//            timeString += " min "
//            timeString += String(format: "%2d", seconds)
//            timeString += " sec"
//            return timeString
//        }
//        else {
//            timeString += String(format: "%2d", minutes)
//            timeString += " min"
//            return timeString
//        }
//    }
//
//    private func makeTime(time: Int, increment: Int) -> String {
//        let time = self.secondsToHoursToMinutesToSeconds(seconds: time)
//        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
//        let timeIncrement = self.secondsToSeconds(seconds: increment)
//        let timeStringIncrement = makeTimeIncrementString(seconds: timeIncrement)
//        guard increment != 0 else { return timeString }
//        return timeString + " | " + timeStringIncrement
//    }
//}
//
//var presets: [TimeRealm] = [
//    TimeRealm(seconds: 20, increment: 2),
//    TimeRealm(seconds: 180, increment: 3),
//    TimeRealm(seconds: 300, increment: 5),
//    TimeRealm(seconds: 600),
//    TimeRealm(seconds: 61),
//    TimeRealm(seconds: 182),
//    TimeRealm(seconds: 303),
//    TimeRealm(seconds: 605),
//    TimeRealm(seconds: 7200)
//]
