//
//  SettingsViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    var presenter: SettingsViewPresenterProtocol!
    private let customTimeButton = UIButton()
    private let startButton = UIButton()
    private var tableView = UITableView()
    
    private let heightCell: CGFloat = 50
        
    struct Cells {
        static let textCell = "textCell"
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteView
        setupNavigationBar()
        configureCustomTimeButton()
        configureStartButton()
        configureTableView()
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        customTimeButton.addTarget(self, action: #selector(didTapCustomTimeButton), for: .touchUpInside)
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Time Controls"
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
        moveDeleteRowsRightBarButton()
    }
    
    private func moveDeleteRowsRightBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Done",
                                             style: UIBarButtonItem.Style.plain,
                                             target: self,
                                             action: #selector(moveDeleteRows))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func moveDeleteRows() {
        // to correct on move and delete rows
//        presenter.tapStartButton()
//        presenter.tapStartButton(time: presets.first!)
    }
    
    @objc private func didTapStartButton() {
        guard let indexPath = tableView.indexPathForSelectedRow?.row else { return }
        presenter.tapStartButton(time: presenter.time[indexPath])
    }
    
    @objc private func didTapCustomTimeButton() {
        presenter.tapCreateNewTime()
    }
    
    private func configureCustomTimeButton() {
        view.addSubview(customTimeButton)
        customTimeButton.backgroundColor = UIColor.white
        customTimeButton.setTitle("Add custom time", for: .normal)
        customTimeButton.setTitleColor(.black, for: .normal)
        customTimeButton.translatesAutoresizingMaskIntoConstraints = false
        createCustomTimeButtonConstraint()
    }
    
    private func createCustomTimeButtonConstraint() {
        customTimeButton.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            customTimeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: heightCell),
            customTimeButton.heightAnchor.constraint(equalToConstant: heightCell),
            customTimeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            customTimeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        //        set delegates
        setTableViewDelegates()
        //        set row height
        tableView.rowHeight = heightCell
        //        register cells
        tableView.register(TimeTableViewCell.self, forCellReuseIdentifier: Cells.textCell)
        tableView.layer.cornerRadius = 8
        //        set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:customTimeButton.bottomAnchor, constant: heightCell),
            tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: (CGFloat(presets.count) * heightCell))
        ])
    }
    
    private func configureStartButton() {
        view.addSubview(startButton)
        startButton.backgroundColor = UIColor.blueButton
        startButton.setTitle("START", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        createStartButtonConstraint()
    }
    
    private func createStartButtonConstraint() {
        startButton.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: heightCell),
            startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -heightCell)
        ])
        
    }
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.textCell) as! TimeTableViewCell
        let objectTimeChess = presenter.time[indexPath.row]
        cell.set(object: objectTimeChess)
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = indexPath.row
        let time = presenter.time[indexPath]
//        presenter.tapStartButton(time: time)
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setTimeChess(timeChess: Time) {
        print(timeChess)
    }
    
    
}
