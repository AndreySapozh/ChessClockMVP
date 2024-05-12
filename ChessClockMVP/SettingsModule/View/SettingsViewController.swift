//
//  SettingsViewController.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

final class SettingsViewController: UIViewController {

    var presenter: SettingsViewPresenterProtocol!
    private let startButton = UIButton()
    private var tableView = UITableView()
    
    private let heightCell: CGFloat = 50
    
    var chessTimeOptions: [TimeChess] = [
        TimeChess(timeChess: "Create custom time"),
        TimeChess(timeChess: "Fischer Blitz 5|0"),
        TimeChess(timeChess: "Fischer 5|5"),
        TimeChess(timeChess: "Tournament 40/2hr, 1hr")]
 
    private let timeChess: [Time] = presets
    
    struct Cells {
        static let textCell = "textCell"
    }		


    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteView
        setupNavigationBar()
        configureTableView()
        configureStartButton()
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)

    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Time Controls"
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
        moveDeleteRowsRightBarButton()
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        presenter.tapStartButton()
    }
    
    @objc private func didTapStartButton() {
        presenter.tapStartButton()
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
//        set delegates
        setTableViewDelegates()
//        set row height
        tableView.rowHeight = heightCell
//        register cells
        tableView.register(TimeTableViewCell.self, forCellReuseIdentifier: Cells.textCell)
//        set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(2 * heightCell))
                                    ])
        }
    
    private func configureStartButton() {
        view.addSubview(startButton)
        
//        startButton.backgroundColor = UIColor(red: 10/255, green: 100/255, blue: 200/255, alpha: 1)
        startButton.backgroundColor = UIColor.blueButton
        startButton.setTitle("START", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        createStartButtonConstraint()
    }
    
    private func createStartButtonConstraint() {
        startButton.layer.cornerRadius = 3
        
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

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chessTimeOptions.count
        return timeChess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.textCell) as! TimeTableViewCell
//        let object = chessTimeOptions[indexPath.row]
//        cell.set(object: object)
        let objectTimeChess = timeChess[indexPath.row]
        cell.set(object: objectTimeChess)
        return cell
        
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenter.tapCreateNewTime()
        }
        
        else { return }
    }

}

extension SettingsViewController: SettingsViewProtocol {
    func setTimeChess(timeChess: TimeChess ) {
        print(timeChess)
    }
    

}
