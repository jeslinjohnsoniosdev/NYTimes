//
//  NewsVC.swift
//  NYTimes
//
//  Created by Jeslin Johnson on 01/03/2021.
//  Copyright © 2021 Jeslin Johnson. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var newsTableView: UITableView!

    // MARK: - Variables

    var newsModel = NewsModel()
    var news = NewsResultModel(status: "", copyright: "", numResults: 0, results: nil) {
        didSet {
            updateUI()
        }
    }

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMostViewedNewsArticles()
        registerCells()
    }
    
    // MARK: - Actions
    
    // MARK: - Custom Targets
    
    // MARK: - Custom Methods

    func fetchMostViewedNewsArticles() {
        newsModel.fetchNews(section: "all-sections", period: "7") { (model, error) in
            DispatchQueue.main.async {
                if let data = model {
                    self.news = data
                }
            }
        }
    }

    func updateUI() {
        newsTableView.reloadData()
    }

    func registerCells() {
        registerNibs(with: ["NewsTVC"], forView: newsTableView)
    }
    // MARK: - API Calls
    
    // MARK: - Navigation


}

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVC") as? NewsTVC else {
            return UITableViewCell()
        }
        let data = news.results?[indexPath.row]
        cell.updateCell(title: data?.title, abstract: data?.abstract)
        return cell
    }
}
