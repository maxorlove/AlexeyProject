//
//  FilmsPresenter.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 31.01.2023.
//

import Foundation

enum SelectedSortingFilms {
    case popular
    case latest
    case upcomimng
}

protocol FilmsPresenterProtocol: AnyObject {
    func viewDidload()
    func sortingFilms(sort: SelectedSortingFilms)
    func refreshDataSource()
    func pagination()
    func didTapCell(film: Film)
}

final class FilmsPresenter {
    
    weak var controller: FilmsViewControllerProtocol?
    private let networkClient: FilmsNetworkProtocol
    private let router: FilmsRouterProtocol
    private var selectedSorting: SelectedSortingFilms = .popular
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
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

extension FilmsPresenter: FilmsPresenterProtocol {
    
    func viewDidload() {
        controller?.showActivityIndicator()
        loadData(for: currentPage)
    }
    
    func loadData(for page: Int) {
        switch selectedSorting{
        case .popular:
            networkClient.allPopularFilms(page: page) { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.controller?.updateView(films: response)
                        self?.totalPages = response.totalPages
                    }
                case .failure(let error):
                    print("Eror")
                }
            }
        case .latest:
            networkClient.allLatestFilms(page: page) { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.controller?.updateView(films: response)
                        self?.totalPages = response.totalPages
                    }
                case .failure(let error):
                    print("Eror")
                }
            }
        case .upcomimng:
            networkClient.allUpcomingFilms(page: page) { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.controller?.updateView(films: response)
                        self?.totalPages = response.totalPages
                    }
                case .failure(let error):
                    print("Eror")
                }
            }
        }
    }
    
    func sortingFilms(sort: SelectedSortingFilms) {
        selectedSorting = sort
        switch sort {
        case .popular:
            selectedSorting = SelectedSortingFilms.popular
            loadData(for: currentPage)
        case .latest:
            selectedSorting = SelectedSortingFilms.latest
            loadData(for: currentPage)
        case .upcomimng:
            selectedSorting = SelectedSortingFilms.upcomimng
            loadData(for: currentPage)
        }
    }
        
    func refreshDataSource() {
        currentPage = 1
        totalPages = 1
    }
    
    func pagination() {
        if currentPage < totalPages {
            currentPage += 1
            loadData(for: currentPage)
        }
    }
    
    func didTapCell(film: Film) {
        router.showFilmView(film: film)
    }
}
