//
//  SettingsViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    var presenter: SettingsViewPresenterProtocol!
    var tableView = UITableView()
    
    var objects: [TimeChess] = [TimeChess(timeChess: "Bullet"), TimeChess(timeChess: "Fischer Blitz 5|0"), TimeChess(timeChess: "Fischer 5|5") , TimeChess(timeChess: "Tournament 40/2hr, 1hr")]
    
    struct Cells {
        static let textCell = "textCell"
    }


    override func viewDidLoad() {
        configureTableView()
//        presenter.setTime()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
//        set delegates
        setTableViewDelegates()
//        set row height
        tableView.rowHeight = 50
//        register cells
        tableView.register(TimeTableViewCell.self, forCellReuseIdentifier: Cells.textCell)
//        set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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

}


extension SettingsViewController: SettingsViewProtocol {
    func setTime(time: Time?) {
        print(time!)
    }
    

}
