//
//  FilmViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import UIKit
import SDWebImage

final class FilmCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    private let nameLabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
        setupImageView()
        imageView.backgroundColor = .red
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [imageView, nameLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),


            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        nameLabel.numberOfLines = 0
    }
    
    func configure(with model: Character) {
        nameLabel.text = "\(model.name)"
        let url = URL(string: model.image)
        imageView.sd_setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
}

