//
//  FilmsPresenter.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 31.01.2023.
//

import Foundation

//MARK: - Public Enums
enum SelectedSortingFilms {
    case popular
    case latest
    case upcomimng
}

protocol FilmsPresenterProtocol: AnyObject {
    
    //MARK: - Public Methods
    func viewDidload()
    func loadData()
    func sortingFilms(sort: SelectedSortingFilms)
    func refreshDataSource()
    func pagination()
    func didTapCell(film: Film, indexPath: IndexPath)
    func saveFavoriteFilm(film: Film, indexPath: IndexPath)
}

final class FilmsPresenter {
    
    //MARK: - Private Properties
    private let networkClient: FilmsNetworkProtocol
    private let router: FilmsRouterProtocol
    private var selectedSorting: SelectedSortingFilms = .popular
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
    //MARK: - Public Properties
    weak var controller: FilmsViewControllerProtocol?
    
    //MARK: - Init/Deinit
    init(
        controller: FilmsViewControllerProtocol,
        networkClient: FilmsNetworkProtocol,
        router: FilmsRouterProtocol
    ) {
        self.controller = controller
        self.networkClient = networkClient
        self.router = router
    }
}

//MARK: - FilmsPresenterProtocol
extension FilmsPresenter: FilmsPresenterProtocol {
    
    func viewDidload() {
        controller?.showActivityIndicator()
        loadData()
    }
    
    func loadData() {
        switch selectedSorting{
        case .popular:
            networkClient.allPopularFilms(page: currentPage) { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.controller?.updateView(films: response)
                        self?.totalPages = response.totalPages
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.controller?.showErrorAlert()
                    }
                }
            }
        case .latest:
            networkClient.allLatestFilms(page: currentPage) { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.controller?.updateView(films: response)
                        self?.totalPages = response.totalPages
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.controller?.showErrorAlert()
                    }
                }
            }
        case .upcomimng:
            networkClient.allUpcomingFilms(page: currentPage) { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.controller?.updateView(films: response)
                        self?.totalPages = response.totalPages
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.controller?.showErrorAlert()
                    }
                }
            }
        }
    }
    
    func sortingFilms(sort: SelectedSortingFilms) {
        selectedSorting = sort
        var navigationItemTitle = ""
        var sortButtonLabel = ""
        switch sort {
        case .popular:
            selectedSorting = SelectedSortingFilms.popular
            navigationItemTitle = "Popular"
            sortButtonLabel = "POPULAR"
            loadData()
        case .latest:
            selectedSorting = SelectedSortingFilms.latest
            navigationItemTitle = "Latest"
            sortButtonLabel = "LATEST"
            loadData()
        case .upcomimng:
            selectedSorting = SelectedSortingFilms.upcomimng
            navigationItemTitle = "Upcoming"
            sortButtonLabel = "UPCOMING"
            loadData()
        }
        controller?.setupSortingLabel(navigationItemTitle: navigationItemTitle, sortButtonLabel: sortButtonLabel)
    }
    
    func refreshDataSource() {
        currentPage = 1
        totalPages = 1
    }
    
    func pagination() {
        if currentPage < totalPages {
            currentPage += 1
            loadData()
        }
    }
    
    func didTapCell(film: Film, indexPath: IndexPath) {
        router.showFilmView(
            film: film,
            likePressed: { [weak self] in
                self?.saveFavoriteFilm(film: film, indexPath: indexPath)
            })
//        controller?.filmsCellUpdate(indexPath: indexPath)
    }
    
    func saveFavoriteFilm(film: Film, indexPath: IndexPath) {
        var arrayFilmsId = UserDefaults.standard.array(forKey: "favoriteFilms")  as? [Int] ?? [Int]()
        var setFilmsId = Set(arrayFilmsId)
        if setFilmsId.contains(film.id) {
            setFilmsId.remove(film.id)
        } else {
            setFilmsId.update(with: film.id)
        }
        arrayFilmsId = Array(setFilmsId)
        UserDefaults.standard.set(arrayFilmsId, forKey: "favoriteFilms")
    }
}
