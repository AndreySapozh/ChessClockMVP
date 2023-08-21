//
//  MainPresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.

import Foundation

protocol MainViewProtocol: AnyObject {
    func setTime(time: String)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, time: Time, router: RouterProtocol)
    
    func showTime()
    func tapSettingsButton()
}

final class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let time: Time
    var router: RouterProtocol?
    
    
    
    required init(view: MainViewProtocol, time: Time, router: RouterProtocol) {
        self.view = view
        self.time = time
        self.router = router
    }
    func tapSettingsButton() {
        router?.showSettings()
    }
    
func showTime() {
//        let time = String(self.time.seconds!) + String(self.time.minutes!)
        let time = self.time.seconds!
        let timeInFormat = makeTime(time: time)
        self.view?.setTime(time: timeInFormat)
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
