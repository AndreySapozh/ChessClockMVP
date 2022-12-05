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
    let updateButton = UIButton()
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        
        configureFirstPlayerLabel()
        configureSecondPlayerLabel()
        configureSettingsButton()
        configurePauseButton()
        configureUpdateButton()
      
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
    }
    
    @objc private func didTapSettingsButton() {
        let rootVC = SettingsViewController()
//        rootVC.delegate = self
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
    
    
    private func configureFirstPlayerLabel() {
        
        view.addSubview(firstPlayerLabel)
       
        firstPlayerLabel.backgroundColor = UIColor(red: 100/255, green: 240/255, blue: 240/255, alpha: 1)
        firstPlayerLabel.text = "00:00"
        firstPlayerLabel.textAlignment = .center
        firstPlayerLabel.font = UIFont.systemFont(ofSize: 60)
        firstPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
 
        createFirstPlayerLabelConstraint()
    }

    private func configureSecondPlayerLabel() {
        
        view.addSubview(secondPlayerLabel)
       
        secondPlayerLabel.backgroundColor = UIColor(red: 50/255, green: 240/255, blue: 120/255, alpha: 1)
        secondPlayerLabel.text = "00:00"
        secondPlayerLabel.textAlignment = .center
        secondPlayerLabel.font = UIFont.systemFont(ofSize: 60)
        secondPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
 
        createSecondPlayerLabelConstraint()
    }
    
    private func configureSettingsButton() {
        
        view.addSubview(settingsButton)
        
        settingsButton.backgroundColor = UIColor(red: 10/255, green: 100/255, blue: 200/255, alpha: 1)
        settingsButton.setTitle("Set", for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        createSettingsButtonConstraint()
        
    }
    
    private func configurePauseButton() {
        
        view.addSubview(pauseButton)
        
        pauseButton.backgroundColor = UIColor(red: 10/255, green: 100/255, blue: 200/255, alpha: 1)
        pauseButton.setTitle("Pau", for: .normal)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        createPauseButtonConstraint()
        
    }
    
    private func configureUpdateButton() {
        
        view.addSubview(updateButton)
        
        updateButton.backgroundColor = UIColor(red: 10/255, green: 100/255, blue: 200/255, alpha: 1)
        updateButton.setTitle("Upd", for: .normal)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        createUpdateButtonConstraint()
    }
   
    private func createFirstPlayerLabelConstraint() {
        
        firstPlayerLabel.layer.masksToBounds = true
        firstPlayerLabel.layer.cornerRadius = 10
        
        firstPlayerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        firstPlayerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        firstPlayerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 52).isActive = true
        firstPlayerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/10).isActive = true

    }
    
    private func createSecondPlayerLabelConstraint() {
        
        secondPlayerLabel.layer.masksToBounds = true
        secondPlayerLabel.layer.cornerRadius = 10
        
        secondPlayerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        secondPlayerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        secondPlayerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -52).isActive = true
        secondPlayerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/10).isActive = true
        
    }

    private func createPauseButtonConstraint() {
        pauseButton.layer.cornerRadius = 3
        pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
                
    }
    
    private func createSettingsButtonConstraint() {
        settingsButton.layer.cornerRadius = 3
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func createUpdateButtonConstraint() {
        updateButton.layer.cornerRadius = 3
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80).isActive = true
        updateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
//    func didTapButton(_ button: Any) {
//        self.presenter?.setTime()
//    }
    
}

extension MainViewController: MainViewProtocol {
    func setTime(time: String) {
        self.firstPlayerLabel.text = time
    }
    
    
    
}

