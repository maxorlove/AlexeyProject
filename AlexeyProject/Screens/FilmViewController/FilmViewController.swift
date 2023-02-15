//
//  FilmViewController.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 09.01.2023.
//

import UIKit
import SDWebImage

protocol FilmViewControllerProtocol: AnyObject {
    
    //MARK: - Public Methods
    func updateView(filmData: FilmResponse)
    func showActivityIndicator()
    func showErrorAlert()
    func didTapButton()
}

class FilmViewController: UIViewController {
    
    // MARK: - Private Properties
    private let filmScrollView = UIScrollView()

    private let scrollViewContainer = UIStackView()
    private let filmTitleStackView = UIStackView()
    private let ratingVotePopularityStackView = UIStackView()
    private let releaseLanguageStackView = UIStackView()
    private let descriptionStackView = UIStackView()
    private let runtimeStackView = UIStackView()
    private let revenueBudgetStackView = UIStackView()
    private let companiesStackView = UIStackView()
    private let countriesStackView = UIStackView()
    
    private let posterImageView = PosterFilmImageView()
    private let filmTitleView = FilmLabelView()
    private let ratingView = RatingFilmView()
    private let voteCountView = VoteCountFilmView()
    private let popularityView = PopularityFilmView()
    private let releaseDateView = ReleaseDateFilmView()
    private let languageFilmView = LanguageFilmView()
    private let descriptionFilmView = DescriptionFilmView()
    private let runtimeFilmView = RuntimeFilmView()
    private let revenueFilmView = RevenueFilmView()
    private let budgetFilmView = BudgetFilmView()
    private let countryFilmView = CountryFilmView()
    private let companyFilmView = CompanyFilmView()
    
    private let infoBackGroundView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Public Properties
    var presenter: FilmPresenterProtocol?
    var isliked = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
            setup()
        presenter?.viewDidload()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubviews()
        setupConstraints()
        setupStackView()
        setupFilmInfoStackViews()
        setupViews()
        setupNavBar()
    }
    
    private func addSubviews() {
        view.addSubview(filmScrollView)
        view.addSubview(activityIndicator)
        filmScrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(posterImageView)
        scrollViewContainer.addArrangedSubview(infoBackGroundView)
        scrollViewContainer.addArrangedSubview(filmTitleStackView)
        scrollViewContainer.addArrangedSubview(filmTitleView)
        scrollViewContainer.addArrangedSubview(ratingVotePopularityStackView)
        scrollViewContainer.addArrangedSubview(releaseLanguageStackView)
        scrollViewContainer.addArrangedSubview(descriptionStackView)
        scrollViewContainer.addArrangedSubview(runtimeStackView)
        scrollViewContainer.addArrangedSubview(revenueBudgetStackView)
        scrollViewContainer.addArrangedSubview(budgetFilmView)
        scrollViewContainer.addArrangedSubview(revenueFilmView)
        scrollViewContainer.addArrangedSubview(countriesStackView)
        scrollViewContainer.addArrangedSubview(companiesStackView)
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
            
            posterImageView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            posterImageView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            posterImageView.heightAnchor.constraint(equalToConstant: 464),
            
            infoBackGroundView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -56),
            infoBackGroundView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            infoBackGroundView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            infoBackGroundView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),

            filmTitleStackView.topAnchor.constraint(equalTo: infoBackGroundView.topAnchor, constant: 24),
            filmTitleStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            filmTitleStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            filmTitleStackView.heightAnchor.constraint(equalToConstant: 104),
            
//            ratingVotePopularityStackView.topAnchor.constraint(equalTo: filmTitleView.bottomAnchor,constant: 8),
            ratingVotePopularityStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            ratingVotePopularityStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            ratingVotePopularityStackView.heightAnchor.constraint(equalToConstant: 104),

            releaseLanguageStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            releaseLanguageStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            releaseLanguageStackView.heightAnchor.constraint(equalToConstant: 78),

            descriptionStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor,constant: 8),
            descriptionStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor,constant: -8),

            runtimeStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            runtimeStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            runtimeStackView.heightAnchor.constraint(equalToConstant: 78),

            revenueBudgetStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            revenueBudgetStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            revenueBudgetStackView.heightAnchor.constraint(equalToConstant: 78),

            countriesStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            countriesStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            
            companiesStackView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 8),
            companiesStackView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -8),
            
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
        
        filmTitleStackView.axis = .horizontal
        filmTitleStackView.distribution = .fillEqually
        filmTitleStackView.isLayoutMarginsRelativeArrangement = true
        filmTitleStackView.layoutMargins = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
        
        ratingVotePopularityStackView.axis = .horizontal
        ratingVotePopularityStackView.spacing = 8
        ratingVotePopularityStackView.distribution = .fillEqually
        ratingVotePopularityStackView.isLayoutMarginsRelativeArrangement = true
        ratingVotePopularityStackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        releaseLanguageStackView.axis = .horizontal
        releaseLanguageStackView.spacing = 16
        releaseLanguageStackView.distribution = .fillEqually
        releaseLanguageStackView.alignment = .center
        releaseLanguageStackView.isLayoutMarginsRelativeArrangement = true
        releaseLanguageStackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        descriptionStackView.axis = .horizontal
        descriptionStackView.spacing = 16
        descriptionStackView.distribution = .fillEqually
        descriptionStackView.alignment = .center
        descriptionStackView.isLayoutMarginsRelativeArrangement = true
        descriptionStackView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        
        runtimeStackView.axis = .horizontal
        runtimeStackView.spacing = 16
        runtimeStackView.distribution = .fillEqually
        runtimeStackView.alignment = .center
        runtimeStackView.isLayoutMarginsRelativeArrangement = true
        runtimeStackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        revenueBudgetStackView.axis = .horizontal
        revenueBudgetStackView.spacing = 16
        revenueBudgetStackView.distribution = .fillEqually
        revenueBudgetStackView.alignment = .center
        revenueBudgetStackView.isLayoutMarginsRelativeArrangement = true
        revenueBudgetStackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        countriesStackView.axis = .horizontal
        countriesStackView.spacing = 16
        countriesStackView.distribution = .fillEqually
        countriesStackView.alignment = .center
        countriesStackView.isLayoutMarginsRelativeArrangement = true
        countriesStackView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        
        companiesStackView.axis = .horizontal
        companiesStackView.spacing = 16
        companiesStackView.distribution = .fillEqually
        companiesStackView.alignment = .center
        companiesStackView.isLayoutMarginsRelativeArrangement = true
        companiesStackView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
    }
    
    private func setupViews() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 24
        posterImageView.clipsToBounds = true
        
        infoBackGroundView.backgroundColor = Colors.primaryBackGroundColor
        infoBackGroundView.contentMode = .scaleAspectFill
        infoBackGroundView.clipsToBounds = true
        infoBackGroundView.layer.cornerRadius = 24
        infoBackGroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = Colors.primaryBackGroundColor
    }
    
    private func setupFilmInfoStackViews() {
        filmTitleStackView.addArrangedSubview(filmTitleView)
        
        ratingVotePopularityStackView.addArrangedSubview(ratingView)
        ratingVotePopularityStackView.addArrangedSubview(voteCountView)
        ratingVotePopularityStackView.addArrangedSubview(popularityView)
       
        releaseLanguageStackView.addArrangedSubview(releaseDateView)
        releaseLanguageStackView.addArrangedSubview(languageFilmView)
        
        descriptionStackView.addArrangedSubview(descriptionFilmView)
        revenueBudgetStackView.addArrangedSubview(budgetFilmView)
        revenueBudgetStackView.addArrangedSubview(revenueFilmView)
        
        runtimeStackView.addArrangedSubview(runtimeFilmView)
        countriesStackView.addArrangedSubview(countryFilmView)
        companiesStackView.addArrangedSubview(companyFilmView)
    }
    
    private func didTap() {
        posterImageView.heartTapCallBack = { [weak self] in
            self?.presenter?.saveFavoriteFilm()
        }
    }
    
    private func configureSelf(with filmData: FilmResponse, isLiked: Bool) {
        filmTitleView.filmTitleLabel.text = filmData.title
        descriptionFilmView.filmDescriptionLabel.text = filmData.description
        let posterUrl = URL(string: NetworkСonstants.baseImageURL + filmData.poster)
        posterImageView.posterImageView.sd_setImage(with: posterUrl, completed: nil)
        posterImageView.posterBackGroundImageView.sd_setImage(with: posterUrl, completed: nil)
        ratingView.ratingLabel.text = String(format: "%.1f",filmData.voteAverage)
        ratingView.ratingNameLabel.text = "Rating"
        voteCountView.voteCountLabel.text = String(filmData.voteCount)
        voteCountView.voteCountNameLabel.text = "Vote count"
        popularityView.popularutyLabel.text = String(format: "%.2f",filmData.popularity)
        popularityView.popularityNameLabel.text = "Popularity"
        releaseDateView.releaseLabel.text = String(filmData.releaseDate)
        releaseDateView.releaseNameLabel.text = "Release"
        languageFilmView.languageLabel.text = filmData.originalLanguage
        languageFilmView.languageNameLabel.text = "Language"
        runtimeFilmView.runtimeLabel.text = "\(filmData.runtime) min"
        runtimeFilmView.runtimeNameLabel.text = "Runtime:"
        budgetFilmView.budgetLabel.text = "\(filmData.budget) $"
        budgetFilmView.budgetNameLabel.text = "Budget:"
        revenueFilmView.revenueLabel.text = "\(filmData.revenue) $"
        revenueFilmView.revenueNameLabel.text = "Revenue:"
        countryFilmView.countryNameLabel.text = "Country:"
        companyFilmView.companyNameLabel.text = "Companies"
        
        for company in filmData.productionCompanies {
            let infoView = CompanyInfoFilmView()
            infoView.translatesAutoresizingMaskIntoConstraints = false
            companyFilmView.companyStackView.addArrangedSubview(infoView)
            let companyUrl = URL(string: NetworkСonstants.baseImageURL + (company.logoPath ?? ""))
            infoView.companyImageView.sd_setImage(with: companyUrl, completed: nil)
            infoView.companyLabel.text = company.name
        }
        
        for country in filmData.productionCountry {
            let infoView = CountryInfoFilmView()
            infoView.translatesAutoresizingMaskIntoConstraints = false
            countryFilmView.countryStackView.addArrangedSubview(infoView)
            infoView.countryLabel.translatesAutoresizingMaskIntoConstraints = false
            infoView.countryLabel.text = country.name
        }
        
        if isLiked == false {
            posterImageView.likeButtonisTepped = false
            posterImageView.favoriteFilmButtonImageView.image = UIImage(named: "dislike")?.withRenderingMode(.alwaysTemplate)
        } else {
            posterImageView.likeButtonisTepped = true
            posterImageView.favoriteFilmButtonImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    private func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong. Try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [self] action in
            presenter?.loadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [self] action in
            presenter?.didTapCancel()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: FilmViewControllerProtocol
extension FilmViewController: FilmViewControllerProtocol {
    
    func updateView(filmData: FilmResponse) {
        activityIndicator.stopAnimating()
        configureSelf(with: filmData, isLiked: presenter?.isFilmLiked() ?? isliked)
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func showErrorAlert() {
        errorAlert()
    }
    
    func didTapButton() {
        didTap()
    }
}


