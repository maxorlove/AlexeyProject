//
//  CompanyInfoView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class CompanyInfoFilmView: UIView {
    
    //MARK: - Public Properties
    var companyLabel = UILabel()
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
    
    //MARK: - Private Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupLabel()
    }
    
    private func addSubviews() {
        addSubview(companyLabel)
        addSubview(companyImageView)
    }
    
    private func setupConstraints() {
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyImageView.topAnchor.constraint(equalTo: topAnchor),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyImageView.heightAnchor.constraint(equalToConstant: 20),
            companyImageView.widthAnchor.constraint(equalToConstant: 50),
            companyImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            companyLabel.topAnchor.constraint(equalTo: topAnchor),
            companyLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8),
            companyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyLabel.heightAnchor.constraint(equalToConstant: 20),
            companyLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        companyLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        companyLabel.textColor = Colors.primaryTextOnSurfaceColor
        companyLabel.textAlignment = .left
        companyLabel.numberOfLines = 0
    }
    
    private func setupImageView() {
        companyImageView.contentMode = .scaleAspectFit
        companyImageView.layer.masksToBounds = true
    }
}


