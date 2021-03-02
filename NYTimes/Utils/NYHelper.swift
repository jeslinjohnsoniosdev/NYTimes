//
//  NYHelper.swift
//  NYTimes
//
//  Created by Chanchal Raj on 02/03/2021.
//  Copyright © 2021 Jeslin Johnson. All rights reserved.
//

import UIKit

func registerNibs<T>(with identifiers: [String], forView view: T) {
    for identifier in identifiers {
        let nib = UINib(nibName: identifier, bundle: nil)
        if let tableView = view as? UITableView {
            tableView.register(nib, forCellReuseIdentifier: identifier)
        } else if let collectionView = view as? UICollectionView {
            collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        }
    }
}
