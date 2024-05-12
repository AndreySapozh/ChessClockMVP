//
//  NewTimePresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 26.12.2022.
//

import Foundation

protocol NewTimeViewProtocol: AnyObject {
    func createTimeChess(newTimeChess: Time)

}

protocol NewTimeViewPresenterProtocol: AnyObject {
    init(view: NewTimeViewProtocol, newTimeChess: Time, router: RouterProtocol)
    func createTime()
    func tapSaveButton()
}

final class NewTimePresenter: NewTimeViewPresenterProtocol {
    
    weak var view: NewTimeViewProtocol?
    var newTimeChess: Time
    
    var router: RouterProtocol?
    
    required init(view: NewTimeViewProtocol, newTimeChess: Time, router: RouterProtocol) {
        self.view = view
        self.newTimeChess = newTimeChess
        self.router = router
    }
    
    public func createTime() {
        self.view?.createTimeChess(newTimeChess: newTimeChess)
    }
    
    func tapSaveButton() {
        router?.popToRoot(time: Time(seconds: 60))
    }
   
    
}
