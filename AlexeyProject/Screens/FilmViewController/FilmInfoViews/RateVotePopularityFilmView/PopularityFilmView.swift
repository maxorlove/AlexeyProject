//
//  PopularityFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class PopularityFilmView: UIView {
    
    //MARK: - Public Properties
    var popularutyLabel = UILabel()
    var popularityNameLabel = UILabel()
    
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
        setupView()
        setupConstraints()
        setupLabel()
    }
    
    private func addSubviews() {
        addSubview(popularutyLabel)
        addSubview(popularityNameLabel)
    }
    
    private func setupConstraints() {
        popularutyLabel.translatesAutoresizingMaskIntoConstraints = false
        popularityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popularutyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            popularutyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            popularutyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            popularityNameLabel.topAnchor.constraint(equalTo: popularutyLabel.bottomAnchor),
            popularityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            popularityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            popularityNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
    
    private func setupView() {
        backgroundColor = Colors.rateBackGroundColor
        layer.cornerRadius = 24
        layer.masksToBounds = true
    }
    
    private func setupLabel() {
        popularutyLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        popularutyLabel.textColor = Colors.primaryTextOnSurfaceColor
        popularutyLabel.textAlignment = .left
        popularutyLabel.numberOfLines = 0
        
        popularityNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        popularityNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        popularityNameLabel.textAlignment = .left
        popularityNameLabel.numberOfLines = 0
    }
}
