//
//  DetailViewController.swift
//  Milestone 10-12
//
//  Created by Diana on 15/08/2023.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var pictures: [Picture]!
    var currentPicture: Int!
    
    private lazy var detailImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Change name for picture"
        field.layer.borderWidth = 0.3
        field.layer.cornerRadius = 10
        field.layer.borderColor = CGColor.init(gray: 0.4, alpha: 0.8)
        field.backgroundColor = .systemGray5
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.delegate = self
        configureView()
        guard pictures != nil && currentPicture != nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let path = Helpers.getImageURL(for: pictures[currentPicture].imageName)
        detailImage.image = UIImage(contentsOfFile: path.path)
    }
    
    private func configureView() {
        
        title = pictures[currentPicture].caption
        view.backgroundColor = .lightGray
        view.addSubview(detailImage)
        view.addSubview(titleField)
        
        detailImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        
        titleField.snp.makeConstraints {
            $0.top.equalTo(detailImage.snp.bottom)
            $0.height.equalTo(50)
            $0.left.right.equalToSuperview().inset(12)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        title = textField.text
        pictures[currentPicture].caption = textField.text ?? ""
        Helpers.savePictures(pictures: pictures)
    }
}
