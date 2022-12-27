//
//  SettingsViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    var presenter: SettingsViewPresenterProtocol!
    let startButton = UIButton()
    var tableView = UITableView()
    
    let heightCell: CGFloat = 50
    
    var objects: [TimeChess] = [TimeChess(timeChess: "Create new time"), TimeChess(timeChess: "Fischer Blitz 5|0"), TimeChess(timeChess: "Fischer 5|5") , TimeChess(timeChess: "Tournament 40/2hr, 1hr")]
    
    struct Cells {
        static let textCell = "textCell"
    }		


    override func viewDidLoad() {
        view.backgroundColor = .white
        configureTableView()
        configureStartButton()
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)

    }
    
    @objc private func didTapStartButton() {
        presenter.tapStartButton()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
//        set delegates
        setTableViewDelegates()
//        set row height
        tableView.rowHeight = heightCell
//        register cells
        tableView.register(TimeTableViewCell.self, forCellReuseIdentifier: Cells.textCell)
//        set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(2 * heightCell)).isActive = true
    }
    
    func configureStartButton() {
        view.addSubview(startButton)
        
        startButton.backgroundColor = UIColor(red: 10/255, green: 100/255, blue: 200/255, alpha: 1)
        startButton.setTitle("START", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        createStartButtonConstraint()
    }
    
    func createStartButtonConstraint() {
        startButton.layer.cornerRadius = 3
        
        startButton.heightAnchor.constraint(equalToConstant: heightCell).isActive = true
        startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -heightCell).isActive = true
        
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
 
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.textCell) as! TimeTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapCreateNewTime()
    }
    


}


extension SettingsViewController: SettingsViewProtocol {
    func setTimeChess(timeChess: TimeChess ) {
        print(timeChess)
    }
    

}
