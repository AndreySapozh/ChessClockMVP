//
//  NewTimeController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 26.12.2022.
//

import UIKit

class NewTimeViewController: UIViewController {
    
    var presenter: NewTimeViewPresenterProtocol!
    
    let defaultConstaint: CGFloat = 40
    let nameTextField = UITextField()
    let timeLabel = UILabel()
    let incrementLabel = UILabel()
    let advancedMode = UILabel()
    let setTimeLabel = UILabel()
    let setIncrementLabel = UILabel()
    let switchAdvancedMode = UISwitch()
    
    override func viewDidLoad() {
        
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
        label.text = "   Time"
        label.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 0/255, alpha: 1.0)
        createTimeLabelConstraint(label: label)
    }
    
    private func configureIncrementLabel(label: UILabel) {
        label.text = "   Increment"
        label.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 0/255, alpha: 1.0)
        createTimeLabelConstraint(label: label)
        
    }
    
    private func configureAdvancedModeLabel(label: UILabel) {
        label.text = "   Advanced Mode"
        label.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 0/255, alpha: 1.0)
        createTimeLabelConstraint(label: label)
        
    }
    
    private func setupTimeLabel(label: UILabel) {
        label.text = " 0:00"
        label.backgroundColor = UIColor(red: 120/255, green: 249/255, blue: 0/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 20)
        timeLabelConstraint(label: label)
    }
    
    private func createNameTextFieldConstraint() {
        
        nameTextField.heightAnchor.constraint(equalToConstant: defaultConstaint).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstaint / 2).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstaint / 2).isActive = true
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 3).isActive = true

        }
    
    private func createTimeLabelConstraint(label: UILabel) {
        
        view.addSubview(label)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: defaultConstaint).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstaint / 2).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstaint / 2).isActive = true
        switch label {
        case timeLabel:
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 5).isActive = true
            label.layer.borderWidth = 0.5
        case incrementLabel:
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 6).isActive = true
            label.layer.borderWidth = 0.5
        case advancedMode:
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 8).isActive = true
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
    
    private func timeLabelConstraint(label: UILabel) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        label.heightAnchor.constraint(equalToConstant: defaultConstaint * 0.75).isActive = true
        label.widthAnchor.constraint(equalToConstant: defaultConstaint * 1.25).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstaint * 0.8).isActive = true
        
        switch label {
        case setTimeLabel:
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 5.125).isActive = true
        case setIncrementLabel:
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 6.125).isActive = true
        default: return
        }
    }
    
    private func createSwitchAdvancedModeConstraint() {
        
        view.addSubview(switchAdvancedMode)
        switchAdvancedMode.layer.masksToBounds = true
        switchAdvancedMode.layer.cornerRadius = 8
        
        switchAdvancedMode.translatesAutoresizingMaskIntoConstraints = false
        switchAdvancedMode.heightAnchor.constraint(equalToConstant: defaultConstaint * 0.75).isActive = true
        switchAdvancedMode.widthAnchor.constraint(equalToConstant: defaultConstaint * 1.25).isActive = true
        switchAdvancedMode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstaint * 0.8).isActive = true
        switchAdvancedMode.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstaint * 8.125).isActive = true
       
    }
}

extension NewTimeViewController: NewTimeViewProtocol {
    func createTimeChess(newTimeChess: NewTime) {
        print(newTimeChess)
    }
}
   
