//
//  MainPresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.

import Foundation

protocol MainViewProtocol: AnyObject {
    func setTimeTopPlayer(timeTopPlayer: String)
    func setTimeBottomPlayer(timeBottomPlayer: String)
    func setRedColorWhenTheEndTimeTopPlayer()
    func setRedColorWhenTheEndTimeBottomPlayer()
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
    func tapBottomPlayerLabel()
    func tapTopPlayerLabel()
    func stopTimerTopPlayer()
    func stopTimerBottomPlayer()
    func updateToStartTime()
    func theEndTimeTopPlayer()
    func theEndTimeBottomPlayer()
    
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
        self.timeChessTopPlayer = presets.first?.seconds ?? 1
        self.timeChessBottomPlayer = presets.first?.seconds ?? 10
        self.timerTopPlayer = timerTopPlayer
        self.timerBottomPlayer = timerBottomPlayer
    }
    
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
        stopTimerTopPlayer()
        stopTimerBottomPlayer()
    }
    
    func tapResetButton() {
        stopTimerTopPlayer()
        stopTimerBottomPlayer()
        getTimeTopPlayer()
        getTimeBottomPlayer()
        updateToStartTime()
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
    
    @objc func timerCounterTopPlayer() -> Void {
        timeChessTopPlayer -= 1
        let timeTopPlayer = secondsToHoursToMinutesToSeconds(seconds: timeChessTopPlayer)
        let timeStringTopPlayer = makeTimeString(hours: timeTopPlayer.0, minutes: timeTopPlayer.1, seconds: timeTopPlayer.2)
        view?.setTimeTopPlayer(timeTopPlayer: timeStringTopPlayer)
        theEndTimeTopPlayer()
    }
    @objc func timerCounterBottomPlayer() -> Void {
        timeChessBottomPlayer -= 1
        let timeBottomPlayer = secondsToHoursToMinutesToSeconds(seconds: timeChessBottomPlayer)
        let timeStringBottomPlayer = makeTimeString(hours: timeBottomPlayer.0, minutes: timeBottomPlayer.1, seconds: timeBottomPlayer.2)
        view?.setTimeBottomPlayer(timeBottomPlayer: timeStringBottomPlayer)
        theEndTimeBottomPlayer()
    }
    
    
    func tapTopPlayerLabel() {
        timerBottomPlayer = Timer.scheduledTimer(timeInterval: 1,
                                                 target: self,
                                                 selector: #selector(timerCounterBottomPlayer),
                                                 userInfo: nil,
                                                 repeats: true)
        stopTimerTopPlayer()
        
    }
    func tapBottomPlayerLabel() {
        timerTopPlayer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(timerCounterTopPlayer),
                                              userInfo: nil,
                                              repeats: true)
        stopTimerBottomPlayer()
    }
    
    func theEndTimeTopPlayer() {
        if timeChessTopPlayer < 1 {
            stopTimerTopPlayer()
            self.view?.setRedColorWhenTheEndTimeTopPlayer()
        }
    }
    func theEndTimeBottomPlayer() {
        if timeChessBottomPlayer < 1 {
            stopTimerBottomPlayer()
            self.view?.setRedColorWhenTheEndTimeBottomPlayer()
        }
    }
    
    func stopTimerTopPlayer() {
        timerTopPlayer.invalidate()
    }
    
    func stopTimerBottomPlayer() {
        timerBottomPlayer.invalidate()
    }
    func updateToStartTime() {
        timeChessTopPlayer = presets.first?.seconds ?? 1
        timeChessBottomPlayer = presets.first?.seconds ?? 10
    }
}

