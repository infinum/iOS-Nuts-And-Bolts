//
//  CatalogPresenter.swift
//  Catalog
//
//  Created by Filip Gulan on 01/02/2019.
//  Copyright (c) 2019 Infinum. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import RxSwift
import RxCocoa

final class CatalogPresenter {

    // MARK: - Private properties -

    private unowned let _view: CatalogViewInterface
    private let _wireframe: CatalogWireframeInterface
    private let _disposeBag = DisposeBag()
    private let _dataSource: CatalogDataSource

    // MARK: - Lifecycle -

    init(view: CatalogViewInterface, wireframe: CatalogWireframeInterface, dataSource: CatalogDataSource = .init()) {
        _view = view
        _wireframe = wireframe
        _dataSource = dataSource
    }
}

// MARK: - Extensions -

extension CatalogPresenter: CatalogPresenterInterface {
    
    func sections() -> [TableSectionItem] {
        let didSelectRelay = PublishRelay<CatalogItem>()
        _handle(didSelect: didSelectRelay)

        return _createSections(didSelect: didSelectRelay)
    }
    
}

private extension CatalogPresenter {

    func _createSections(didSelect: PublishRelay<CatalogItem>) -> [TableSectionItem] {
        return _dataSource
            .sections
            .map { $0.toCatalogSectionItem(didSelect: didSelect) }
    }

    func _handle(didSelect: PublishRelay<CatalogItem>) {
        didSelect
            .subscribe(onNext: { [unowned _wireframe] in
                _wireframe.show($0.model)
            })
            .disposed(by: _disposeBag)
    }
}

extension CatalogSectionModel {

    func toCatalogSectionItem(didSelect: PublishRelay<CatalogItem>) -> CatalogSection {
        let cellItems = items
            .map { CatalogItem(model: $0, didSelect: didSelect) }

        return CatalogSection(title: title, items: cellItems)
    }
}