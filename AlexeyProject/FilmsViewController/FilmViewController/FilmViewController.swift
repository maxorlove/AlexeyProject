//
//  FilmViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 09.01.2023.
//

import UIKit
import SDWebImage
class FilmViewController: UIViewController {
    
    // MARK: - Properties
    private let filmScrollView = UIScrollView()
    private let filmTitle = UILabel()
    private let releaseDate = UILabel()
    private let overview = UILabel()
    private let runtime = UILabel()
    private let budget = UILabel()
    private let revenue = UILabel()
    private let countryName = UILabel()
    private let scrollViewContainer = UIStackView()
    private let companiesStackView = UIStackView()
    private let countriesStackView = UIStackView()
    private let posterView = PosterImageView()
    private let infoBackGroundView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let baseUrl = ServiceManager()
    private let networkFilm = NetworkServiceImplForFilms()
    private var filmData: FilmResponse?
    
    var film: Film?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let film = film {
            loadData(for: film.id)
                setup()
            }
        if let filmData = filmData {
            configureSelf(with: filmData)
        }
    }
    
    // MARK: - Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupStackView()
        setupLabels()
        setupViews()
        setupNavBar()
        activityIndicator.startAnimating()
    }
    
    private func loadData(for id: Int) {
        networkFilm.film(id: id) { [weak self] result in
            switch result {
            case .success(let responseFilm):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.filmData = responseFilm
                    self?.configureSelf(with: responseFilm)
                }
            case .failure(let error):
                error.localizedDescription
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(filmScrollView)
        view.addSubview(activityIndicator)
        filmScrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(posterView)
        scrollViewContainer.addArrangedSubview(infoBackGroundView)
        scrollViewContainer.addArrangedSubview(filmTitle)
        scrollViewContainer.addArrangedSubview(releaseDate)
        scrollViewContainer.addArrangedSubview(overview)
        scrollViewContainer.addArrangedSubview(runtime)
        scrollViewContainer.addArrangedSubview(budget)
        scrollViewContainer.addArrangedSubview(revenue)
        scrollViewContainer.addArrangedSubview(companiesStackView)
        scrollViewContainer.addArrangedSubview(countriesStackView)
    }
    
    private func setupConstraints() {
        filmScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        posterView.translatesAutoresizingMaskIntoConstraints = false
        infoBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        filmTitle.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        runtime.translatesAutoresizingMaskIntoConstraints = false
        budget.translatesAutoresizingMaskIntoConstraints = false
        revenue.translatesAutoresizingMaskIntoConstraints = false
        companiesStackView.translatesAutoresizingMaskIntoConstraints = false
        countriesStackView.translatesAutoresizingMaskIntoConstraints = false
        countryName.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filmScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            filmScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filmScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollViewContainer.topAnchor.constraint(equalTo: filmScrollView.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: filmScrollView.leadingAnchor),
            scrollViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            scrollViewContainer.trailingAnchor.constraint(equalTo: filmScrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: filmScrollView.bottomAnchor),
            
            posterView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 589),
            
            infoBackGroundView.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: -96),
            infoBackGroundView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            infoBackGroundView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            infoBackGroundView.bottomAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 4),

            filmTitle.topAnchor.constraint(equalTo: infoBackGroundView.topAnchor, constant: 24),
            filmTitle.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            filmTitle.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),

            releaseDate.topAnchor.constraint(equalTo: filmTitle.bottomAnchor, constant: 8),
            releaseDate.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            releaseDate.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            releaseDate.heightAnchor.constraint(equalToConstant: 20),

            overview.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 16),
            overview.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor,constant: 16),
            overview.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor,constant: -16),

            runtime.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 8),
            runtime.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            runtime.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            runtime.heightAnchor.constraint(equalToConstant: 20),
            
            budget.topAnchor.constraint(equalTo: runtime.bottomAnchor, constant: 8),
            budget.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            budget.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            budget.heightAnchor.constraint(equalToConstant: 20),

            revenue.topAnchor.constraint(equalTo: budget.bottomAnchor, constant: 8),
            revenue.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            revenue.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            revenue.heightAnchor.constraint(equalToConstant: 20),
            
            companiesStackView.topAnchor.constraint(equalTo: revenue.bottomAnchor, constant: 20),
            companiesStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            companiesStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            
            countriesStackView.topAnchor.constraint(equalTo: companiesStackView.bottomAnchor, constant: 20),
            countriesStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            countriesStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            countriesStackView.heightAnchor.constraint(equalToConstant: 60),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavBar() {
        navigationItem.title = "Movie"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = Colors.primaryTextOnSurfaceColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.primaryTextOnSurfaceColor ?? .blue]
    }
    
    private func setupStackView() {
        scrollViewContainer.axis = .vertical
        scrollViewContainer.distribution = .fill
        scrollViewContainer.spacing = 8
        scrollViewContainer.alignment = .center
        
        companiesStackView.axis = .vertical
        companiesStackView.spacing = 30
        companiesStackView.distribution = .fillProportionally
        
        countriesStackView.axis = .vertical
        countriesStackView.spacing = 30
        countriesStackView.distribution = .fillEqually
    }
    
    private func setupViews() {
        posterView.contentMode = .scaleAspectFill
        infoBackGroundView.backgroundColor = Colors.primaryBackGroundColor
        infoBackGroundView.contentMode = .scaleAspectFill
        
        infoBackGroundView.clipsToBounds = true
        infoBackGroundView.layer.cornerRadius = 24
        infoBackGroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = Colors.primaryBackGroundColor
    }
    
    private func setupLabels() {
        filmTitle.font = UIFont.systemFont(ofSize: 37, weight: .bold)
        filmTitle.textColor = Colors.primaryTextOnSurfaceColor
        filmTitle.textAlignment = .left
        filmTitle.numberOfLines = 0

        releaseDate.font = UIFont.systemFont(ofSize: 17, weight: .light)
        releaseDate.textColor = Colors.secondaryTextOnSurfaceColor
        releaseDate.textAlignment = .left
        releaseDate.numberOfLines = 0

        overview.font = UIFont.systemFont(ofSize: 20, weight: .light)
        overview.textColor = Colors.primaryTextOnSurfaceColor
        overview.textAlignment = .left
        overview.numberOfLines = 0
        
        runtime.font = UIFont.systemFont(ofSize: 15, weight: .light)
        runtime.textColor = Colors.secondaryTextOnSurfaceColor
        runtime.textAlignment = .left
        runtime.numberOfLines = 0

        budget.font = UIFont.systemFont(ofSize: 15, weight: .light)
        budget.textColor = Colors.secondaryTextOnSurfaceColor
        budget.textAlignment = .left
        budget.numberOfLines = 0

        revenue.font = UIFont.systemFont(ofSize: 15, weight: .light)
        revenue.textColor = Colors.secondaryTextOnSurfaceColor
        revenue.textAlignment = .left
        revenue.numberOfLines = 0
        
        countryName.font = UIFont.systemFont(ofSize: 15, weight: .light)
        countryName.textColor = Colors.secondaryTextOnSurfaceColor
        countryName.textAlignment = .left
        countryName.numberOfLines = 0
    }
    
    private func configureSelf(with filmData: FilmResponse) {
        filmTitle.text = filmData.title
        releaseDate.text = filmData.releaseDate
        overview.text = filmData.overview
        let posterUrl = URL(string: baseUrl.baseImageURL + filmData.poster)
        posterView.posterImageView.sd_setImage(with: posterUrl, completed: nil)
        posterView.posterBackGroundImageView.sd_setImage(with: posterUrl, completed: nil)
        runtime.text = "run time: \(filmData.runtime) min."
        posterView.voteLabel.text = String(filmData.voteAverage)
        budget.text = "Budget: \(filmData.budget) $"
        revenue.text = "Revenue: \(filmData.revenue) $"
        
        for company in filmData.productionCompanies {
            let companyView = CompanyView()
            companyView.translatesAutoresizingMaskIntoConstraints = false
            companiesStackView.addArrangedSubview(companyView)
            let companyUrl = URL(string: baseUrl.baseImageURL + (company.logoPath ?? ""))
            companyView.companyImageView.sd_setImage(with: companyUrl, completed: nil)
            companyView.companyName.text = company.name
        }
        
        for country in filmData.productionCountry {
            countriesStackView.addArrangedSubview(countryName)
            countryName.text = "Country: \(country.name)"
        }
    }
}


