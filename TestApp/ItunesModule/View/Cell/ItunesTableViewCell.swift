//
//  ItunesTableViewCell.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit
import SnapKit

final class ItunesTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    //MARK: - PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        icon.image = nil
        
    }
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        
        icon.addSubview(activityIndicator)
        
        stackView.addArrangedSubview(songLabel)
        stackView.addArrangedSubview(nameLabel)
        
        contentView.addSubview(icon)
        contentView.addSubview(stackView)
        
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(60)
            make.leading.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalTo(icon.snp.trailing).inset(-16)
            make.trailing.equalToSuperview().inset(26)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Configure
    
    public func configure(model: CustomItunesModel) {
        
        activityIndicator.startAnimating()
        songLabel.text = model.trackName
        nameLabel.text = model.artistName
        activityIndicator.stopAnimating()
        icon.image = model.image
    }
}
