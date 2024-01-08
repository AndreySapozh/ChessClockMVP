//
//  Presenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import Foundation
	
protocol SettingsViewProtocol: AnyObject {
    func setTimeChess(timeChess: TimeChess)
}

protocol SettingsViewPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: TimeChess)
    func setTime()
    func tapStartButton()
    func tapCreateNewTime()
}

final class SettingsPresenter: SettingsViewPresenterProtocol {
    
    weak var view: SettingsViewProtocol?
//    var networkService: NetworkService!
    var router: RouterProtocol?
    var timeChess: TimeChess
    
    required init(view: SettingsViewProtocol, router: RouterProtocol, timeChess: TimeChess) {
        self.view = view
//        self.networkService = networkService
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


