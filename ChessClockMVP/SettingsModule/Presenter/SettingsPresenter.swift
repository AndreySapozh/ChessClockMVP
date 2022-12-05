//
//  Presenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import Foundation
	
protocol SettingsViewProtocol: AnyObject {
    func setTime(time: Time?)
}

protocol SettingsViewPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol, router: RouterProtocol, time: Time?)
    func setTime()
    func tap()
}

class SettingsPresenter: SettingsViewPresenterProtocol {
    weak var view: SettingsViewProtocol?
//    var networkService: NetworkService!
    var router: RouterProtocol?
    var time: Time?
    
    required init(view: SettingsViewProtocol, router: RouterProtocol, time: Time?) {
        self.view = view
//        self.networkService = networkService
        self.time = time
        self.router = router
    }
    
    func setTime() {
        self.view?.setTime(time: time)
    }
    func tap() {
        router?.popToRoot()
    }
    
    
}


