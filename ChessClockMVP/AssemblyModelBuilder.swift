//
//  AssemblyModelBuilder.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol, timeChess: Time) -> UIViewController
    func createSettingsModule(router: RouterProtocol, timeChess: Time) -> UIViewController
    func createNewTimeModule(router: RouterProtocol, newTimeChess: Time) -> UIViewController
}

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol, timeChess: Time) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router, timerTopPlayer: Timer(), timerBottomPlayer: Timer(), timeChess: timeChess)
        view.presenter = presenter
        return view
    }

    func createSettingsModule(router: RouterProtocol, timeChess: Time) -> UIViewController {
        let view = SettingsViewController()
//        guard let seconds = presets.first?.seconds else { return view}
//        let timeChess = Time(seconds: seconds)
        let time = presets
        let presenter = SettingsPresenter(view: view, router: router, timeChess: timeChess, time: time)
        view.presenter = presenter
        return view
    }
    func createNewTimeModule(router: RouterProtocol, newTimeChess: Time) -> UIViewController {
        let view = NewTimeViewController()
        let presenter = NewTimePresenter(view: view, router: router, newTimeChess: newTimeChess)
        view.presenter = presenter
        return view
    }

    
}
