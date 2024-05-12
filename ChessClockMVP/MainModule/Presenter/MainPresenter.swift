//
//  MainPresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.

import Foundation

protocol MainViewProtocol: AnyObject {
    func setTime(time: String)
    func setMoveNumber(moveNumber: Int)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol)
    
    func showMoveNumber()
    func tapSettingsButton()
    func getTime()
    func showTime()
}

final class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?

    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    func getTime() {
        
    }
    func tapSettingsButton() {
        router?.showSettings()
    }
    
    func showTime() {
        guard let timeInInt = presets.first?.seconds else { return }
        let timeInString = makeTime(time: timeInInt)
//        let timeInString = makeTime(time: 3661)
        self.view?.setTime(time: timeInString)
        
    }
    
    func showMoveNumber() {
        let moveNumber = 0
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
