//
//  CompanyView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 21.01.2023.
//

import UIKit

class CompanyView: UIView {
    
    //MARK: - Properties
    var companyNameLabel = UILabel()
    var companyImageView = UIImageView()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupName()
        setupImage()
    }
    
    private func addSubviews() {
        addSubview(companyNameLabel)
        addSubview(companyImageView)
    }
    
    private func setupConstraints() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyImageView.topAnchor.constraint(equalTo: topAnchor),
            companyImageView.heightAnchor.constraint(equalToConstant: 20),
            companyImageView.widthAnchor.constraint(equalToConstant: 20),
            
            companyNameLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8),
            companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyNameLabel.centerYAnchor.constraint(equalTo: companyImageView.centerYAnchor)
        ])
    }
    
    private func setupName() {
        companyNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        companyNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        companyNameLabel.textAlignment = .left
        companyNameLabel.numberOfLines = 0
    }
    
    private func setupImage() {
        companyNameLabel.contentMode = .scaleAspectFill
        companyNameLabel.layer.masksToBounds = true
    }
}

