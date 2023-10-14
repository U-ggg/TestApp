//
//  PlayerViewController.swift
//  TestApp
//
//  Created by sidzhe on 13.10.2023.
//

import UIKit

//MARK: - Protocols

protocol PlayerViewControllerInput {
    var output: PlayerViewControllerOutput? { get set }
}

protocol PlayerViewControllerOutput {
    func playTrack(track: String)
    func playPause()
    func stopPlaying()
}

//MARK: - PlayerViewController

final class PlayerViewController: UIViewController, PlayerViewControllerInput {
    
    //MARK: - Properties
    
    var output: PlayerViewControllerOutput?
    private var model: CustomItunesModel?
    
    //MARK: - UI Elements
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 34, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Constants.pauseImage, for: .normal)
        button.setBackgroundImage(Constants.playImage, for: .selected)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(tapPlay), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Constants.backwardImage, for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(tapAnyButtons), for: .touchUpInside)
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Constants.forwardImage, for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(tapAnyButtons), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Inits
    
    init(customItunesModel: CustomItunesModel) {
        super.init(nibName: nil, bundle: nil)
        self.artistLabel.text = customItunesModel.artistName
        self.songLabel.text = customItunesModel.trackName
        self.logoImage.image = customItunesModel.image
        self.model = customItunesModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        output?.playTrack(track: model!.trackUrl)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output?.stopPlaying()
        
    }
    
    //MARK: - Setup views
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        labelStackView.addArrangedSubview(songLabel)
        labelStackView.addArrangedSubview(artistLabel)
        
        view.addSubview(logoImage)
        view.addSubview(labelStackView)
        view.addSubview(playButton)
        view.addSubview(backButton)
        view.addSubview(forwardButton)
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(50)
            make.size.equalTo(view.frame.width / 1.5)
            make.centerX.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).inset(-50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        playButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerY.equalTo(playButton.snp.centerY)
            make.leading.equalTo(playButton.snp.trailing).inset(-40)
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerY.equalTo(playButton.snp.centerY)
            make.trailing.equalTo(playButton.snp.leading).inset(-40)
        }
    }
    
    //MARK: - Buttons targets
    
    @objc private func tapPlay(_ sender: UIButton) {
        sender.isSelected.toggle()
        output?.playPause()
    }
    
    @objc private func tapAnyButtons() {
        print("Данный функционал находится в разработке")
    }
}

