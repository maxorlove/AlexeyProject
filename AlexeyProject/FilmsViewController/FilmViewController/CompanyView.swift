//
//  CompanyView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 21.01.2023.
//

import UIKit

class CompanyView: UIView {
    
    //MARK: - Properties
    var companyName = UILabel()
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
        addSubview(companyName)
        addSubview(companyImageView)
    }
    
    private func setupConstraints() {
        companyName.translatesAutoresizingMaskIntoConstraints = false
        companyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyImageView.topAnchor.constraint(equalTo: topAnchor),
            companyImageView.heightAnchor.constraint(equalToConstant: 20),
            companyImageView.widthAnchor.constraint(equalToConstant: 20),
            
            companyName.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8),
            companyName.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyName.centerYAnchor.constraint(equalTo: companyImageView.centerYAnchor)
        ])
    }
    
    private func setupName() {
        companyName.font = UIFont.systemFont(ofSize: 15, weight: .light)
        companyName.textColor = Colors.primaryTextOnSurfaceColor
        companyName.textAlignment = .left
        companyName.numberOfLines = 0
    }
    
    private func setupImage() {
        companyName.contentMode = .scaleAspectFill
        companyName.layer.masksToBounds = true
    }
}

