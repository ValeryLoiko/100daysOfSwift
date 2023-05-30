//
//  DetailViewController.swift
//  Project1
//
//  Created by Walery Łojko on 11/11/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 //       title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        if let loadImage = selectedImage {
            imageView.image = UIImage(named: loadImage)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
