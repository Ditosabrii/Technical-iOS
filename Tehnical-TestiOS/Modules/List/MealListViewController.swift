//
//  HomeViewController.swift
//  Tehnical-TestiOS
//
//  Created by Dito on 18/10/23.
//

import Foundation
import UIKit


class MealListViewController: UIViewController {
    private let tableView = UITableView()
    private var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchMeals(query: "your_search_query")
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MealCell.self, forCellReuseIdentifier: "MealCell")
        view.addSubview(tableView)
        
        // Define constraints for the table view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func searchMeals(query: String) {
        MealAPIManager.shared.searchMeals(query: query) { [weak self] (meals, error) in
            if let meals = meals {
                self?.meals = meals
                self?.tableView.reloadData()
            } else if let error = error {
                // error
            }
        }
    }
}

extension MealListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell
        let meal = meals[indexPath.row]
        cell.configure(with: meal)
        return cell
    }
}
