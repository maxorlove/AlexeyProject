//
//  File.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 06.01.2023.
//

import UIKit
import SDWebImage

class FilmsGridViewController: UIViewController {
    
    //MARK: - Properties
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let networkPopularFims = NetworkServiceImplForPopularFilms()
//    private let networkLatestFims = NetworkServiceImplForLatestFilms()
//    private let networkUpcomingFims = NetworkServiceImplForUpcomingFilms()
//    private let networkClient2 = NetworkServiceImpForFilm()
    private var dataSource: [Films] = []
    var filmDataSource: FilmResponse?
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private let onethreeButton = UIButton()
    private let sortFilms = UIButton()
    private var oneThree : Bool = false
//    private var info = FilmViewController()
    
    private enum OneThreeCell {
        static var gridCellReuseId = "GridCollectionViewCellIdentifier"
        static var numberOfItemsInRow: CGFloat = 3
        static var itemSizeWidth: CGFloat = UIScreen.main.bounds.width/numberOfItemsInRow - spacing
        static var itemSizeHeight: CGFloat = UIScreen.main.bounds.height/5
        static var spacing: CGFloat = 5
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData1(for: currentPage)
    }
    
    // MARK: - Methods
    private func loadData1(for page: Int) {
        networkPopularFims.allPopularFilms(page: page) { [weak self] result in
            switch result {
                case .success(let response):
                DispatchQueue.main.async {
                    self?.dataSource.append(contentsOf: response.results)
                        //мб переделаю, чтобы всё парсилось сразу на главном экране
//                    for film in response.results {
//                        self?.networkClient2.film(id: film.id) { [weak self] result in
//                            switch result {
//                                case .success(let responseFilm):
//                                DispatchQueue.main.async {
//                                    self?.filmDataSource = responseFilm
//                                }
//                                case .failure(let error):
//                                error.localizedDescription
//                                    break
//                            }
//                        }
//                    }
                    self?.totalPages = response.totalPages 
                    self?.collectionView.reloadData()
                }
                case .failure(let error):
                error.localizedDescription
                    break
            }
        }
    }
    
    private func loadData2(for page: Int) {
        networkPopularFims.allLatestFilms(page: page) { [weak self] result in
            switch result {
                case .success(let response):
                DispatchQueue.main.async {
                    self?.dataSource.append(contentsOf: response.results)
                    self?.totalPages = response.totalPages
                    self?.collectionView.reloadData()
                }
                case .failure(let error):
                error.localizedDescription
                    break
            }
        }
    }
    
    private func loadData3(for page: Int) {
        networkPopularFims.allUpcomingFilms(page: page) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.dataSource.append(contentsOf: response.results)
                    self?.totalPages = response.totalPages
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                error.localizedDescription
                break
            }
        }
    }
    
    private func setup() {
        addSubviews()
        layout()
        setupCollectionView()
        setupNavBar()
        setupButton()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(onethreeButton)
        view.addSubview(sortFilms)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        onethreeButton.translatesAutoresizingMaskIntoConstraints = false
        sortFilms.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNavBar() {
        title = "Films"
        view.backgroundColor = .systemGreen
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: sortFilms)
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: onethreeButton)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilmGridCollectionViewCell.self, forCellWithReuseIdentifier: OneThreeCell.gridCellReuseId)
    }
    
    private func setupButton() {
        onethreeButton.setImage(UIImage(systemName: "list.bullet.clipboard"), for: [])
        onethreeButton.contentMode = .scaleAspectFill
        onethreeButton.tintColor = .systemRed
        onethreeButton.addTarget(self, action: #selector(oneThreeFilms), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: onethreeButton)
        
        sortFilms.setImage(UIImage(systemName: "questionmark.app"), for: [])
        sortFilms.contentMode = .scaleAspectFill
        sortFilms.tintColor = .systemRed
        sortFilms.addTarget(self, action: #selector(sortingFilms), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortFilms)
    }
    
    private func oneThreeCell() {
        if oneThree == false {
            OneThreeCell.spacing = 5
            OneThreeCell.numberOfItemsInRow = 1
            OneThreeCell.itemSizeHeight = UIScreen.main.bounds.height/1.45
            OneThreeCell.itemSizeWidth = UIScreen.main.bounds.width/OneThreeCell.numberOfItemsInRow - OneThreeCell.spacing
            oneThree = true
        } else {
            oneThree = false
            OneThreeCell.spacing = 5
            OneThreeCell.numberOfItemsInRow = 3
            OneThreeCell.itemSizeHeight = UIScreen.main.bounds.height/5
            OneThreeCell.itemSizeWidth = UIScreen.main.bounds.width/OneThreeCell.numberOfItemsInRow - OneThreeCell.spacing
        }
        collectionView.reloadData()
    }
    
    private func sortAlert() {
        let alert = UIAlertController(title: "Pick a Sort", message: "Sort by ", preferredStyle: .actionSheet)

        let popularAction = UIAlertAction(title: "Popular", style: .default) {[weak self] (action) in
            guard let self = self else {
                return
            }
            self.loadData1(for: self.currentPage)
        }

        let latestAction = UIAlertAction(title: "Latest", style: .default) {[ weak self] (action) in
            guard let self = self else {
                return
            }
            self.loadData2(for: self.currentPage)
        }
        
        let upcomingAction = UIAlertAction(title: "Upcoming", style: .default) {[ weak self] (action) in
            guard let self = self else {
                return
            }
            self.loadData3(for: self.currentPage)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(popularAction)
        alert.addAction(latestAction)
        alert.addAction(upcomingAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func sortingFilms(sender: UIButton) {
        sortAlert()
    }
    
    @objc func oneThreeFilms(sender: UIButton) {
        oneThreeCell()
    }
}

//MARK: - UICollectionViewDataSource
extension FilmsGridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OneThreeCell.gridCellReuseId,
            for: indexPath
        ) as! FilmGridCollectionViewCell
        cell.configure(with: model)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FilmsGridViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: OneThreeCell.itemSizeWidth, height: OneThreeCell.itemSizeHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return OneThreeCell.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if dataSource.count - 3 == indexPath.row,
        currentPage < totalPages {
            currentPage += 1
            loadData1(for: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexOfView = indexPath.row
        let film = dataSource[indexOfView]
        openFilmScreen(film: film)
    }
}

// MARK: - Routing
extension FilmsGridViewController {
    
    func openFilmScreen(film: Films) {
        let controller = FilmViewController()
        controller.film = film
        navigationController?.pushViewController(controller, animated: true)
    }
}

