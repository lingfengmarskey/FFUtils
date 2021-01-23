//
//  BaseCollectionHelper.swift
//  Pods
//
//  Created by MarcosMang on R 3/01/21.
//

import Foundation
import UIKit
public class CollectionHelper: NSObject {
    public var collection: UICollectionView
    public var data: TableDataModel?

    public var didTapCell: ((IndexPath, TableDataModel?) -> Void)?

    // MARK: - Life method

    public init(collection: UICollectionView) {
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

    public func configData(_ collectionData: TableDataModel) {
        data = collectionData
        collection.reloadData()
    }
}
extension CollectionHelper: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionModel = data?.section[safe: section] else { return 0 }
        return sectionModel.cells.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionModel = data?.section[safe: indexPath.section],
            let cellModel = sectionModel.cells[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        collection.registerNibCell(nibName: cellModel.reuseIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.reuseIdentifier, for: indexPath)
        cell.bindData(cellModel)
        return cell
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data?.section.count ?? 0
    }
}

extension CollectionHelper: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapCell?(indexPath, data)
    }
}
