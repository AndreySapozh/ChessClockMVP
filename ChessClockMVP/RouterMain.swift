//
//  RouterMain.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set}
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showSettings()
    func popToRoot()
    func showCreateNewTime()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
   
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showSettings() {
        if let navigationController = navigationController {
            guard let settingsViewController = assemblyBuilder?.createSettingsModule(router: self) else { return }
            navigationController.pushViewController(settingsViewController, animated: true)
        }
        
    }
    
    func showCreateNewTime() {
        if let navigationController = navigationController {
            guard let newTimeViewController = assemblyBuilder?.createNewTimeModule(router: self) else { return }
            navigationController.pushViewController(newTimeViewController, animated: true)
            
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

