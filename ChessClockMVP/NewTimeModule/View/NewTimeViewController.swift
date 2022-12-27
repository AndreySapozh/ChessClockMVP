//
//  NewTimeController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 26.12.2022.
//

import UIKit

class NewTimeViewController: UIViewController {
    
    var presenter: NewTimeViewPresenterProtocol!
   
    
    override func viewDidLoad() {

        view.backgroundColor = .red
        
    }
}


extension NewTimeViewController: NewTimeViewProtocol {
    func createTimeChess(newTimeChess: NewTime) {
        print(newTimeChess)
    }
}
   
