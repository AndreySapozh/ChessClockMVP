//
//  NewTimePresenter.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 26.12.2022.
//

import Foundation

protocol NewTimeViewProtocol: AnyObject {

}

protocol NewTimeViewPresenterProtocol: AnyObject {
    init(view: NewTimeViewProtocol, router: RouterProtocol, newTimeChess: Time)
    func tapSaveButton(newChessTime: Time)
}

final class NewTimePresenter: NewTimeViewPresenterProtocol {
    weak var view: NewTimeViewProtocol?
    var newTimeChess: Time
    var router: RouterProtocol?
    
    init(view: NewTimeViewProtocol, router: RouterProtocol, newTimeChess: Time) {
        self.view = view
        self.newTimeChess = newTimeChess
        self.router = router
    }
    func tapSaveButton(newChessTime: Time) {
//        router?.popToRoot(time: newTimeChess)
    }
   
    
}
