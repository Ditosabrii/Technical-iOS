//
//  MealCell.swift
//  Tehnical-TestiOS
//
//  Created by Dito on 18/10/23.
//


import Foundation
import UIKit
import SDWebImage

class MealCell: UITableViewCell {
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mealTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealTitleLabel)
        
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Define constraints for the image view
        NSLayoutConstraint.activate([
            mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mealImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mealImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mealImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        // Define constraints for the title label
        NSLayoutConstraint.activate([
            mealTitleLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 8),
            mealTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mealTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with meal: Meal) {
        mealTitleLabel.text = meal.strMeal
        if let imageURL = URL(string: meal.strMealThumb) {
            mealImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder_image"))
        }
    }
}
