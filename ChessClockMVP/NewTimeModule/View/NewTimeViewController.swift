//
//  NewTimeController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 26.12.2022.
//

import UIKit

final class NewTimeViewController: UIViewController {
    
    var presenter: NewTimeViewPresenterProtocol!
    
    private let defaultConstaint: CGFloat = 40
    private let nameTextField = UITextField()
    private let timeLabel = UILabel()
    private let incrementLabel = UILabel()
    private let advancedMode = UILabel()
    private let setTimeLabel = UILabel()
    private let setIncrementLabel = UILabel()
    private let switchAdvancedMode = UISwitch()
    
    override func viewDidLoad() {
        
        navigationItem.title = "Custom Time"
        view.backgroundColor = .white
        configureNameTextField()
        configureTimeLabel(label: timeLabel)
        configureIncrementLabel(label: incrementLabel)
        configureAdvancedModeLabel(label: advancedMode)
        setupTimeLabel(label: setTimeLabel)
        setupTimeLabel(label: setIncrementLabel)
        createSwitchAdvancedModeConstraint()
    }
    
    private func configureNameTextField() {
        
        nameTextField.placeholder = "Name"
        textColorIndentLeft(textFied: nameTextField)
        createNameTextFieldConstraint()
    }
    
    private func configureTimeLabel(label: UILabel) {
        label.text = "Time"
//        create text indent left
//        label.textAlignment = .
        label.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 0/255, alpha: 1.0)
        createTimeLabelConstraint(label: label)
    }
    
    private func configureIncrementLabel(label: UILabel) {
        label.text = "Increment"
        label.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 0/255, alpha: 1.0)
        createTimeLabelConstraint(label: label)
        
    }
    
    private func configureAdvancedModeLabel(label: UILabel) {
        label.text = "Advanced Mode"
        label.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 0/255, alpha: 1.0)
        createTimeLabelConstraint(label: label)
        
    }
    
    private func setupTimeLabel(label: UILabel) {
        label.text = "0:00"
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 120/255, green: 249/255, blue: 0/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 20)
        setTimeLabelConstraint(label: label)
    }
    
    private func createNameTextFieldConstraint() {
                
        NSLayoutConstraint.activate([
                nameTextField.heightAnchor.constraint(equalToConstant: defaultConstaint),
                nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstaint / 2),
                nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstaint / 2),
                nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 3)
                                    ])
        }
        
    private func createTimeLabelConstraint(label: UILabel) {
        
        view.addSubview(label)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: defaultConstaint),
                label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstaint / 2),
                label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstaint / 2)
                                    ])
            switch label {
            case timeLabel:
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 5).isActive = true
                label.layer.borderWidth = 0.5
            case incrementLabel:
                label.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0).isActive = true
                label.layer.borderWidth = 0.5
            case advancedMode:
                label.topAnchor.constraint(equalTo: incrementLabel.bottomAnchor, constant: defaultConstaint).isActive = true
            default:
                return
            }

    }
    
    private func textColorIndentLeft(textFied: UITextField) {
        nameTextField.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 0/255, alpha: 1.0)
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 8
        view.addSubview(nameTextField)

    }
    
    private func setTimeLabelConstraint(label: UILabel) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        switch label {
        case setTimeLabel:
            NSLayoutConstraint.activate([
                    label.widthAnchor.constraint(equalToConstant: defaultConstaint * 1.25),
                    label.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: defaultConstaint * 0.125),
                    label.rightAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: -defaultConstaint * 0.4),
                    label.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: -defaultConstaint * 0.125)
                                        ])
        case setIncrementLabel:
            NSLayoutConstraint.activate([
                    label.widthAnchor.constraint(equalToConstant: defaultConstaint * 1.25),
                    label.rightAnchor.constraint(equalTo: incrementLabel.rightAnchor, constant: -defaultConstaint * 0.4),
                    label.topAnchor.constraint(equalTo: incrementLabel.topAnchor, constant: defaultConstaint * 0.125),
                    label.bottomAnchor.constraint(equalTo: incrementLabel.bottomAnchor, constant: -defaultConstaint * 0.125)
                                        ])
        default: return
        }
    }
    
    private func createSwitchAdvancedModeConstraint() {
        
        view.addSubview(switchAdvancedMode)
        switchAdvancedMode.layer.masksToBounds = true
        switchAdvancedMode.layer.cornerRadius = 8
        
        switchAdvancedMode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                switchAdvancedMode.widthAnchor.constraint(equalToConstant: defaultConstaint * 1.25),
                switchAdvancedMode.topAnchor.constraint(equalTo: advancedMode.topAnchor, constant: defaultConstaint * 0.125),
                switchAdvancedMode.rightAnchor.constraint(equalTo: advancedMode.rightAnchor, constant: -defaultConstaint * 0.4),
                switchAdvancedMode.bottomAnchor.constraint(equalTo: advancedMode.bottomAnchor, constant: -defaultConstaint * 0.125)
                                    ])
    }
}

extension NewTimeViewController: NewTimeViewProtocol {
    func createTimeChess(newTimeChess: NewTime) {
        print(newTimeChess)
    }
}
   
