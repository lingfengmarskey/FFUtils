//
//  BaseCollectionHelper.swift
//  Pods
//
//  Created by MarcosMang on R 3/01/21.
//

import Foundation
import UIKit
class CollectionHelper: NSObject {
    internal var collection: UICollectionView
    internal var data: TableDataModel?

    var didTapCell: ((IndexPath, TableDataModel?) -> Void)?

    // MARK: - Life method

    init(collection: UICollectionView) {
        self.collection = collection
        super.init()
        setup()
    }

    open func configCommon() {}

    private func setup() {
        collection.dataSource = self
        collection.delegate = self
        configCommon()
    }

    internal func configData(_ collectionData: TableDataModel) {
        data = collectionData
        collection.reloadData()
    }
}
extension CollectionHelper: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionModel = data?.section[safe: section] else { return 0 }
        return sectionModel.cells.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionModel = data?.section[safe: indexPath.section],
            let cellModel = sectionModel.cells[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.reuseIdentifier, for: indexPath)
        cell.bindData(cellModel)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data?.section.count ?? 0
    }
}

extension CollectionHelper: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapCell?(indexPath, data)
    }
}
