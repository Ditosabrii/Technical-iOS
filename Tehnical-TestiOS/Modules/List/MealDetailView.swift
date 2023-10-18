//
//  MealDetailView.swift
//  Tehnical-TestiOS
//
//  Created by Dito on 18/10/23.
//

import Foundation
import UIKit
import SDWebImage

class MealDetailViewController: UIViewController {
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mealTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let mealInstructionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        
        if let meal = meal {
            mealTitleLabel.text = meal.strMeal
            mealInstructionsLabel.text = meal.strInstructions
            if let imageURL = URL(string: meal.strMealThumb) {
                mealImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder_image"))
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(mealImageView)
        view.addSubview(mealTitleLabel)
        view.addSubview(mealInstructionsLabel)
        
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mealInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            mealImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mealImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mealImageView.heightAnchor.constraint(equalToConstant: 200),
            
            mealTitleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 16),
            mealTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mealTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mealInstructionsLabel.topAnchor.constraint(equalTo: mealTitleLabel.bottomAnchor, constant: 16),
            mealInstructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mealInstructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
