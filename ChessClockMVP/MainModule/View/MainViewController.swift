//
//  ViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 27.11.2022.
//

import UIKit

class MainViewController: UIViewController {
	
    var presenter: MainViewPresenterProtocol!
    
    let firstPlayerLabel = UILabel()
    let secondPlayerLabel = UILabel()
    let settingsButton = UIButton()
    let pauseButton = UIButton()
    let resetButton = UIButton()
    
    let heightWidthButton: CGFloat = 40
    let buttonCenterXConstrait: CGFloat = 80
    private let topBottomConstrait: CGFloat = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        
        configureButton(button: settingsButton)
        configureButton(button: pauseButton)
        configureButton(button: resetButton)
        configurePlayerLabel(playerLabel: firstPlayerLabel)
        configurePlayerLabel(playerLabel: secondPlayerLabel)
      
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
       
        playerLabel.backgroundColor = UIColor(red: 100/255, green: 240/255, blue: 240/255, alpha: 1)
        playerLabel.text = "00:00"
        playerLabel.textAlignment = .center
        playerLabel.font = UIFont.systemFont(ofSize: 80)
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
 
        createFirstPlayerLabelConstraint(playerLabel: playerLabel)
    }
    
    private func configureButton(button: UIButton) {
        
        view.addSubview(button)
        button.backgroundColor = UIColor(red: 10/255, green: 100/255, blue: 200/255, alpha: 1)
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
   
    private func createFirstPlayerLabelConstraint(playerLabel: UILabel) {
        
        playerLabel.layer.masksToBounds = true
        playerLabel.layer.cornerRadius = 10
        playerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        playerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        if playerLabel == firstPlayerLabel {
            playerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topBottomConstrait).isActive = true
        } else {
            playerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -topBottomConstrait).isActive = true
        }
        playerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 4/10).isActive = true
        
    }
    
    func createButtonConstraint(button: UIButton) {
        button.layer.cornerRadius = 3
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: heightWidthButton).isActive = true
        button.heightAnchor.constraint(equalToConstant: heightWidthButton).isActive = true
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
}

extension MainViewController: MainViewProtocol {
    func setTime(time: String) {
        self.firstPlayerLabel.text = time
    }
    
}

