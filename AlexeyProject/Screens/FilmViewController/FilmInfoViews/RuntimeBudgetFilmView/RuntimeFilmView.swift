//
//  RuntimeFilmView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class RuntimeFilmView: UIView {
    
    //MARK: - Public Properties
    var runtimeLabel = UILabel()
    var runtimeNameLabel = UILabel()
    
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
        addSubview(runtimeLabel)
        addSubview(runtimeNameLabel)
    }
    
    private func setupConstraints() {
        runtimeLabel.translatesAutoresizingMaskIntoConstraints = false
        runtimeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            runtimeNameLabel.topAnchor.constraint(equalTo: topAnchor),
            runtimeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            runtimeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            runtimeNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            runtimeLabel.topAnchor.constraint(equalTo: runtimeNameLabel.bottomAnchor, constant: 4),
            runtimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            runtimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            runtimeLabel.heightAnchor.constraint(equalToConstant: 24),
            runtimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupLabel() {
        runtimeLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        runtimeLabel.textColor = Colors.primaryTextOnSurfaceColor
        runtimeLabel.textAlignment = .left
        runtimeLabel.numberOfLines = 0
        
        runtimeNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        runtimeNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        runtimeNameLabel.textAlignment = .left
        runtimeNameLabel.numberOfLines = 0
    }
}
