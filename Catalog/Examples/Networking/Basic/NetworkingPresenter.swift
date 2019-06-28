//
//  NetworkingPresenter.swift
//
//  Created by Filip Gulan on 25/04/2019.
//  Copyright (c) 2019 Infinum. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class NetworkingPresenter {

    // MARK: - Private properties -

    private unowned let view: NetworkingViewInterface
    private let interactor: NetworkingInteractorInterface
    private let wireframe: NetworkingWireframeInterface

    // MARK: - Lifecycle -

    init(view: NetworkingViewInterface, interactor: NetworkingInteractorInterface, wireframe: NetworkingWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension NetworkingPresenter: NetworkingPresenterInterface {

    func viewDidLoad() {
        interactor.login(email: "ios.team@infinum.hr", password: "infinum1") { result in
            switch result {
            case .success:
                print("Login successful")
            case .failure(let error):
                print("Login error: \(error)")
            }
        }
    }

}
