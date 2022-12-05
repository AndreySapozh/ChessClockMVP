//
//  AssemblyModelBuilder.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSettingsModule(time: Time,router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
//        let networkService = NetworkService()
        let time = Time()
        let presenter = MainPresenter(view: view, time: time, router: router)
//        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSettingsModule(time: Time, router: RouterProtocol) -> UIViewController {
        let view = SettingsViewController()
        let time = Time()
//        let networkService = NetworkService()\
        let presenter = SettingsPresenter(view: view, router: router, time: time)
//        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
        view.presenter = presenter
        return view
    }

    
}
