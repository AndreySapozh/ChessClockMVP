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
    
    func setTime(time: Time)
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
    
func setTime(time: Time) {
        let time = String(self.time.seconds!) + String(self.time.minutes!)
        self.view?.setTime(time: time)
    }
    
    
    
}
