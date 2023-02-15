//
//  File.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 06.01.2023.
//

import UIKit
import SDWebImage

protocol FilmsViewControllerProtocol: AnyObject {
    
    //MARK: - Public Methods
    func updateView(films: FilmsResponse)
    func showActivityIndicator()
    func setupSortingLabel(navigationItemTitle: String, sortButtonLabel: String)
    func showErrorAlert()
//    func filmsCellUpdate(indexPath: IndexPath)
    func filmCell()
}

class FilmsViewController: UIViewController {
    
    //MARK: - Private Properties
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private var dataSource: [Film] = []
    private let switchCollectionButton = UIButton()
    private let switchCollectionButtonImageView = UIImageView()
    private let sortFilmsButton = UIButton()
    private let sortFilmsButtonLabel = UILabel()
    private let sortFilmsButtonChevronView = UIImageView()
    private let customBlurEffectViewForSortButton = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
    private let customBlurEffectViewForSwitchButton = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let refreshControl = UIRefreshControl()
    private var selectedLayout: CellLayout = .gridCell
    private var isFavorite = false
    
    //MARK: - Private Enums
    private enum CellLayout {
        case singleCell
        case gridCell
    }
    
    private enum ConstantsForCell {
        static let gridCellReuseId = "GridCollectionViewCellIdentifier"
        static let singleCellReuseId = "SingleCollectionViewCellIdentifier"
        static let numberOfItemsInRow: CGFloat = 2
        static let spacingForSingle: CGFloat = 0
        static let spacingForGrid: CGFloat = 8
        static let cellWidthForSingle = UIScreen.main.bounds.width
        static let cellWidthForGrid = UIScreen.main.bounds.width/numberOfItemsInRow - 12
        static let cellHeightForSingle: CGFloat = 204
        static let cellHeightForGrid: CGFloat = 276
        static let insetForSectionSingle = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let insetForSectionGrid = UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8)
    }
    
    //MARK: - Publick Properties
    var presenter: FilmsPresenterProtocol?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        UserDefaults.standard.removeObject(forKey: "favoriteFilms")
        presenter?.viewDidload()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubviews()
        layout()
        setupCollectionView()
        setupNavBar()
        setupButton()
        setupLabels()
        setupImageView()
        shadowEffect()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(customBlurEffectViewForSortButton)
        view.addSubview(customBlurEffectViewForSwitchButton)
        view.addSubview(switchCollectionButton)
        view.addSubview(switchCollectionButtonImageView)
        view.addSubview(sortFilmsButton)
        view.addSubview(sortFilmsButtonLabel)
        view.addSubview(sortFilmsButtonChevronView)
        view.addSubview(activityIndicator)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForSortButton.translatesAutoresizingMaskIntoConstraints = false
        customBlurEffectViewForSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        switchCollectionButton.translatesAutoresizingMaskIntoConstraints = false
        switchCollectionButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        sortFilmsButton.translatesAutoresizingMaskIntoConstraints = false
        sortFilmsButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        sortFilmsButtonChevronView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            customBlurEffectViewForSortButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 104),
            customBlurEffectViewForSortButton.heightAnchor.constraint(equalToConstant: 48),
            customBlurEffectViewForSortButton.widthAnchor.constraint(equalToConstant: 121),
            customBlurEffectViewForSortButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            sortFilmsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 104),
            sortFilmsButton.heightAnchor.constraint(equalToConstant: 48),
            sortFilmsButton.widthAnchor.constraint(equalToConstant: 121),
            sortFilmsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            sortFilmsButtonLabel.topAnchor.constraint(equalTo: sortFilmsButton.topAnchor, constant: 16),
            sortFilmsButtonLabel.leadingAnchor.constraint(equalTo: sortFilmsButton.leadingAnchor, constant: 12),
            sortFilmsButtonLabel.bottomAnchor.constraint(equalTo: sortFilmsButton.bottomAnchor, constant: -16),

            sortFilmsButtonChevronView.topAnchor.constraint(equalTo: sortFilmsButton.topAnchor, constant: 12),
            sortFilmsButtonChevronView.leadingAnchor.constraint(equalTo: sortFilmsButtonLabel.trailingAnchor, constant: 8),
            sortFilmsButtonChevronView.trailingAnchor.constraint(equalTo: sortFilmsButton.trailingAnchor, constant: -12),
            sortFilmsButtonChevronView.bottomAnchor.constraint(equalTo: sortFilmsButton.bottomAnchor, constant: -12),
            
            customBlurEffectViewForSwitchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -104),
            customBlurEffectViewForSwitchButton.heightAnchor.constraint(equalToConstant: 48),
            customBlurEffectViewForSwitchButton.widthAnchor.constraint(equalToConstant: 56),
            customBlurEffectViewForSwitchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            switchCollectionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -104),
            switchCollectionButton.heightAnchor.constraint(equalToConstant: 48),
            switchCollectionButton.widthAnchor.constraint(equalToConstant: 56),
            switchCollectionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            switchCollectionButtonImageView.topAnchor.constraint(equalTo: switchCollectionButton.topAnchor, constant: 12),
            switchCollectionButtonImageView.leadingAnchor.constraint(equalTo: switchCollectionButton.leadingAnchor, constant: 16),
            switchCollectionButtonImageView.trailingAnchor.constraint(equalTo: switchCollectionButton.trailingAnchor, constant: -16),
            switchCollectionButtonImageView.bottomAnchor.constraint(equalTo: switchCollectionButton.bottomAnchor, constant: -12),
            
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
        collectionView.refreshControl = refreshControl
        collectionView.register(GridFilmsCollectionViewCell.self, forCellWithReuseIdentifier: ConstantsForCell.gridCellReuseId)
        collectionView.register(SingleFilmCollectionViewCell.self, forCellWithReuseIdentifier: ConstantsForCell.singleCellReuseId)
    }
    
    private func setupButton() {
        switchCollectionButton.backgroundColor = Colors.primaryBackGroundColor?.withAlphaComponent(0.5)
        switchCollectionButton.layer.cornerRadius = 20
        switchCollectionButton.layer.masksToBounds = true
        switchCollectionButton.addTarget(self, action: #selector(switchCollectionOfFilms), for: .touchUpInside)
        
        sortFilmsButton.backgroundColor = Colors.primaryBackGroundColor?.withAlphaComponent(0.5)
        sortFilmsButton.layer.cornerRadius = 20
        sortFilmsButton.layer.masksToBounds = true
        sortFilmsButton.addTarget(self, action: #selector(sortingFilms), for: .touchUpInside)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func setupLabels() {
        sortFilmsButtonLabel.text = "POPULAR"
        sortFilmsButtonLabel.textColor = Colors.primaryTextOnSurfaceColor
        sortFilmsButtonLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        sortFilmsButtonLabel.textAlignment = .center
        sortFilmsButtonLabel.numberOfLines = 0
    }
    
    private func setupImageView() {
        sortFilmsButtonChevronView.contentMode = .scaleAspectFit
        sortFilmsButtonChevronView.image = UIImage(systemName: "chevron.down")
        sortFilmsButtonChevronView.tintColor = Colors.primaryTextOnBackGroundColor
        
        switchCollectionButtonImageView.contentMode = .scaleAspectFill
        switchCollectionButtonImageView.image = UIImage(named: "oneCell")?.withRenderingMode(.alwaysTemplate)
        switchCollectionButtonImageView.tintColor = Colors.primaryTextOnBackGroundColor
    }
    
    private func shadowEffect() {
        sortFilmsButton.layer.shadowColor = UIColor.black.cgColor
        sortFilmsButton.layer.shadowOpacity = 0.4
        sortFilmsButton.layer.shadowOffset = CGSize.zero
        sortFilmsButton.layer.shadowRadius = 20
        sortFilmsButton.layer.masksToBounds = false
        
        switchCollectionButton.layer.shadowColor = UIColor.black.cgColor
        switchCollectionButton.layer.shadowOpacity = 0.4
        switchCollectionButton.layer.shadowOffset = CGSize.zero
        switchCollectionButton.layer.shadowRadius = 20
        switchCollectionButton.layer.masksToBounds = false
        
        customBlurEffectViewForSortButton.layer.cornerRadius = 20
        customBlurEffectViewForSortButton.layer.masksToBounds = true
        
        customBlurEffectViewForSwitchButton.layer.cornerRadius = 20
        customBlurEffectViewForSwitchButton.layer.masksToBounds = true
    }
    
    private func switchCollectionLayout() {
        if selectedLayout == CellLayout.gridCell {
            selectedLayout = CellLayout.singleCell
            switchCollectionButtonImageView.image = UIImage(named: "twoCell")?.withRenderingMode(.alwaysTemplate)
        } else {
            selectedLayout = CellLayout.gridCell
            switchCollectionButtonImageView.image = UIImage(named: "oneCell")?.withRenderingMode(.alwaysTemplate)
        }
        collectionView.reloadData()
    }
    
    private func sortAlert() {
        let alert = UIAlertController(title: "Pick a Sort", message: "Sort by ", preferredStyle: .actionSheet)
        
        let popularAction = UIAlertAction(title: "Popular", style: .default) {[weak self] (action) in
            guard self != nil else {
                return
            }
            self?.refreshDataSource()
            self?.presenter?.sortingFilms(sort: .popular)
        }
        
        let latestAction = UIAlertAction(title: "Latest", style: .default) {[ weak self] (action) in
            guard let self = self else {
                return
            }
            self.refreshDataSource()
            self.presenter?.sortingFilms(sort: .latest)
        }
        
        let upcomingAction = UIAlertAction(title: "Upcoming", style: .default) {[ weak self] (action) in
            guard let self = self else {
                return
            }
            self.refreshDataSource()
            self.presenter?.sortingFilms(sort: .upcomimng)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(popularAction)
        alert.addAction(latestAction)
        alert.addAction(upcomingAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong. Try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [self] action in
            refreshDataSource()
            presenter?.viewDidload()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [self] action in
            activityIndicator.stopAnimating()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func isFilmLiked(film: Film) -> Bool {
        var liked = false
        var arrayFilmsId = UserDefaults.standard.array(forKey: "favoriteFilms")  as? [Int] ?? [Int]()
        if arrayFilmsId.contains(film.id) {
            liked = true
        }
        return liked
    }
    
    private func refreshDataSource() {
        dataSource = []
        presenter?.refreshDataSource()
    }

    @objc private func sortingFilms(sender: UIButton) {
        sortAlert()
    }
    
    @objc private func switchCollectionOfFilms(sender: UIButton) {
        switchCollectionLayout()
    }
    
     @objc private func refresh(sender: UIButton) {
         dataSource = []
         presenter?.refreshDataSource()
         presenter?.viewDidload()
    }
}

//MARK: - UICollectionViewDataSource
extension FilmsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < dataSource.count else {
            return UICollectionViewCell()
        }
        
        let film = dataSource[indexPath.row]
        switch selectedLayout{
        case .singleCell:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ConstantsForCell.singleCellReuseId,
                for: indexPath
            ) as! SingleFilmCollectionViewCell
            cell.configure(with: film, isliked: isFilmLiked(film: film))
            cell.heartTapCellCallBack = { [weak self] in
                self?.presenter?.saveFavoriteFilm(film: film, indexPath: indexPath)
            }
            return cell
            
        case .gridCell:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ConstantsForCell.gridCellReuseId,
                for: indexPath
            ) as! GridFilmsCollectionViewCell
            cell.configure(with: film, isliked: isFilmLiked(film: film))
            cell.heartTapLikeCallBack = { [weak self] in
                self?.presenter?.saveFavoriteFilm(film: film, indexPath: indexPath)
            }
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FilmsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch selectedLayout{
        case .singleCell:
            return CGSize(width: ConstantsForCell.cellWidthForSingle, height: ConstantsForCell.cellHeightForSingle)
            
        case .gridCell:
            return CGSize(width: ConstantsForCell.cellWidthForGrid, height: ConstantsForCell.cellHeightForGrid)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch selectedLayout{
        case .singleCell:
            return ConstantsForCell.insetForSectionSingle
            
        case .gridCell:
            return ConstantsForCell.insetForSectionGrid
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch selectedLayout{
        case .singleCell:
            return ConstantsForCell.spacingForSingle
    
        case .gridCell:
            return ConstantsForCell.spacingForGrid
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if dataSource.count - 3 == indexPath.row {
            presenter?.pagination()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexOfView = indexPath.row
        let film = dataSource[indexOfView]
        presenter?.didTapCell(film: film, indexPath: indexPath)
    }
}

//MARK: - FilmsViewControllerProtocol
extension FilmsViewController: FilmsViewControllerProtocol {
    
    func updateView(films: FilmsResponse) {
        refreshControl.endRefreshing()
        dataSource.append(contentsOf: films.results)
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func setupSortingLabel(navigationItemTitle: String, sortButtonLabel: String) {
        navigationItem.title = navigationItemTitle
        sortFilmsButtonLabel.text = sortButtonLabel
    }
    
    func showErrorAlert() {
        errorAlert()
    }
    
//    func filmsCellUpdate(indexPath: IndexPath) {
//        collectionView.reloadItems(at: [indexPath])
//    }
    
    func filmCell() {
        collectionView.reloadData()
    }
}


