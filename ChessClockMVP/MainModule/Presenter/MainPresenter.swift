//
//  MainPresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.

import Foundation

//var timerCounting: Bool = false
//var timer: Timer = Timer()

protocol MainViewProtocol: AnyObject {
    func setTime(time: String)
    func setMoveNumber(moveNumber: Int)
}

protocol MainViewPresenterProtocol: AnyObject {
//    init(view: MainViewProtocol, time: Time, router: RouterProtocol, timer: Timer)
    init(view: MainViewProtocol, time: Time, router: RouterProtocol)
    
    func showTime()
    func showMoveNumber()
    func tapSettingsButton()
    func getTime()
    
//    var timeArray: [Time] { get set }
//    func startPlayerTimer()
}

final class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var time: Time
    var router: RouterProtocol?
//  var timer: Timer
//    var timeArray: [Time]
    
    func getTime() {
        
    }
    
    
//    required init(view: MainViewProtocol, time: Time, router: RouterProtocol, timer: Timer) {
    required init(view: MainViewProtocol, time: Time, router: RouterProtocol) {
        self.view = view
        self.time = time
        self.router = router
        //        self.timer = timer
    }
    func tapSettingsButton() {
        router?.showSettings()
    }
    
    func showTime() {
        let time = self.time.seconds
        let timeInString = makeTime(time: time)
        self.view?.setTime(time: timeInString)
}
    
    func showMoveNumber() {
        let moveNumber = self.time.moveNumber
        self.view?.setMoveNumber(moveNumber: moveNumber)
    }
    
    func secondsToHoursToMinutesToSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func makeTime(time: Int) -> String {
        let time = self.secondsToHoursToMinutesToSeconds(seconds: time)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        return timeString
    }
    
}
