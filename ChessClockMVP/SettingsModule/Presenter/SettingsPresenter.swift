//
//  Presenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import Foundation
	
protocol SettingsViewProtocol: AnyObject {
    func setTimeChess(timeChess: Time)
}

protocol SettingsViewPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: Time, time: [Time])
    func getTime()
    var time: [Time] { get set}
    func setTime()
    func tapStartButton(time: Time)
    func tapCreateNewTime()
}

final class SettingsPresenter: SettingsViewPresenterProtocol {
    weak var view: SettingsViewProtocol?
    var router: RouterProtocol?
    var timeChess: Time
    var time: [Time]
    
    required init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: Time, time: [Time]) {
        self.view = view
        self.timeChess = timeChess
        self.router = router
        self.time = time
    }
    
    public func setTime() {
        self.view?.setTimeChess(timeChess: timeChess)
    }
    func tapStartButton(time: Time) {
        router?.backToMainView(timeChess: time)
    }
    func getTime() {
        time = presets
    }
    func tapCreateNewTime() {
        router?.showCreateNewTime(timeChess: timeChess)
    }

}


