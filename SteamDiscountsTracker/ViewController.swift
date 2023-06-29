//
//  ViewController.swift
//  SteamDiscountsTracker
//
//  Created by Nazar Kopeika on 28.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let gamesTable: UITableView = {
       let table = UITableView()
        table.register(GamesTableViewCell.self,
                       forCellReuseIdentifier: GamesTableViewCell.identifier)
        return table
    }()
    
    private var games = [GameInfo]()
    private var viewModels = [SteamGamesViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(gamesTable)
        gamesTable.delegate = self
        gamesTable.dataSource = self
        fetchSteamData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gamesTable.frame = view.bounds
    }
    
    private func fetchSteamData() {
        APICaller.shared.getSteamData { [weak self] result in
            switch result {
            case .success(let games):
                self?.games = games
                self?.viewModels = games.compactMap({
                    SteamGamesViewModel(
                        title: $0.title,
                        originalPrice: $0.steamAppID,
                        discountedPrice: $0.salePrice,
                        rating: $0.gameID,
                        finalPrice: $0.retailPrice ?? "NO",
                        image: URL(string: $0.thumb))
                })
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GamesTableViewCell.identifier, for: indexPath) as? GamesTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

