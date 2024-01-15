//
//  TableViewCell.swift
//   Projects 13-15
//
//  Created by Diana on 05/01/2024.
//

import SnapKit
import UIKit

class CollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var titleCountry: UILabel = {
       let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 20)
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(flagURL: String, countryName: String) {
        if let imageURL = URL(string: flagURL) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
        titleCountry.text = countryName
    }
}

private extension CollectionViewCell {
    func initialize() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.leading.trailing.equalTo(contentView).inset(10)
        }
        contentView.addSubview(titleCountry)
        
        titleCountry.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(imageView)
        }
    }
}
