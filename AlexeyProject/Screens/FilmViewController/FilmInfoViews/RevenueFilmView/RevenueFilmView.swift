//
//  RevenueBudgetFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class RevenueFilmView: UIView {
    
    //MARK: - Public Properties
    var revenueLabel = UILabel()
    var revenueNameLabel = UILabel()
    
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
        addSubview(revenueLabel)
        addSubview(revenueNameLabel)
    }
    
    private func setupConstraints() {
        revenueLabel.translatesAutoresizingMaskIntoConstraints = false
        revenueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            revenueNameLabel.topAnchor.constraint(equalTo: topAnchor),
            revenueNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            revenueNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            revenueNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            revenueLabel.topAnchor.constraint(equalTo: revenueNameLabel.bottomAnchor, constant: 4),
            revenueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            revenueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            revenueLabel.heightAnchor.constraint(equalToConstant: 24),
            revenueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        revenueLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        revenueLabel.textColor = Colors.primaryTextOnSurfaceColor
        revenueLabel.textAlignment = .left
        revenueLabel.numberOfLines = 0
        
        revenueNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        revenueNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        revenueNameLabel.textAlignment = .left
        revenueNameLabel.numberOfLines = 0
    }
}

