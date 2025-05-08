//
//  CardCollectionViewCell.swift
//  Accelerating App Startup with Lazy Loading
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardCollectionViewCell"

    // MARK: - UI Elements

    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemChromeMaterialDark)
        let v = UIVisualEffectView(effect: blur)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = true
        return v
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let dateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let previewImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(blurView)
        blurView.contentView.addSubview(titleLabel)
        blurView.contentView.addSubview(dateLabel)
        blurView.contentView.addSubview(previewImageView)

        NSLayoutConstraint.activate([
            // blurView fills the cell
            blurView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // Title on top-left, leaving space for preview
            titleLabel.topAnchor.constraint(equalTo: blurView.contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(
                equalTo: previewImageView.leadingAnchor,
                constant: -16
            ),

            // Date below title
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(
                equalTo: previewImageView.leadingAnchor,
                constant: -16
            ),

            // Preview image on the right
            previewImageView.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -16),
            previewImageView.widthAnchor.constraint(equalToConstant: 120),
            previewImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(with project: Project) {
        titleLabel.text = project.title
        dateLabel.text = project.lastModified.friendlyString
        previewImageView.image = UIImage(named: project.previewImageName)
    }
}
