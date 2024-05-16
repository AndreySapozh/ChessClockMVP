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
    init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: Time)
    func setTime()
    func tapStartButton()
    func tapCreateNewTime()
}

final class SettingsPresenter: SettingsViewPresenterProtocol {
    
    weak var view: SettingsViewProtocol?
    var router: RouterProtocol?
    var timeChess: Time
    
    required init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: Time) {
        self.view = view
        self.timeChess = timeChess
        self.router = router
    }
    
    public func setTime() {
        self.view?.setTimeChess(timeChess: timeChess)
    }
    func tapStartButton() {
        router?.popToRoot(time: Time(seconds: 60))
        

    }
    
    func tapCreateNewTime() {
        router?.showCreateNewTime()
    }

}


