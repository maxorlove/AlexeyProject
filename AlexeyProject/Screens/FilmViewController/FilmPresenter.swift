//
//  FilmPresenter.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 02.02.2023.


import Foundation

protocol FilmPresenterProtocol: AnyObject {
    
    //MARK: - Public Methods
    func viewDidload()
    func loadData()
    func didTapCancel()
    func didTapLike()
    func saveFavoriteFilm()
    func isFilmLiked() -> Bool
}

final class FilmPresenter {
    
    //MARK: - Public Methods
    weak var controller: FilmViewControllerProtocol?
    var likedFilm: FilmsViewControllerProtocol?
    var filmData: FilmResponse?
    var likePressed: () -> Void
    
    //MARK: - Private Methods
    private let networkClient: FilmsNetworkProtocol
    private let router: FilmRouterProtocol
    private let filmId: Int
    
    //MARK: - INIT
    init(
        controller: FilmViewControllerProtocol,
        networkClient: FilmsNetworkProtocol,
        router: FilmRouterProtocol,
        likePressed: @escaping () -> Void,
        filmId: Int
    ) {
        self.controller = controller
        self.networkClient = networkClient
        self.router = router
        self.likePressed = likePressed
        self.filmId = filmId
    }
}

//MARK: - FilmPresenterProtocol
extension FilmPresenter: FilmPresenterProtocol {

    func viewDidload() {
        controller?.showActivityIndicator()
        controller?.didTapButton()
        loadData()
    }
    
    func loadData() {
        networkClient.film(id: filmId) { [weak self] result in
            switch result {
            case .success(let responseFilm):
                DispatchQueue.main.async {
                    self?.filmData = responseFilm
                    self?.controller?.updateView(filmData: responseFilm)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.controller?.showErrorAlert()
                }
            }
        }
    }
    
    func didTapCancel() {
        router.showFilmsView()
    }
    
    func saveFavoriteFilm() {
        var arrayFilmsId = UserDefaults.standard.array(forKey: "favoriteFilms")  as? [Int] ?? [Int]()
        var setFilmsId = Set(arrayFilmsId)
        if setFilmsId.contains(filmId) {
            setFilmsId.remove(filmId)
        } else {
            setFilmsId.update(with: filmId)
        }
        arrayFilmsId = Array(setFilmsId)
        UserDefaults.standard.set(arrayFilmsId, forKey: "favoriteFilms")
        likedFilm?.filmCell()
//                controller?.filmsCellUpdate(indexPath: indexPath)
    }
    
    func isFilmLiked() -> Bool {
        var liked = false
        var arrayFilmsId = UserDefaults.standard.array(forKey: "favoriteFilms")  as? [Int] ?? [Int]()
        if arrayFilmsId.contains(filmId) {
            liked = true
        }
        return liked
    }
    
    func didTapLike() {
        controller?.didTapButton()
        
    }
}

