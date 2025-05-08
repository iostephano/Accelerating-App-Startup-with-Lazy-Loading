//
//  ProjectDetailViewController.swift
//  Accelerating App Startup with Lazy Loading
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

class ProjectDetailViewController: UIViewController {
    private let project: Project

    init(project: Project) {
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let activityIndicator: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView(style: .large)
        a.color = .lightGray
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()

    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading preview..."
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.alpha = 0
        return iv
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // Mostrar navegación y título
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = project.title

        // Agregar vistas
        [activityIndicator, loadingLabel, imageView, descriptionLabel].forEach {
            view.addSubview($0)
        }

        // Constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 12),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalToConstant: 180),

            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Simular carga diferida
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.loadingLabel.isHidden = true

            self.imageView.image = UIImage(named: self.project.previewImageName)
            self.descriptionLabel.text = self.project.description

            UIView.animate(withDuration: 0.4) {
                self.imageView.alpha = 1
                self.descriptionLabel.alpha = 1
            }
        }
    }
}
