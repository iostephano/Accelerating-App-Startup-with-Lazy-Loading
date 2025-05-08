//
//  CardsStackViewController.swift
//  Accelerating App Startup with Lazy Loading
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

class CardsStackViewController: UIViewController {
    // MARK: - Data Model
    private var projects: [Project] = [
        .init(
            title: "Project X",
            lastModified: Date(),
            previewImageName: "preview1",
            description: "This project demonstrates how lazy loading improves startup time by deferring initialization of heavy layers."
        ),
        .init(
            title: "Project Y",
            lastModified: Date(timeIntervalSinceNow: -86400 * 20),
            previewImageName: "preview2",
            description: "In this case, image decoding is delayed until the view is presented."
        ),
        .init(
            title: "Project Z",
            lastModified: Date(timeIntervalSinceNow: -86400 * 60),
            previewImageName: "preview3",
            description: "Optimizes canvas rendering by skipping offscreen processing until interaction."
        )
    ]

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Accelerating App Startup"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cardWidth = view.bounds.width - 40
        layout.itemSize = CGSize(width: cardWidth, height: 220)
        layout.minimumLineSpacing = -80
        layout.sectionInset = .zero

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black
        cv.showsVerticalScrollIndicator = false
        cv.register(
            CardCollectionViewCell.self,
            forCellWithReuseIdentifier: CardCollectionViewCell.identifier
        )
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        view.addSubview(titleLabel)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),

            collectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 20
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Asegurar que la barra de navegación esté visible
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - UICollectionViewDataSource
extension CardsStackViewController: UICollectionViewDataSource {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }

    func collectionView(
        _ cv: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = cv.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.identifier,
            for: indexPath
        ) as? CardCollectionViewCell else {
            fatalError("Unable to dequeue CardCollectionViewCell")
        }
        cell.configure(with: projects[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CardsStackViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selected = projects[indexPath.item]
        let detailVC = ProjectDetailViewController(project: selected)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
