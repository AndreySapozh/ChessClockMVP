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
    private let moveCounterTopPlayer = UILabel()
    private let moveCounterBottomPlayer = UILabel()
    private let heightWidthButton: CGFloat = 40
    private let buttonCenterXConstrait: CGFloat = 80
    private let topBottomConstrait: CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteView
        
        setupNavigationController()
        configureButton(button: settingsButton)
        configureButton(button: pauseButton)
        configureButton(button: resetButton)
        
        configureTopPlayerLabel()
        configureBottomPlayerLabel()
        
        configureMoveCounter(moveLabel: moveCounterTopPlayer, playerLabel: topPlayerLabel)
        configureMoveCounter(moveLabel: moveCounterBottomPlayer, playerLabel: bottomPlayerLabel)
        
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .black
        let backItem = UIBarButtonItem()
        backItem.title = "Clock"
        navigationItem.backBarButtonItem = backItem
    }
    private func configureButton(button: UIButton) {
        view.addSubview(button)
        button.backgroundColor = .blueButton
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
    
    private func configureTopPlayerLabel() {
        presenter.getTimeTopPlayer()
        view.addSubview(topPlayerLabel)
        topPlayerLabel.backgroundColor = .lightGrayLabel
        topPlayerLabel.textAlignment = .center
        topPlayerLabel.font = .mainTimePlayersFont
        topPlayerLabel.isUserInteractionEnabled = true
        topPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionTopPlayerLabel)))
        createTopPlayerConstraint()
    }
    private func configureBottomPlayerLabel() {
        presenter.getTimeBottomPlayer()
        view.addSubview(bottomPlayerLabel)
        bottomPlayerLabel.backgroundColor = .lightGrayLabel
        bottomPlayerLabel.textAlignment = .center
        bottomPlayerLabel.font = .mainTimePlayersFont
        bottomPlayerLabel.isUserInteractionEnabled = true
        bottomPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionBottomPlayerLabel)))
        createBottomPlayerConstraint()
    }
    
    private func configureMoveCounter(moveLabel: UILabel, playerLabel: UILabel) {
        presenter.showMoveNumberTopPlayer()
        presenter.showMoveNumberBottomPlayer()
        moveLabel.backgroundColor = .trasparentMoveLabel
        moveLabel.font = .counterMovesFont
        movesCounterConstraint(moveLabel: moveLabel, playerLabel: playerLabel)
    }
    
    @objc private func didTapSettingsButton() {
        presenter.tapPauseButton()
        presenter.tapSettingsButton()
    }
    
    @objc private func didTapPauseButton() {
        presenter.tapPauseButton()
        topPlayerLabel.backgroundColor = UIColor.lightGrayLabel
        bottomPlayerLabel.backgroundColor = UIColor.lightGrayLabel
    }
    
    @objc private func didTapResetButton() {
        presenter.stopTimerTopPlayer()
        presenter.stopTimerBottomPlayer()
        let alert = UIAlertController(title: nil, message: "Reset the clock?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            // do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            //            update chess time
            self.presenter.tapResetButton()
            self.topPlayerLabel.backgroundColor = .lightGrayLabel
            self.bottomPlayerLabel.backgroundColor = .lightGrayLabel
            self.playersLabelIsUserInteractionEnabledTrue()
        }))
        self.present(alert, animated: true, completion: nil)
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
    
    private func createTopPlayerConstraint() {
        topPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
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
        bottomPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomPlayerLabel.layer.masksToBounds = true
        bottomPlayerLabel.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            bottomPlayerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            bottomPlayerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            bottomPlayerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            bottomPlayerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: topBottomConstrait)
        ])
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
            presenter.tapTopPlayerLabel()
            topPlayerLabel.isUserInteractionEnabled.toggle()
            topPlayerLabel.backgroundColor = .lightGrayLabel
            bottomPlayerLabel.backgroundColor = .paleGreenLabel
        } else {
            presenter.tapTopPlayerLabel()
            topPlayerLabel.isUserInteractionEnabled.toggle()
            topPlayerLabel.backgroundColor = .lightGrayLabel
            bottomPlayerLabel.backgroundColor = .paleGreenLabel
            bottomPlayerLabel.isUserInteractionEnabled.toggle()
        }
    }
    @objc func tapActionBottomPlayerLabel() {
        if topPlayerLabel.isUserInteractionEnabled == bottomPlayerLabel.isUserInteractionEnabled {
            presenter.tapBottomPlayerLabel()
            bottomPlayerLabel.isUserInteractionEnabled.toggle()
            bottomPlayerLabel.backgroundColor = .lightGrayLabel
            topPlayerLabel.backgroundColor = .paleGreenLabel
        } else {
            presenter.tapBottomPlayerLabel()
            bottomPlayerLabel.isUserInteractionEnabled.toggle()
            bottomPlayerLabel.backgroundColor = .lightGrayLabel
            topPlayerLabel.backgroundColor = .paleGreenLabel
            topPlayerLabel.isUserInteractionEnabled.toggle()
        }
    }
    private func playersLabelIsUserInteractionEnabledTrue() {
        topPlayerLabel.isUserInteractionEnabled = true
        topPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionTopPlayerLabel)))
        bottomPlayerLabel.isUserInteractionEnabled = true
        bottomPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionBottomPlayerLabel)))
    }
}

extension MainViewController: MainViewProtocol {
    func setTimeTopPlayer(timeTopPlayer: String) {
        topPlayerLabel.text = timeTopPlayer
    }
    func setTimeBottomPlayer(timeBottomPlayer: String) {
        bottomPlayerLabel.text = timeBottomPlayer
    }
    
    func setMoveNumberTopPlayer(moveNumber: Int) {
        moveCounterTopPlayer.text = ("Moves: \(moveNumber)")
    }
    func setMoveNumberBottomPlayer(moveNumber: Int) {
        self.moveCounterBottomPlayer.text = ("Moves: \(moveNumber)")
    }
    func setRedColorWhenTheEndTimeTopPlayer() {
        topPlayerLabel.backgroundColor = .redColorTheEndTime
        topPlayerLabel.isUserInteractionEnabled = true
        topPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResetButton)))
        bottomPlayerLabel.isUserInteractionEnabled = true
        bottomPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResetButton)))
    }
    func setRedColorWhenTheEndTimeBottomPlayer() {
        bottomPlayerLabel.backgroundColor = .redColorTheEndTime
        topPlayerLabel.isUserInteractionEnabled = true
        topPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResetButton)))
        bottomPlayerLabel.isUserInteractionEnabled = true
        bottomPlayerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResetButton)))
    }
}

