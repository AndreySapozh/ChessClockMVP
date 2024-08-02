//
//  Presenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import Foundation
	
protocol SettingsViewProtocol: AnyObject {
    func setTimeChess(timeChess: TimeRealm)
}

protocol SettingsViewPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: TimeRealm, time: [TimeRealm])
    func getTime()
    var time: [TimeRealm] { get set}
    func setTime()
    func tapStartButton(time: TimeRealm)
    func tapCreateNewTime()
}

final class SettingsPresenter: SettingsViewPresenterProtocol {
    weak var view: SettingsViewProtocol?
    var router: RouterProtocol?
    var timeChess: TimeRealm
    var time: [TimeRealm]
    
    required init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: TimeRealm, time: [TimeRealm]) {
        self.view = view
        self.timeChess = timeChess
        self.router = router
        self.time = time
    }
    
    public func setTime() {
        self.view?.setTimeChess(timeChess: timeChess)
    }
    func tapStartButton(time: TimeRealm) {
        router?.backToMainView(timeChess: time)
    }
    func getTime() {
        time = presetsRealm
    }
    func tapCreateNewTime() {
        router?.showCreateNewTime(timeChess: timeChess)
    }

}


