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
    private var switchMoveCell: Bool = true
        
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
//        self.tableView.isEditing = true
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
        if switchMoveCell == true {
            self.tableView.isEditing = switchMoveCell
            switchMoveCell.toggle()
        } else {
            self.tableView.isEditing = switchMoveCell
            switchMoveCell.toggle()
        }
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
//            tableView.heightAnchor.constraint(equalToConstant: (CGFloat(presenter.time.count) * heightCell))
        ])
//     TODO: complete the right logic
        if presenter.time.count > 9 {
            NSLayoutConstraint.activate([
                tableView.heightAnchor.constraint(equalToConstant: (CGFloat(9) * heightCell))])
        } else {
            NSLayoutConstraint.activate([
                tableView.heightAnchor.constraint(equalToConstant: (CGFloat(presenter.time.count) * heightCell))])
        }
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
        //        presenter.getTime()
        return presenter.time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.textCell) as! TimeTableViewCell
        let timeChess = presenter.time[indexPath.row]
        cell.set(object: timeChess)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (_, _, _) in
            //    MARK: change on presenter
            let time = StorageManager.shared.realm.objects(TimeRealm.self)
            self.presenter.deleteTimeChessInStorageManager(time: time[indexPath.row])
            //            StorageManager.shared.delete(timeChess: time[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.configureTableView()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    //   MARK move rows in tableView
    //     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    //         return .none
    //    }
    //
    //     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    //        return false
    //    }
    //    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //    }
    //}
}
extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let time = presenter.time[indexPath.row]
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setTimeChess(timeChess: TimeRealm) {
        print(timeChess)
    }
}
