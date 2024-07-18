//
//  Cell.swift
//  CellularFilling
//
//  Created by Станислава on 18.07.2024.
//

import UIKit


class Cell: UITableViewCell {
    static let reuseIdentifier = "Cell"
    
    private lazy var contentBackgroundView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    private lazy var iconImageView = UIImageView()
    let iconLabel = UILabel()
    
    private var firstColor = UIColor.clear
    private var secondColor = UIColor.clear
    private var icon = ""
        
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(contentBackgroundView)
        backgroundColor = .clear
        
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.backgroundColor = .white
        contentBackgroundView.layer.cornerRadius = 8
        
        contentBackgroundView.addSubview(titleLabel)
        contentBackgroundView.addSubview(subtitleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            titleLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 72),
            
            subtitleLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 43),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .black
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .black
        
        setupIconImageView()
    }
    
    override func layoutSubviews() {
        setupIconImageView()
    }
    
    private func setupIconImageView() {
        contentBackgroundView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.layer.cornerRadius = 20
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
       
        iconLabel.text = icon
        iconLabel.font = .systemFont(ofSize: 20)
        iconLabel.textAlignment = .center
        iconImageView.addSubview(iconLabel)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 16),
            
            iconLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
    
    func configure(with type: CellType) {
        // Сделала градиент картинкой, чтобы избежать offscreen rendering
        switch type {
        case .living:
            titleLabel.text = Strings.livingTitle.rawValue
            subtitleLabel.text = Strings.livingSubtitle.rawValue
            icon = Strings.livingIcon.rawValue
            iconImageView.image = Images.living.uiImage
        case .dead:
            titleLabel.text = Strings.deadTitle.rawValue
            subtitleLabel.text = Strings.deadSubtitle.rawValue
            icon = Strings.deadIcon.rawValue
            iconImageView.image = Images.dead.uiImage
        case .life:
            titleLabel.text = Strings.lifeTitle.rawValue
            subtitleLabel.text = Strings.lifeSubtitle.rawValue
            icon = Strings.lifeIcon.rawValue
            iconImageView.image = Images.life.uiImage
        }
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        icon = ""
    }
}
