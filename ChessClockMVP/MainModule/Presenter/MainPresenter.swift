//
//  MainPresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.

import Foundation

protocol MainViewProtocol: AnyObject {
    func setTimeTopPlayer(timeTopPlayer: String)
    func setTimeBottomPlayer(timeBottomPlayer: String)
    func setMoveNumberTopPlayer(moveNumber: Int)
    func setMoveNumberBottomPlayer(moveNumber: Int)
    func setRedColorWhenTheEndTimeTopPlayer()
    func setRedColorWhenTheEndTimeBottomPlayer()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, timerTopPlayer: Timer, timerBottomPlayer: Timer)
    
    func showMoveNumberTopPlayer()
    func showMoveNumberBottomPlayer()
    func getTimeTopPlayer()
    func getTimeBottomPlayer()
    func tapSettingsButton()
    func tapPauseButton()
    func tapResetButton()
    func tapBottomPlayerLabel()
    func tapTopPlayerLabel()
    func stopTimerTopPlayer()
    func stopTimerBottomPlayer()
    func updateToStartTimeAndMove()
    func theEndTimeTopPlayer()
    func theEndTimeBottomPlayer()
    func moveCounterBottomPlayer()
    func moveCounterTopPlayer()
    
}

final class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    var timeChessTopPlayer: Float
    var timeChessBottomPlayer: Float
    var timerTopPlayer: Timer
    var timerBottomPlayer: Timer
    var moveTopPlayer: Int
    var moveBottomPlayer: Int
    
    required init(view: MainViewProtocol, router: RouterProtocol, timerTopPlayer: Timer, timerBottomPlayer: Timer) {
        self.view = view
        self.router = router
        self.timerTopPlayer = timerTopPlayer
        self.timerBottomPlayer = timerBottomPlayer
        self.moveTopPlayer = 0
        self.moveBottomPlayer = 0
//        TODO: make the right logic
        self.timeChessTopPlayer = Float(presets.first?.seconds ?? 1)
        self.timeChessBottomPlayer = Float(presets.first?.seconds ?? 10)

    }
// MARK: - tap buttons
    func tapSettingsButton() {
        router?.showSettings()
    }
//     TODO: complete the logic start
    func tapPauseButton() {
        stopTimerTopPlayer()
        stopTimerBottomPlayer()
    }
    
    func tapResetButton() {
        updateToStartTimeAndMove()
        getTimeTopPlayer()
        getTimeBottomPlayer()
        showMoveNumberTopPlayer()
        showMoveNumberBottomPlayer()
    }
//  MARK: - get and show time
    func getTimeTopPlayer() {
//       TODO: make the right logic
        guard let timeInInt = presets.first?.seconds else { return }
        let timeInString = makeTime(time: timeInInt)
        self.view?.setTimeTopPlayer(timeTopPlayer: timeInString)
    }
    
    func getTimeBottomPlayer() {
//       TODO: make the right logic
        guard let timeInInt = presets.first?.seconds else { return }
        let timeInString = makeTime(time: timeInInt)
        self.view?.setTimeBottomPlayer(timeBottomPlayer: timeInString)
    }
    
    func showMoveNumberTopPlayer() {
        self.view?.setMoveNumberTopPlayer(moveNumber: moveTopPlayer)
    }
    
    func showMoveNumberBottomPlayer() {
        self.view?.setMoveNumberBottomPlayer(moveNumber: moveBottomPlayer)
    }
// MARK: - helpers methods
    func secondsToHoursToMinutesToSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        if hours > 0 {
            timeString += String(format: "%d", hours)
            timeString += ":"
            timeString += String(format: "%02d", minutes)
            timeString += ":"
            timeString += String(format: "%02d", seconds)
            return timeString
        } else {
            timeString += String(format: "%d", minutes)
            timeString += ":"
            timeString += String(format: "%02d", seconds)
            return timeString
        }
    }
    
    func makeTime(time: Int) -> String {
        let time = self.secondsToHoursToMinutesToSeconds(seconds: time)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        return timeString
    }
//  MARK: - timer counter func
    @objc func timerCounterTopPlayer() -> Void {
        timeChessTopPlayer -= 0.01
        let timeTopPlayer = secondsToHoursToMinutesToSeconds(seconds: Int(timeChessTopPlayer))
        let timeStringTopPlayer = makeTimeString(hours: timeTopPlayer.0, minutes: timeTopPlayer.1, seconds: timeTopPlayer.2)
        view?.setTimeTopPlayer(timeTopPlayer: timeStringTopPlayer)
        theEndTimeTopPlayer()
    }
    @objc func timerCounterBottomPlayer() -> Void {
        timeChessBottomPlayer -= 0.01
        let timeBottomPlayer = secondsToHoursToMinutesToSeconds(seconds: Int(timeChessBottomPlayer))
        let timeStringBottomPlayer = makeTimeString(hours: timeBottomPlayer.0, minutes: timeBottomPlayer.1, seconds: timeBottomPlayer.2)
        view?.setTimeBottomPlayer(timeBottomPlayer: timeStringBottomPlayer)
        theEndTimeBottomPlayer()
    }
    
// MARK: - player Timer
    func tapTopPlayerLabel() {
        timerBottomPlayer = Timer.scheduledTimer(timeInterval: 0.01,
                                                 target: self,
                                                 selector: #selector(timerCounterBottomPlayer),
                                                 userInfo: nil,
                                                 repeats: true)
        stopTimerTopPlayer()
        moveCounterTopPlayer()
    }
    func tapBottomPlayerLabel() {
        timerTopPlayer = Timer.scheduledTimer(timeInterval: 0.01,
                                              target: self,
                                              selector: #selector(timerCounterTopPlayer),
                                              userInfo: nil,
                                              repeats: true)
        stopTimerBottomPlayer()
        moveCounterBottomPlayer()
    }
// MARK: - The end time player
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
//  MARK: - stop and update timer
    func stopTimerTopPlayer() {
        timerTopPlayer.invalidate()
    }
    
    func stopTimerBottomPlayer() {
        timerBottomPlayer.invalidate()
    }
    func updateToStartTimeAndMove() {
        timeChessTopPlayer = Float(presets.first?.seconds ?? 1)
        timeChessBottomPlayer = Float(presets.first?.seconds ?? 10)
        moveTopPlayer = 0
        moveBottomPlayer = 0
    }
//    Mark: - moves counter
    func moveCounterBottomPlayer() {
        moveBottomPlayer += 1
        showMoveNumberBottomPlayer()
    }
    func moveCounterTopPlayer() {
        moveTopPlayer += 1
        showMoveNumberTopPlayer()
    }
    
}

