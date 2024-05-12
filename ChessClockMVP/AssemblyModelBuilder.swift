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
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    func createSettingsModule(router: RouterProtocol) -> UIViewController {
        let view = SettingsViewController()
        guard let seconds = presets.first?.seconds else { return view}
        let timeChess = Time(seconds: seconds)
        let presenter = SettingsPresenter(view: view, router: router, timeChess: timeChess)
        view.presenter = presenter
        return view
    }
    func createNewTimeModule(router: RouterProtocol) -> UIViewController {
        let view = NewTimeViewController()
        let newTime = Time(seconds: 60)
        let presenter = NewTimePresenter(view: view, newTimeChess: newTime, router: router)
        view.presenter = presenter
        return view
    }

    
}
