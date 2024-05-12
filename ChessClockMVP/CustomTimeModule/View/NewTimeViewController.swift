//
//  NewTimeController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 26.12.2022.
//

import UIKit

final class NewTimeViewController: UIViewController {
    
    
    var presenter: NewTimeViewPresenterProtocol!
    
    private let defaultConstraint: CGFloat = 40.0
    private let nameTextField = UITextField()
    private let timeLabel = UILabel()
    private let incrementLabel = UILabel()
    private let advancedModeLabelSwitchIsOff = UILabel()
    private let advancedModeLabelSwitchIsOn = UILabel()
    private let timeTextLabel = UILabel()
    private let setTimeLabel = UILabel()
    private let setIncrementLabel = UILabel()
    private let switchAdvancedMode = UISwitch()
    private var playersNameSegmentedControl = UISegmentedControl()
    
    private var stagesTableView = UITableView()
    let identifire = "MyCell"
    private var cellsNameStagesTableView = ["40 moves in 2 hr", "Game in 30 min", "Add Stage"]
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteView
        setupNavigationBar()
        configureNameTextField()
        configureTimeLabel(label: timeLabel)
        configureIncrementLabel(label: incrementLabel)
        setupTimeLabel(label: setTimeLabel)
        setupTimeLabel(label: setIncrementLabel)
        configureAdvancedModeLabel(label: advancedModeLabelSwitchIsOff)
        configureSwitchAdvancedMode()
        configurePlayersNameSegmentedControl()
        configureStagesTableView()
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Custom Time"
        let rightBarButton = UIBarButtonItem(title: "Add",
                                             style: UIBarButtonItem.Style.plain,
                                             target: self,
                                             action: #selector(tapRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func tapRightBarButtonItem() {
        //        add new time in Settings
    }
    
    private func configureStagesTableView() {
        view.addSubview(stagesTableView)
        stagesTableView.isHidden = true
        //        set row height
        stagesTableView.rowHeight = defaultConstraint
        //        register cells
        stagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        //        set delegates and dataSource
        self.stagesTableView.delegate = self
        self.stagesTableView.dataSource = self
        
        stagesTableView.layer.masksToBounds = true
        stagesTableView.layer.cornerRadius = 8
        //        set constraints
        stagesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stagesTableView.heightAnchor.constraint(equalToConstant: defaultConstraint * 3),
            stagesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstraint * 0.5),
            stagesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstraint * 0.5),
            stagesTableView.topAnchor.constraint(equalTo: playersNameSegmentedControl.bottomAnchor, constant: defaultConstraint)
        ])
    }
    private func configureSwitchAdvancedMode() {
        
        switchAdvancedMode.addTarget(self, action: #selector(advancedModeTime(sender: )), for: .valueChanged)
    }
    
    @objc private func advancedModeTime(sender: UISwitch) {
        if sender.isOn {
            hideOrShowElementAdvancedMode(bool: true)
            advancedModeLabelSwitchIsOff.isHidden = true
            configureAdvancedModeLabel(label: advancedModeLabelSwitchIsOn)
        } else {
            hideOrShowElementAdvancedMode(bool: false)
            advancedModeLabelSwitchIsOn.isHidden = true
            configureAdvancedModeLabel(label: advancedModeLabelSwitchIsOff)
            
        }
    }
    
    private func configurePlayersNameSegmentedControl() {
        let playersNameTitles = ["Player One", "Player Two"]
        playersNameSegmentedControl = UISegmentedControl(items: playersNameTitles)
        playersNameSegmentedControl.selectedSegmentIndex = 0
        playersNameSegmentedControl.isHidden = true
        createPlayersNameSegmentedControlConstraint()
    }
    
    private func createPlayersNameSegmentedControlConstraint() {
        
        view.addSubview(playersNameSegmentedControl)
        
        playersNameSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playersNameSegmentedControl.heightAnchor.constraint(equalToConstant: defaultConstraint * 0.66),
            playersNameSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstraint * 0.5),
            playersNameSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstraint * 0.5),
            playersNameSegmentedControl.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: defaultConstraint * 0.5)
        ])
        
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
        label.backgroundColor = UIColor.yellowLabel
        createTimeLabelConstraint(label: label)
    }
    
    private func configureIncrementLabel(label: UILabel) {
        label.text = "Increment"
        label.backgroundColor = UIColor.yellowLabel
        createTimeLabelConstraint(label: label)
        
    }
    
    private func configureAdvancedModeLabel(label: UILabel) {
        label.text = "Advanced Mode"
        label.backgroundColor = UIColor.yellowLabel
        advancedLabelConstraint(advancedLabel: label)
        
    }
    
    private func setTextTimeInLabel(label: UILabel) {
        timeTextLabel.text = "Time"
    }
    
    private func setupTimeLabel(label: UILabel) {
        label.text = "0:00"
        label.textAlignment = .center
        label.backgroundColor = UIColor.greenLabel
        label.font = UIFont.setupTimeLabel
        setTimeAndIncrementLabelConstraint(label: label)
    }
    
    private func hideOrShowElementAdvancedMode(bool: Bool) {
        playersNameSegmentedControl.isHidden = !bool
        timeLabel.isHidden = bool
        timeTextLabel.isHidden = bool
        incrementLabel.isHidden = bool
        timeTextLabel.isHidden = bool
        setTimeLabel.isHidden = bool
        setIncrementLabel.isHidden = bool
        stagesTableView.isHidden = !bool
    }
    
    
    
    private func createNameTextFieldConstraint() {
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: defaultConstraint),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstraint / 2),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstraint / 2),
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstraint * 3)
        ])
    }
    
    private func createTimeLabelConstraint(label: UILabel) {
        
        view.addSubview(label)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: defaultConstraint),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstraint / 2),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstraint / 2)
        ])
        switch label {
        case timeLabel:
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultConstraint * 5).isActive = true
            label.layer.borderWidth = 0.5
        case incrementLabel:
            label.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0).isActive = true
            label.layer.borderWidth = 0.5
            //            case advancedModeLabel:
            //                if switchAdvancedMode.isSelected {
            //                    label.topAnchor.constraint(equalTo: incrementLabel.bottomAnchor, constant: defaultConstaint).isActive = true
            //                } else {
            //                    label.topAnchor.constraint(equalTo: incrementLabel.bottomAnchor, constant: -defaultConstaint * 3 )
            //                }
            //                label.topAnchor.constraint(equalTo: incrementLabel.bottomAnchor, constant: defaultConstaint).isActive = true
            
        default:
            return
        }
        
    }
    
    private func advancedLabelConstraint(advancedLabel: UILabel) {
        view.addSubview(advancedLabel)
        advancedLabel.layer.masksToBounds = true
        advancedLabel.layer.cornerRadius = 8
        createSwitchAdvancedModeConstraint(advancedModeLabel: advancedLabel)
        
        advancedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            advancedLabel.heightAnchor.constraint(equalToConstant: defaultConstraint),
            advancedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstraint / 2),
            advancedLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstraint / 2)
            //                advancedLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: defaultConstaint * 2)
        ])
        switch advancedLabel {
        case advancedModeLabelSwitchIsOff:
            advancedLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: defaultConstraint * 2).isActive = true
        case advancedModeLabelSwitchIsOn:
            advancedLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: defaultConstraint * 4).isActive = true
        default:
            return
        }
    }
    
    //    private func advancedLabelConstraintSwitchIsOn(advancedLabel: UILabel) {
    //        view.addSubview(advancedLabel)
    //        advancedLabel.layer.masksToBounds = true
    //        advancedLabel.layer.cornerRadius = 8
    //        createSwitchAdvancedModeConstraint(advancedModeLabel: advancedModeLabelSwitchIsOn)
    //
    //        advancedLabel.translatesAutoresizingMaskIntoConstraints = false
    //
    //
    //        NSLayoutConstraint.activate([
    //            advancedLabel.heightAnchor.constraint(equalToConstant: defaultConstaint),
    //            advancedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: defaultConstaint / 2),
    //            advancedLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -defaultConstaint / 2),
    //            advancedLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: defaultConstaint * 4)
    //                                    ])
    //    }
    
    private func textColorIndentLeft(textFied: UITextField) {
        nameTextField.backgroundColor = UIColor.yellowLabel
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 8
        view.addSubview(nameTextField)
        
    }
    
    private func setTimeAndIncrementLabelConstraint(label: UILabel) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        switch label {
        case setTimeLabel:
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: defaultConstraint * 1.25),
                label.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: defaultConstraint * 0.125),
                label.rightAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: -defaultConstraint * 0.4),
                label.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: -defaultConstraint * 0.125)
            ])
        case setIncrementLabel:
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: defaultConstraint * 1.25),
                label.rightAnchor.constraint(equalTo: incrementLabel.rightAnchor, constant: -defaultConstraint * 0.4),
                label.topAnchor.constraint(equalTo: incrementLabel.topAnchor, constant: defaultConstraint * 0.125),
                label.bottomAnchor.constraint(equalTo: incrementLabel.bottomAnchor, constant: -defaultConstraint * 0.125)
            ])
        default: return
        }
    }
    
    
    private func createSwitchAdvancedModeConstraint(advancedModeLabel: UILabel) {
        
        view.addSubview(switchAdvancedMode)
        switchAdvancedMode.layer.masksToBounds = true
        switchAdvancedMode.layer.cornerRadius = 8
        
        switchAdvancedMode.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            switchAdvancedMode.widthAnchor.constraint(equalToConstant: defaultConstraint * 1.25),
            switchAdvancedMode.topAnchor.constraint(equalTo: advancedModeLabel.topAnchor, constant: defaultConstraint * 0.125),
            switchAdvancedMode.rightAnchor.constraint(equalTo: advancedModeLabel.rightAnchor, constant: -defaultConstraint * 0.4),
            switchAdvancedMode.bottomAnchor.constraint(equalTo: advancedModeLabel.bottomAnchor, constant: -defaultConstraint * 0.125)
        ])
    }
}

extension NewTimeViewController: NewTimeViewProtocol {
//    func createTimeChess(newTimeChess: NewTime) {
    func createTimeChess(newTimeChess: Time) {
        print(newTimeChess)
    }
}

extension NewTimeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsNameStagesTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire , for: indexPath)
        cell.textLabel?.text = cellsNameStagesTableView[indexPath.row]
        return cell
    }
    
}
