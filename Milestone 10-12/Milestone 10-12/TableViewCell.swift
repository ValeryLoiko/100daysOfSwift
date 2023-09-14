//
//  TableViewCell.swift
//  Milestone 10-12
//
//  Created by Diana on 12/08/2023.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    lazy var cellImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        contentView.addSubview(image)
        return image
    }()
    lazy var title: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureConstraints()
    }
    
    private func configureConstraints() {
        cellImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        title.snp.makeConstraints {
            $0.leading.equalTo(cellImageView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
