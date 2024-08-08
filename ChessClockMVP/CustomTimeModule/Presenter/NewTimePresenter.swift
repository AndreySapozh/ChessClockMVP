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
    init(view: NewTimeViewProtocol, router: RouterProtocol, newTimeChess: TimeRealm)
    func tapSaveButton(newChessTime: TimeRealm)
}

final class NewTimePresenter: NewTimeViewPresenterProtocol {
    weak var view: NewTimeViewProtocol?
    var newTimeChess: TimeRealm
    var router: RouterProtocol?
    
    init(view: NewTimeViewProtocol, router: RouterProtocol, newTimeChess: TimeRealm) {
        self.view = view
        self.newTimeChess = newTimeChess
        self.router = router
    }
    func tapSaveButton(newChessTime: TimeRealm) {
//        router?.popToRoot(time: newTimeChess)
    }
   
    
}
