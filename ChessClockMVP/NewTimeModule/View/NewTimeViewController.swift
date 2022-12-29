//
//  NewTimeController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 26.12.2022.
//

import UIKit

class NewTimeViewController: UIViewController {
    
    var presenter: NewTimeViewPresenterProtocol!
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        datePicker.center = view.center
        datePicker.datePickerMode = .countDownTimer
        self.view.addSubview(datePicker)
    }
}


extension NewTimeViewController: NewTimeViewProtocol {
    func createTimeChess(newTimeChess: NewTime) {
        print(newTimeChess)
    }
}
   
