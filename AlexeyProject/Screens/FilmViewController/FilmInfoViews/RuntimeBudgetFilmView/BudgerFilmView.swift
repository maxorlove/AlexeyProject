//
//  BudgerFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class BudgetFilmView: UIView {
    
    //MARK: - Public Properties
    var budgetLabel = UILabel()
    var budgetNameLabel = UILabel()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Private Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupLabel()
    }
    
    private func addSubviews() {
        addSubview(budgetLabel)
        addSubview(budgetNameLabel)
    }
    
    private func setupConstraints() {
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            budgetNameLabel.topAnchor.constraint(equalTo: topAnchor),
            budgetNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            budgetNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            budgetNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            budgetLabel.topAnchor.constraint(equalTo: budgetNameLabel.bottomAnchor, constant: 4),
            budgetLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            budgetLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            budgetLabel.heightAnchor.constraint(equalToConstant: 24),
            budgetLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        budgetLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        budgetLabel.textColor = Colors.primaryTextOnSurfaceColor
        budgetLabel.textAlignment = .left
        budgetLabel.numberOfLines = 0
        
        budgetNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        budgetNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        budgetNameLabel.textAlignment = .left
        budgetNameLabel.numberOfLines = 0
    }
}


