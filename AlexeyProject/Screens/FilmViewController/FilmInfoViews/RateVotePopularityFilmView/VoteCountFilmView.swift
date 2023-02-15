//
//  VoteCountView.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.02.2023.
//

import UIKit

class VoteCountFilmView: UIView {
    
    //MARK: - Public Properties
    var voteCountLabel = UILabel()
    var voteCountNameLabel = UILabel()
    
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
        addSubview(voteCountNameLabel)
        addSubview(voteCountLabel)
    }
    
    private func setupConstraints() {
        voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        voteCountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            voteCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            voteCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            voteCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            voteCountNameLabel.topAnchor.constraint(equalTo: voteCountLabel.bottomAnchor),
            voteCountNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            voteCountNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            voteCountNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
    
    private func setupView() {
        backgroundColor = Colors.rateBackGroundColor
        layer.cornerRadius = 24
        layer.masksToBounds = true
    }
    
    private func setupLabel() {
        voteCountLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        voteCountLabel.textColor = Colors.primaryTextOnSurfaceColor
        voteCountLabel.textAlignment = .left
        voteCountLabel.numberOfLines = 0
        
        voteCountNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        voteCountNameLabel.textColor = Colors.primaryTextOnSurfaceColor
        voteCountNameLabel.textAlignment = .left
        voteCountNameLabel.numberOfLines = 0
    }
}
