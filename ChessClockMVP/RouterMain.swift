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
    func initialViewController(timeChess: Time)
    func showSettings(timeChess: Time)
    func showCreateNewTime(timeChess: Time)
//    func popToRoot(time: Time)
    func backToSettings(timeChess: Time)
    func backToMainView(timeChess: Time)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
   
    func initialViewController(timeChess: Time) {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self, timeChess: timeChess) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showSettings(timeChess: Time) {
        if let navigationController = navigationController {
            guard let settingsViewController = assemblyBuilder?.createSettingsModule(router: self, timeChess: timeChess) else { return }
            navigationController.pushViewController(settingsViewController, animated: true)
        }
    }
    
    func showCreateNewTime(timeChess: Time) {
        if let navigationController = navigationController {
            guard let newTimeViewController = assemblyBuilder?.createNewTimeModule(router: self, newTimeChess: timeChess) else { return }
            navigationController.pushViewController(newTimeViewController, animated: true)
        }
    }
    
//    func popToRoot(time: Time) {
//        if let navigationController = navigationController {
////            guard let
//            navigationController.popToRootViewController(animated: true)
////            navigationController.viewControllers[
//        }
//    }
    
    func backToSettings(timeChess: Time) {
        if let navigationController = navigationController {
            guard let settingsViewController = assemblyBuilder?.createSettingsModule(router: self, timeChess: timeChess) else { return }
            navigationController.popToViewController(settingsViewController, animated: true)
        }
    }
    func backToMainView(timeChess: Time) {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self, timeChess: timeChess) else { return }
            navigationController.setViewControllers([mainViewController], animated: true)
        }
    }
}


