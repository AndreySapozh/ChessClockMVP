//
//  MainPresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 30.11.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func setTime(time: String)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, time: Time)
    
    func setTime()
}

class MainPresenter: MainViewPresenterProtocol {
    
    let view: MainViewProtocol
    let time: Time
    
    required init(view: MainViewProtocol, time: Time) {
        self.view = view
        self.time = time
    }
    
    func setTime() {
        let time = String(self.time.seconds) + String(self.time.minutes)
        self.view.setTime(time: time)
    }
    
    
    
}
