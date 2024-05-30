//
//  ViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 27.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    private let topPlayerLabel = UILabel()
    private let bottomPlayerLabel = UILabel()
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
        
        setupNavigationController()
        configureButton(button: settingsButton)
        configureButton(button: pauseButton)
        configureButton(button: resetButton)
        
//        configurePlayerLabel(playerLabel: topPlayerLabel)
//        configurePlayerLabel(playerLabel: bottomPlayerLabel)
        configureTopPlayerLabel()
        configureBottomPlayerLabel()
        
//        configureMovesCounter(moveLabel: movesCounterFirstPlayer, playerLabel: topPlayerLabel)
//        configureMovesCounter(moveLabel: movesCounterSecondPlayer, playerLabel: bottomPlayerLabel)
        
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapSettingsButton() {
        presenter.tapSettingsButton()
    }
    
    @objc private func didTapPauseButton() {
        presenter.tapPauseButton()
    }
    
    @objc private func didTapResetButton() {
//        presenter.tapRestoreButton()
        let alert = UIAlertController(title: nil, message: "Reset the clock?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            // do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            //            update chess time
            self.presenter.tapResetButton()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .black
        let backItem = UIBarButtonItem()
        backItem.title = "Clock"
        navigationItem.backBarButtonItem = backItem
    }
    
//    private func configurePlayerLabel(playerLabel: UILabel) {
//        
//        view.addSubview(playerLabel)
//        presenter.getTime()
////        self.presenter.showTime()
//        playerLabel.isUserInteractionEnabled = true
//        playerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionPlayerLabel)))
//        
//        playerLabel.backgroundColor = UIColor.paleGreenLabel
//        playerLabel.textAlignment = .center
//        playerLabel.font = UIFont.mainTimePlayers
//        playerLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        createPlayerLabelConstraint(playerLabel: playerLabel)
//    }
    
    private func configureTopPlayerLabel() {
        view.addSubview(topPlayerLabel)
        presenter.getTimeTopPlayer()
        topPlayerLabel.isUserInteractionEnabled = true
        topPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionTopPlayerLabel)))
        
        topPlayerLabel.backgroundColor = UIColor.lightGrayLabel
        topPlayerLabel.textAlignment = .center
        topPlayerLabel.font = UIFont.mainTimePlayers
        topPlayerLabel.translatesAutoresizingMaskIntoConstraints = false

        createTopPlayerConstraint()
    }
    
    private func configureBottomPlayerLabel() {
        view.addSubview(bottomPlayerLabel)
        presenter.getTimeBottomPlayer()
        bottomPlayerLabel.isUserInteractionEnabled = true
        bottomPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionBottomPlayerLabel)))
        bottomPlayerLabel.backgroundColor = UIColor.lightGrayLabel
        bottomPlayerLabel.textAlignment = .center
        bottomPlayerLabel.font = UIFont.mainTimePlayers
        bottomPlayerLabel.translatesAutoresizingMaskIntoConstraints = false

        createBottomPlayerConstraint()
    }
    
    
    private func configureMovesCounter(moveLabel: UILabel, playerLabel: UILabel) {
        self.presenter.showMoveNumber()
        
        moveLabel.backgroundColor = UIColor.paleGreenLabel
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
    
//    private func createPlayerLabelConstraint(playerLabel: UILabel) {
//        
//        playerLabel.layer.masksToBounds = true
//        playerLabel.layer.cornerRadius = 10
//        NSLayoutConstraint.activate([
//            playerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
//            playerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
//            playerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
//        ])
//        if playerLabel == topPlayerLabel {
//            playerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topBottomConstrait).isActive = true
//            playerLabel.transform = CGAffineTransformMakeRotation(3.14)
//        } else {
//            playerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: topBottomConstrait).isActive = true
//        }
//    }
    private func createTopPlayerConstraint() {
        topPlayerLabel.layer.masksToBounds = true
        topPlayerLabel.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            topPlayerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            topPlayerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            topPlayerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            topPlayerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topBottomConstrait)
        ])
        topPlayerLabel.transform = CGAffineTransformMakeRotation(3.14)
    }
    
    private func createBottomPlayerConstraint() {
        bottomPlayerLabel.layer.masksToBounds = true
        bottomPlayerLabel.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            bottomPlayerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            bottomPlayerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            bottomPlayerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            bottomPlayerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: topBottomConstrait)
        ])
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
        case topPlayerLabel:
            NSLayoutConstraint.activate([
                moveLabel.topAnchor.constraint(equalTo: playerLabel.topAnchor, constant: heightWidthButton * 0.5),
                moveLabel.rightAnchor.constraint(equalTo: playerLabel.rightAnchor, constant: -heightWidthButton * 0.5)
            ])
        case bottomPlayerLabel:
            NSLayoutConstraint.activate([
                moveLabel.topAnchor.constraint(equalTo: playerLabel.topAnchor, constant: heightWidthButton * 0.5),
                moveLabel.rightAnchor.constraint(equalTo: playerLabel.rightAnchor, constant: -heightWidthButton * 0.5)
            ])
        default:
            return
        }
        
    }
    
    @objc func tapActionTopPlayerLabel() {
        if topPlayerLabel.isUserInteractionEnabled == bottomPlayerLabel.isUserInteractionEnabled {
            presenter.startTimerTopPlayer()
            topPlayerLabel.isUserInteractionEnabled.toggle()
            topPlayerLabel.backgroundColor = UIColor.lightGrayLabel
            bottomPlayerLabel.backgroundColor = UIColor.paleGreenLabel
        }
        else   {
            presenter.startTimerTopPlayer()
            topPlayerLabel.isUserInteractionEnabled.toggle()
            topPlayerLabel.backgroundColor = UIColor.lightGrayLabel
            bottomPlayerLabel.backgroundColor = UIColor.paleGreenLabel
            bottomPlayerLabel.isUserInteractionEnabled.toggle()
        }
    }
    @objc func tapActionBottomPlayerLabel() {
        if topPlayerLabel.isUserInteractionEnabled == bottomPlayerLabel.isUserInteractionEnabled {
            presenter.startTimerBottomPlayer()
            bottomPlayerLabel.isUserInteractionEnabled.toggle()
            bottomPlayerLabel.backgroundColor = UIColor.lightGrayLabel
            topPlayerLabel.backgroundColor = UIColor.paleGreenLabel
        } else {
            presenter.startTimerBottomPlayer()
            bottomPlayerLabel.isUserInteractionEnabled.toggle()
            bottomPlayerLabel.backgroundColor = UIColor.lightGrayLabel
            topPlayerLabel.backgroundColor = UIColor.paleGreenLabel
            topPlayerLabel.isUserInteractionEnabled.toggle()
        }
    }
}

extension MainViewController: MainViewProtocol {
    func setTimeTopPlayer(timeTopPlayer: String) {
        topPlayerLabel.text = timeTopPlayer
    }
    func setTimeBottomPlayer(timeBottomPlayer: String) {
        bottomPlayerLabel.text = timeBottomPlayer
    }
    
    func setMoveNumber(moveNumber: Int) {
        self.movesCounterFirstPlayer.text = ("Moves: \(moveNumber)")
        self.movesCounterSecondPlayer.text = ("Moves: \(moveNumber)")
    }
    
}

