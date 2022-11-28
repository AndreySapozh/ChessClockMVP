//
//  ViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 27.11.2022.
//

import UIKit

class ViewController: UIViewController {

    var firstPlayerLabel = UILabel()
    var secondPlayerLabel = UILabel()
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        
        configureFirstPlayerLabel()
        configureSecondPlayerLabel()
    }
    
    func configureFirstPlayerLabel() {
        
        view.addSubview(firstPlayerLabel)
       
        firstPlayerLabel.backgroundColor = UIColor(red: 100/255, green: 240/255, blue: 240/255, alpha: 1)
        firstPlayerLabel.text = "00:00"
        firstPlayerLabel.textAlignment = .center
        firstPlayerLabel.font = UIFont.systemFont(ofSize: 60)
        firstPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
 
        createFirstPlayerLabelConstraint()
    }

    func createFirstPlayerLabelConstraint() {
        NSLayoutConstraint(item: firstPlayerLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leadingMargin,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: firstPlayerLabel,
                           attribute: .trailingMargin,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailingMargin,
                           multiplier: 1,
                           constant: -5).isActive = true
        NSLayoutConstraint(item: firstPlayerLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 88).isActive = true
        NSLayoutConstraint(item: firstPlayerLabel,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 250).isActive = true
    }
    
    func configureSecondPlayerLabel() {
        
        view.addSubview(secondPlayerLabel)
       
        secondPlayerLabel.backgroundColor = UIColor(red: 50/255, green: 240/255, blue: 120/255, alpha: 1)
        secondPlayerLabel.text = "00:00"
        secondPlayerLabel.textAlignment = .center
        secondPlayerLabel.font = UIFont.systemFont(ofSize: 60)
        secondPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
 
        createSecondPlayerLabelConstraint()
    }

    func createSecondPlayerLabelConstraint() {
        NSLayoutConstraint(item: secondPlayerLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leadingMargin,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: secondPlayerLabel,
                           attribute: .trailingMargin,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailingMargin,
                           multiplier: 1,
                           constant: -5).isActive = true
        NSLayoutConstraint(item: secondPlayerLabel,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 808).isActive = true
        NSLayoutConstraint(item: secondPlayerLabel,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 250).isActive = true
    }
    
}

