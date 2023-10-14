//
//  ItunesViewController.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit

//MARK: - Protocols

protocol ItunesViewControllerInput {
    var output: ItunesViewControllerOutput? { get set }
    func update()
}

protocol ItunesViewControllerOutput {
    func getRowsCount() -> Int
    func getCustomModel() -> [CustomItunesModel]?
    func searchTrack(search: String)
    func checkWordsCount(text: String) -> Bool
    func startPlaying(at indexPath: IndexPath)
}

//MARK: - ItunesViewController

final class ItunesViewController: UIViewController {
    
    //MARK: - Properties
    
    var output: ItunesViewControllerOutput?
    
    //MARK: - UI Elements
    
    private lazy var musicTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .clear
        view.register(ItunesTableViewCell.self, forCellReuseIdentifier: Constants.tableIdentifier)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = Constants.placeholder
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.searchTrack(search: Constants.baseRequest)
        setupViews()
        
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        view.addSubview(searchBar)
        view.addSubview(musicTableView)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        musicTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    private func alert(title: String, message: String, actionTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - Extension UITableViewDataSource

extension ItunesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = output?.getRowsCount() ?? 0
        rowsCount == 0 ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Constants.tableIdentifier, for: indexPath) as? ItunesTableViewCell
        guard let model = output?.getCustomModel()?[indexPath.row] else { return UITableViewCell() }
        cell?.configure(model: model)
        return cell ?? UITableViewCell()
    }
}


//MARK: - Extension UITableViewDelegate

extension ItunesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.startPlaying(at: indexPath)
    }
}


//MARK: - Extension UISearchBarDelegate

extension ItunesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, let output = output else { return }
        
        if output.checkWordsCount(text: text) {
            output.searchTrack(search: text)
            update()
        } else {
            alert(title: Constants.titleAlert, message: Constants.messageAlert, actionTitle: Constants.titleAction)
        }
    }
}

//MARK: - Extension ItunesViewControllerInput

extension ItunesViewController: ItunesViewControllerInput {
    
    func update() {
        DispatchQueue.main.async { self.musicTableView.reloadData() }
    }
}
