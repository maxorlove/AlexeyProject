//
//  FilmViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 09.01.2023.
//

import UIKit
import SDWebImage
class  FilmViewController: UIViewController {
    
    // MARK: - Properties
    private let filmTitle = UILabel()
    private let posterImageView = UIImageView()
    private let releaseDate = UILabel()
    private let voteAverage = UILabel()
    private let overview = UILabel()
    private let runtime = UILabel()
    private let companyName = UILabel()
    private let companyLogoImageView = UIImageView()
    private let baseUrl = ServiceManager()
    private let networkClient2 = NetworkServiceImpForFilm()
    
    private var filmData: FilmResponse?
    
    var film: Films?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let film = film {
            loadData(for: film.id)
            setup()
            print(film.id)
        }
    }
    
    // MARK: - Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupLabels()
        setupImageView()
    }
    
    private func loadData(for id: Int) {
        networkClient2.film(id: film?.id ?? 1) { [weak self] result in
            switch result {
            case .success(let responseFilm):
                DispatchQueue.main.async {
                    self?.filmData = responseFilm
                    self?.configureSelf(with: self?.filmData)
                }
            case .failure(let error):
                error.localizedDescription
                break
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(posterImageView)
        view.addSubview(filmTitle)
        view.addSubview(releaseDate)
        view.addSubview(voteAverage)
        view.addSubview(overview)
        view.addSubview(runtime)
        view.addSubview(companyName)
        view.addSubview(companyLogoImageView)
    }
    
    private func setupConstraints() {
        filmTitle.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        voteAverage.translatesAutoresizingMaskIntoConstraints = false
        runtime.translatesAutoresizingMaskIntoConstraints = false
        companyName.translatesAutoresizingMaskIntoConstraints = false
        companyLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            posterImageView.heightAnchor.constraint(equalToConstant: 180),
            posterImageView.widthAnchor.constraint(equalToConstant: 120),
            
            filmTitle.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            filmTitle.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            filmTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            overview.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            overview.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: filmTitle.trailingAnchor),
            overview.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupLabels() {
        view.backgroundColor = .blue
        
        filmTitle.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        filmTitle.textColor = .black
        filmTitle.textAlignment = .left
        filmTitle.numberOfLines = 0
        
        overview.font = UIFont.systemFont(ofSize: 18, weight: .light)
        overview.textColor = .black
        overview.textAlignment = .left
        overview.numberOfLines = 0
    }
    
    private func setupImageView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.masksToBounds = true
    }
    
    func configureSelf(with filmData: FilmResponse?) {
        filmTitle.text = filmData?.title
        overview.text = filmData?.overview
        let url = URL(string: baseUrl.baseImageURL + (filmData?.poster ?? ""))
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}


