//
//  AssemblyModelBuilder.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSettingsModule(router: RouterProtocol) -> UIViewController
    func createNewTimeModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let time = Time(seconds: 120, name: "bullet", moveNumber: 1)
//        let time = Time(seconds: 180, )
//        let presenter = MainPresenter(view: view, time: time, router: router, timer: Timer())
        let presenter = MainPresenter(view: view, time: time, router: router)
        view.presenter = presenter
        return view
    }

    func createSettingsModule(router: RouterProtocol) -> UIViewController {
        let view = SettingsViewController()
        let timeChess = TimeChess(timeChess: "first")
        let presenter = SettingsPresenter(view: view, router: router, timeChess: timeChess)
        view.presenter = presenter
        return view
    }
    func createNewTimeModule(router: RouterProtocol) -> UIViewController {
        let view = NewTimeViewController()
        let newTime = NewTime(newTimeSeconds: 60)
        let presenter = NewTimePresenter(view: view, newTimeChess: newTime, router: router)
        view.presenter = presenter
        return view
    }

    
}
