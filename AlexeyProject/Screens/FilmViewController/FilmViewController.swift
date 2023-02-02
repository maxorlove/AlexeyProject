//
//  FilmViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 09.01.2023.
//

import UIKit
import SDWebImage

protocol FilmViewControllerProtocol: AnyObject {
    
}

class FilmViewController: UIViewController {
    
    // MARK: - Properties
    private let filmScrollView = UIScrollView()
    private let filmTitle = UILabel()
    private let releaseDateLabel = UILabel()
    private let overviewLabel = UILabel()
    private let runtimeLabel = UILabel()
    private let budgetLabel = UILabel()
    private let revenueLabel = UILabel()
    private let countryNameLabel = UILabel()
    private let scrollViewContainer = UIStackView()
    private let companiesStackView = UIStackView()
    private let countriesStackView = UIStackView()
    private let posterView = PosterImageView()
    private let infoBackGroundView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let baseUrl = ServiceManager()
    private let networkFilm = NetworkService()
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
        scrollViewContainer.addArrangedSubview(releaseDateLabel)
        scrollViewContainer.addArrangedSubview(overviewLabel)
        scrollViewContainer.addArrangedSubview(runtimeLabel)
        scrollViewContainer.addArrangedSubview(budgetLabel)
        scrollViewContainer.addArrangedSubview(revenueLabel)
        scrollViewContainer.addArrangedSubview(companiesStackView)
        scrollViewContainer.addArrangedSubview(countriesStackView)
    }
    
    private func setupConstraints() {
        filmScrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
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

            releaseDateLabel.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            releaseDateLabel.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),

            overviewLabel.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor,constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor,constant: -16),

            runtimeLabel.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            runtimeLabel.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),

            budgetLabel.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            budgetLabel.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),

            revenueLabel.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 16),
            revenueLabel.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -16),
            
            companiesStackView.topAnchor.constraint(equalTo: revenueLabel.bottomAnchor, constant: 20),
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
        scrollViewContainer.alignment = .leading
        
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

        releaseDateLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        releaseDateLabel.textColor = Colors.secondaryTextOnSurfaceColor
        releaseDateLabel.textAlignment = .left
        releaseDateLabel.numberOfLines = 0

        overviewLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        overviewLabel.textColor = Colors.primaryTextOnSurfaceColor
        overviewLabel.textAlignment = .left
        overviewLabel.numberOfLines = 0
        
        runtimeLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        runtimeLabel.textColor = Colors.secondaryTextOnSurfaceColor
        runtimeLabel.textAlignment = .left
        runtimeLabel.numberOfLines = 0

        budgetLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        budgetLabel.textColor = Colors.secondaryTextOnSurfaceColor
        budgetLabel.textAlignment = .left
        budgetLabel.numberOfLines = 0

        revenueLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        revenueLabel.textColor = Colors.secondaryTextOnSurfaceColor
        revenueLabel.textAlignment = .left
        revenueLabel.numberOfLines = 0
        
        countryNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        countryNameLabel.textColor = Colors.secondaryTextOnSurfaceColor
        countryNameLabel.textAlignment = .left
        countryNameLabel.numberOfLines = 0
    }
    
    private func configureSelf(with filmData: FilmResponse) {
        filmTitle.text = filmData.title
        releaseDateLabel.text = filmData.releaseDate
        overviewLabel.text = filmData.overview
        let posterUrl = URL(string: baseUrl.baseImageURL + filmData.poster)
        posterView.posterImageView.sd_setImage(with: posterUrl, completed: nil)
        posterView.posterBackGroundImageView.sd_setImage(with: posterUrl, completed: nil)
        runtimeLabel.text = "run time: \(filmData.runtime) min."
        posterView.voteLabel.text = String(filmData.voteAverage)
        budgetLabel.text = "Budget: \(filmData.budget) $"
        revenueLabel.text = "Revenue: \(filmData.revenue) $"
        
        for company in filmData.productionCompanies {
            let companyView = CompanyView()
            companyView.translatesAutoresizingMaskIntoConstraints = false
            companiesStackView.addArrangedSubview(companyView)
            let companyUrl = URL(string: baseUrl.baseImageURL + (company.logoPath ?? ""))
            companyView.companyImageView.sd_setImage(with: companyUrl, completed: nil)
            companyView.companyNameLabel.text = company.name
        }
        
        for country in filmData.productionCountry {
            countriesStackView.addArrangedSubview(countryNameLabel)
            countryNameLabel.text = "Country: \(country.name)"
        }
    }
}


