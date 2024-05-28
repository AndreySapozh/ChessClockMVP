//
//  MainPresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.

import Foundation

protocol MainViewProtocol: AnyObject {
    func setTimeTopPlayer(timeTopPlayer: String)
    func setTimeBottomPlayer(timeBottomPlayer: String)
    func setMoveNumber(moveNumber: Int)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, timerTopPlayer: Timer, timerBottomPlayer: Timer)
    
    func showMoveNumber()
    func tapSettingsButton()
    func getTimeTopPlayer()
    func getTimeBottomPlayer()
    func tapPauseButton()
    func tapResetButton()
//    func startTimer()
    func startTimerTopPlayer()
    func startTimerBottomPlayer()
    
}

final class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    var timeChessTopPlayer: Int
    var timeChessBottomPlayer: Int
    var timerTopPlayer: Timer
    var timerBottomPlayer: Timer

    required init(view: MainViewProtocol, router: RouterProtocol, timerTopPlayer: Timer, timerBottomPlayer: Timer) {
        self.view = view
        self.router = router
//        getTime()
        self.timeChessTopPlayer = presets.first?.seconds ?? 1
        self.timeChessBottomPlayer = presets.first?.seconds ?? 10
        self.timerTopPlayer = timerTopPlayer
        self.timerBottomPlayer = timerBottomPlayer
        
    }
//    func getTime() {
//
//    }
    func tapSettingsButton() {
        router?.showSettings()
    }
    
    func getTimeTopPlayer() {
        guard let timeInInt = presets.first?.seconds else { return }
        let timeInString = makeTime(time: timeInInt)
        self.view?.setTimeTopPlayer(timeTopPlayer: timeInString)
    }
    
    func getTimeBottomPlayer() {
        guard let timeInInt = presets.first?.seconds else { return }
        let timeInString = makeTime(time: timeInInt)
        self.view?.setTimeBottomPlayer(timeBottomPlayer: timeInString)
    }
    
    
    func showMoveNumber() {
        let moveNumber = 0
        self.view?.setMoveNumber(moveNumber: moveNumber)
    }
    
    func tapPauseButton() {
        // tapped pause button logic
        timerTopPlayer.invalidate()
        timerBottomPlayer.invalidate()
    }
    
    func tapResetButton() {
//        tapped restore button logic
    }
    
    func secondsToHoursToMinutesToSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        if hours > 0 {
            timeString += String(format: "%2d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        } else {
            timeString += String(format: "%2d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
    }
    
    func makeTime(time: Int) -> String {
        let time = self.secondsToHoursToMinutesToSeconds(seconds: time)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        return timeString
    }
    
//    @objc func timerCounter() -> Void {
//        timeChess -= 1
//        let time = secondsToHoursToMinutesToSeconds(seconds: timeChess)
//        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
//        self.view?.setTime(time: timeString)
//    }
    
    @objc func timerCounterTopPlayer() -> Void {
        timeChessTopPlayer -= 1
        let timeTopPlayer = secondsToHoursToMinutesToSeconds(seconds: timeChessTopPlayer)
        let timeStringTopPlayer = makeTimeString(hours: timeTopPlayer.0, minutes: timeTopPlayer.1, seconds: timeTopPlayer.2)
        view?.setTimeTopPlayer(timeTopPlayer: timeStringTopPlayer)
//        view?.setTime(time: timeStringTopPlayer)
    }
    @objc func timerCounterBottomPlayer() -> Void {
        timeChessBottomPlayer -= 1
        let time = secondsToHoursToMinutesToSeconds(seconds: timeChessBottomPlayer)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        view?.setTimeBottomPlayer(timeBottomPlayer: timeString)
//        view?.setTime(time: timeString)
    }
    
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
//    }
    func startTimerTopPlayer() {
//        timerBottomPlayer.invalidate()
        timerBottomPlayer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(timerCounterBottomPlayer),
                                              userInfo: nil,
                                              repeats: true)
        timerTopPlayer.invalidate()

    }
    func startTimerBottomPlayer() {
        timerTopPlayer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(timerCounterTopPlayer),
                                              userInfo: nil,
                                              repeats: true)
        timerBottomPlayer.invalidate()
    }
}
