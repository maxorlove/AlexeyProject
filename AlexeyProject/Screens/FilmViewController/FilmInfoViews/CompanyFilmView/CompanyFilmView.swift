//
//  CompanyView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 21.01.2023.
//

import UIKit

class CompanyFilmView: UIView {
    
    //MARK: - Public Properties
    var companyNameLabel = UILabel()
    var companyStackView = UIStackView()
    
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
        setupStackView()
    }
    
    private func addSubviews() {
        addSubview(companyNameLabel)
        addSubview(companyStackView)
    }
    
    private func setupConstraints() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: topAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            companyStackView.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 4),
            companyStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        companyNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        companyNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        companyNameLabel.textAlignment = .left
        companyNameLabel.numberOfLines = 0
    }
    
    private func setupStackView() {
        companyStackView.axis = .vertical
        companyStackView.spacing = 8
        companyStackView.distribution = .fillEqually
        companyStackView.alignment = .fill
        companyStackView.isLayoutMarginsRelativeArrangement = true
    }
}

