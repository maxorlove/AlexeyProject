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
    
    private let networkFilms = NetworkServiceImplForFilms()
    private var dataSource: [Film] = []
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private let switchCollectionButton = UIButton()
    private let sortFilmsButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var selectedLayout: CellLayout = .twoCell
    private var selectedSorting: SelectedSortingFilms = .popular
    
    private enum CellLayout {
        case oneCell
        case twoCell
    }
    
    private enum SelectedSortingFilms {
        case popular
        case latest
        case upcomimng
    }
    
    private enum ConstantsForCell {
        static let twoCellReuseId = "GridCollectionViewCellIdentifier"
        static let oneCellReuseId = "OneCollectionViewCellIdentifier"
        static let numberOfItemsInRow: CGFloat = 2
        static let spacingForOne: CGFloat = 0
        static let spacingForTwo: CGFloat = 8
        static let cellWidthForOne = UIScreen.main.bounds.width
        static let cellWidthForTwo = UIScreen.main.bounds.width/numberOfItemsInRow - 12
        static let cellHeightForOne: CGFloat = 204
        static let cellHeightForTwo: CGFloat = 276
        static let insetForSectionOne = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let insetForSectionTwo = UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Methods
    private func loadData(for page: Int) {
        switch selectedSorting{
        case .popular:
            networkFilms.allPopularFilms(page: page) { [weak self] result in
                switch result {
                    case .success(let response):
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                        self?.dataSource.append(contentsOf: response.results)
                        self?.totalPages = response.totalPages
                        self?.collectionView.reloadData()
                    }
                    case .failure(let error):
                    error.localizedDescription
                }
            }
        case .latest:
            networkFilms.allLatestFilms(page: page) { [weak self] result in
                switch result {
                    case .success(let response):
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                        self?.dataSource.append(contentsOf: response.results)
                        self?.totalPages = response.totalPages
                        self?.collectionView.reloadData()
                    }
                    case .failure(let error):
                    error.localizedDescription
                }
            }
        case .upcomimng:
            networkFilms.allUpcomingFilms(page: page) { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                        self?.dataSource.append(contentsOf: response.results)
                        self?.totalPages = response.totalPages
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    error.localizedDescription
                }
            }
        }
    }
    
    private func setup() {
        addSubviews()
        layout()
        setupCollectionView()
        setupNavBar()
        setupButton()
        loadData(for: currentPage)
        activityIndicator.startAnimating()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(switchCollectionButton)
        view.addSubview(sortFilmsButton)
        view.addSubview(activityIndicator)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        switchCollectionButton.translatesAutoresizingMaskIntoConstraints = false
        sortFilmsButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            sortFilmsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61.81),
            sortFilmsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            switchCollectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -61.81),
            switchCollectionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavBar() {
        navigationItem.title = "Movies"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 54)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.primaryTextOnSurfaceColor ?? .white]
        view.backgroundColor = Colors.primaryBackGroundColor
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilmGridCollectionViewCell.self, forCellWithReuseIdentifier: ConstantsForCell.twoCellReuseId)
        collectionView.register(OneFilmCollectionViewCell.self, forCellWithReuseIdentifier: ConstantsForCell.oneCellReuseId)
    }
    
    private func setupButton() {
        switchCollectionButton.setImage(UIImage(named: "oneCell"), for: [])
        switchCollectionButton.contentMode = .scaleAspectFill
        switchCollectionButton.addTarget(self, action: #selector(switchCollectionOfFilms), for: .touchUpInside)
        
        sortFilmsButton.setImage(UIImage(named: "sort"), for: [])
        sortFilmsButton.contentMode = .scaleAspectFill
        sortFilmsButton.addTarget(self, action: #selector(sortingFilms), for: .touchUpInside)
    }
    
    private func switchCollectionLayout() {
        if selectedLayout == CellLayout.twoCell {
            selectedLayout = CellLayout.oneCell
            switchCollectionButton.setImage(UIImage(named: "twoCell"), for: [])
        } else {
            selectedLayout = CellLayout.twoCell
            switchCollectionButton.setImage(UIImage(named: "oneCell"), for: [])
        }
        collectionView.reloadData()
    }
    
    private func sortAlert() {
        let alert = UIAlertController(title: "Pick a Sort", message: "Sort by ", preferredStyle: .actionSheet)
        
        let popularAction = UIAlertAction(title: "Popular", style: .default) {[weak self] (action) in
            guard self != nil else {
                return
            }
            self?.selectedSorting = SelectedSortingFilms.popular
            if self?.selectedSorting == SelectedSortingFilms.popular {
                self?.loadData(for: self?.currentPage ?? 1)
            }
        }
        
        let latestAction = UIAlertAction(title: "Latest", style: .default) {[ weak self] (action) in
            guard let self = self else {
                return
            }
            self.selectedSorting = SelectedSortingFilms.latest
            if self.selectedSorting == SelectedSortingFilms.latest {
                self.loadData(for: self.currentPage)
            }
        }
        
        let upcomingAction = UIAlertAction(title: "Upcoming", style: .default) {[ weak self] (action) in
            guard let self = self else {
                return
            }
            self.selectedSorting = SelectedSortingFilms.upcomimng
            if self.selectedSorting == SelectedSortingFilms.upcomimng {
                self.loadData(for: self.currentPage)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(popularAction)
        alert.addAction(latestAction)
        alert.addAction(upcomingAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func refreshDataSource() {
        dataSource = []
        currentPage = 1
        totalPages = 1
    }

    @objc func sortingFilms(sender: UIButton) {
        sortAlert()
        refreshDataSource()
    }
    
    @objc func switchCollectionOfFilms(sender: UIButton) {
        switchCollectionLayout()
    }
}

//MARK: - UICollectionViewDataSource
extension FilmsGridViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = dataSource[indexPath.row]
        
        switch selectedLayout{
        case .oneCell:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ConstantsForCell.oneCellReuseId,
                for: indexPath
            ) as! OneFilmCollectionViewCell
            cell.configure(with: film)
            return cell
            
        case .twoCell:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ConstantsForCell.twoCellReuseId,
                for: indexPath
            ) as! FilmGridCollectionViewCell
            cell.configure(with: film)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FilmsGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch selectedLayout{
        case .oneCell:
            return CGSize(width: ConstantsForCell.cellWidthForOne, height: ConstantsForCell.cellHeightForOne)
    
        case .twoCell:
            return CGSize(width: ConstantsForCell.cellWidthForTwo, height: ConstantsForCell.cellHeightForTwo)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch selectedLayout{
        case .oneCell:
            return ConstantsForCell.insetForSectionOne
    
        case .twoCell:
            return ConstantsForCell.insetForSectionTwo
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch selectedLayout{
        case .oneCell:
            return ConstantsForCell.spacingForOne
    
        case .twoCell:
            return ConstantsForCell.spacingForTwo
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if dataSource.count - 3 == indexPath.row,
           currentPage < totalPages {
            currentPage += 1
            switch selectedSorting{
            case .popular:
                loadData(for: currentPage)
            case .latest:
                loadData(for: currentPage)
            case .upcomimng:
                loadData(for: currentPage)
            }
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
    func openFilmScreen(film: Film) {
        let controller = FilmViewController()
        controller.film = film
        navigationController?.pushViewController(controller, animated: true)
    }
}

