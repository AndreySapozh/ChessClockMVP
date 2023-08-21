//
//  ViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 27.11.2022.
//

import UIKit

class MainViewController: UIViewController {
	
    var presenter: MainViewPresenterProtocol!
    
    private let firstPlayerLabel = UILabel()
    private let secondPlayerLabel = UILabel()
    private let settingsButton = UIButton()
    private let pauseButton = UIButton()
    private let resetButton = UIButton()
    private let movesCounterFirstPlayer = UILabel()
    private let movesCounterSecondPlayer = UILabel()

    var moveNumberFirstPlayer: Int = 0
    var moveNumberSecondPlayer: Int = 0
    private let heightWidthButton: CGFloat = 40
    private let buttonCenterXConstrait: CGFloat = 80
    private let topBottomConstrait: CGFloat = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteView
        
        configureButton(button: settingsButton)
        configureButton(button: pauseButton)
        configureButton(button: resetButton)
        configurePlayerLabel(playerLabel: firstPlayerLabel)
        configurePlayerLabel(playerLabel: secondPlayerLabel)
        configureMovesCounter(moveLabel: movesCounterFirstPlayer, playerLabel: firstPlayerLabel, moveNumber: moveNumberFirstPlayer)
        configureMovesCounter(moveLabel: movesCounterSecondPlayer, playerLabel: secondPlayerLabel, moveNumber: moveNumberSecondPlayer)
      
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        
    }
    
    
    
    @objc private func didTapSettingsButton() {
        presenter.tapSettingsButton()
    }
    
    @objc private func didTapResetButton() {
        let alert = UIAlertController(title: nil, message: "Reset the clock?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            // do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
//            update chess time
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
   
    private func configurePlayerLabel(playerLabel: UILabel) {
        
        view.addSubview(playerLabel)

        self.presenter.showTime()
        
        playerLabel.backgroundColor = UIColor.paleGreenLabel
        playerLabel.textAlignment = .center
        playerLabel.font = UIFont.mainTimePlayers
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
 
        createPlayerLabelConstraint(playerLabel: playerLabel)
    }
    
    private func configureMovesCounter(moveLabel: UILabel, playerLabel: UILabel, moveNumber: Int) {
        moveLabel.backgroundColor = UIColor.paleGreenLabel
        moveLabel.text = " Moves: \(moveNumber)"
        moveLabel.font = UIFont.counterMoves

        movesCounterConstraint(moveLabel: moveLabel, playerLabel: playerLabel)

    }
    
    private func configureButton(button: UIButton) {
        
        view.addSubview(button)
        button.backgroundColor = UIColor.blueButton
        button.translatesAutoresizingMaskIntoConstraints = false
        
        switch button {
        case settingsButton:
            button.setTitle("Set", for: .normal)
        case pauseButton:
            pauseButton.setTitle("Pau", for: .normal)
        case resetButton:
            resetButton.setTitle("Res", for: .normal)
        default:
            return
        }

        createButtonConstraint(button: button)
    }
   
    private func createPlayerLabelConstraint(playerLabel: UILabel) {
        
        playerLabel.layer.masksToBounds = true
        playerLabel.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            playerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            playerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            playerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
                                        ])
        if playerLabel == firstPlayerLabel {
            playerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topBottomConstrait).isActive = true
            playerLabel.transform = CGAffineTransformMakeRotation(3.14)
        } else {
            playerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: topBottomConstrait).isActive = true
        }
    }
    
    private func createButtonConstraint(button: UIButton) {
        button.layer.cornerRadius = 3
        NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
                button.widthAnchor.constraint(equalToConstant: heightWidthButton),
                button.heightAnchor.constraint(equalToConstant: heightWidthButton)
                                    ])
        switch button {
        case settingsButton:
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -buttonCenterXConstrait).isActive = true
        case pauseButton:
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        case resetButton:
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: buttonCenterXConstrait).isActive = true
        default:
            return
        }
    }
    
    private func movesCounterConstraint(moveLabel: UILabel, playerLabel: UILabel) {
       
        
        playerLabel.addSubview(moveLabel)
        moveLabel.layer.masksToBounds = true
        moveLabel.layer.cornerRadius = 8
        
        moveLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                moveLabel.heightAnchor.constraint(equalToConstant: heightWidthButton * 0.75),
                moveLabel.widthAnchor.constraint(equalToConstant: heightWidthButton * 2)
                                    ])
        
        switch playerLabel {
        case firstPlayerLabel:
            NSLayoutConstraint.activate([
                    moveLabel.topAnchor.constraint(equalTo: playerLabel.topAnchor, constant: heightWidthButton * 0.5),
                    moveLabel.rightAnchor.constraint(equalTo: playerLabel.rightAnchor, constant: -heightWidthButton * 0.5)
                                        ])
        case secondPlayerLabel:
            NSLayoutConstraint.activate([
                    moveLabel.topAnchor.constraint(equalTo: playerLabel.topAnchor, constant: heightWidthButton * 0.5),
                    moveLabel.rightAnchor.constraint(equalTo: playerLabel.rightAnchor, constant: -heightWidthButton * 0.5)
                                        ])
        default:
            return
        }

    }
    
}

extension MainViewController: MainViewProtocol {
    func setTime(time: String) {
        self.firstPlayerLabel.text = time
        self.secondPlayerLabel.text = time
        
    }
    
}

