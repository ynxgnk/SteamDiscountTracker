//
//  GamesTableViewCell.swift
//  SteamDiscountsTracker
//
//  Created by Nazar Kopeika on 28.06.2023.
//

import UIKit

class GamesTableViewCell: UITableViewCell {
    static let identifier = "GamesTableViewCell"
    
    private let gamesImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "car")
//        image.clipsToBounds = true
        return image
    }()
    
    private let gamesTitle: UILabel = {
       let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let gamesOriginalPrice: UILabel = {
       let label = UILabel()
        label.text = "Original Price"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let gamesDiscountedPrice: UILabel = {
        let label = UILabel()
        label.text = "Dicounted Price"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .red
        return label
    }()
    
    private let gamesRating: UILabel = {
       let label = UILabel()
        label.text = "Rating"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let gamesFinalPrice: UILabel = {
       let label = UILabel()
        label.text = "Final Price"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gamesImage.frame = CGRect(
            x: 10,
            y: 10,
            width: 140,
            height: 140
        )
        gamesTitle.frame = CGRect(
            x: gamesImage.safeAreaInsets.right+190,
            y: 10,
            width: contentView.frame.size.width,
            height: 20
        )
        gamesOriginalPrice.frame = CGRect(
            x: gamesImage.safeAreaInsets.right+190,
            y: 40,
            width: contentView.frame.size.width,
            height: 20
        )
        gamesDiscountedPrice.frame = CGRect(
            x: gamesImage.safeAreaInsets.right+190,
            y: 70,
            width: contentView.frame.size.width,
            height: 20
        )
        gamesRating.frame = CGRect(
            x: gamesImage.safeAreaInsets.right+190,
            y: 100,
            width: contentView.frame.size.width,
            height: 20
        )
        gamesFinalPrice.frame = CGRect(
            x: gamesImage.safeAreaInsets.right+190,
            y: 130,
            width: contentView.frame.size.width,
            height: 20
        )
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(gamesImage)
//        gamesImage.backgroundColor = .blue
        contentView.addSubview(gamesTitle)
//        gamesTitle.backgroundColor = .red
        contentView.addSubview(gamesOriginalPrice)
//        gamesOriginalPrice.backgroundColor = .orange
        contentView.addSubview(gamesDiscountedPrice)
//        gamesDiscountedPrice.backgroundColor = .black
        contentView.addSubview(gamesRating)
//        gamesRating.backgroundColor = .gray
        contentView.addSubview(gamesFinalPrice)
//        gamesFinalPrice.backgroundColor = .brown
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gamesImage.image = nil
        gamesTitle.text = nil
        gamesRating.text = nil
        gamesOriginalPrice.text = nil
        gamesDiscountedPrice.text = nil
        gamesFinalPrice.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with viewModel: SteamGamesViewModel) {
        gamesTitle.text = viewModel.title
        gamesOriginalPrice.text = "Steam ID: \(viewModel.originalPrice)"
        gamesDiscountedPrice.text = "Discounted: \(viewModel.discountedPrice)"
        gamesRating.text = "Game ID: \(viewModel.rating)"
        gamesFinalPrice.text = "Final Price: \(viewModel.finalPrice)"
        
        if let imageData = viewModel.imageData {
                gamesImage.image = UIImage(data: imageData)
            } else if let url = viewModel.image {
                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.gamesImage.image = image
                        }
                        viewModel.imageData = data
                    }
                }.resume()
            }
    }
}
