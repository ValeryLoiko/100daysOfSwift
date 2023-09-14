//
//  ViewController.swift
//  Milestone 10-12
//
//  Created by Diana on 11/08/2023.
//

import UIKit
import SnapKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pictures = [Picture]()
    var popping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
        self.tableView.rowHeight = 100
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        configureView()
        
        DispatchQueue.global().async { [weak self] in
            self?.pictures = Helpers.loadPictures()
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // coming back from DetailViewController, caption might have been changed
        if popping {
            tableView.reloadData()
        }
        popping = false
    }
    
    private func configureView() {
        title = "People's names"
        view.backgroundColor = .systemGray
    }
    
    @objc func addPicture() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let ac = UIAlertController(title: "Source", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Photos", style: .default, handler: { [weak self] _ in
                self?.showPicker(fromCamera: false)
            }))
            ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
                self?.showPicker(fromCamera: true)
            }))
            ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(ac, animated: true)
        } else {
            showPicker(fromCamera: false)
        }
    }
    
    func showPicker(fromCamera: Bool) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if fromCamera {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        DispatchQueue.global().async { [weak self] in
            let imageName = UUID().uuidString
            
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: Helpers.getImageURL(for: imageName))
            }
            
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
                
                let ac = UIAlertController(title: "Caption?", message: "Enter a caption for this image", preferredStyle: .alert)
                ac.addTextField()
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak ac] _ in
                    guard let caption = ac?.textFields?[0].text else { return }
                    self?.savePicture(imageName: imageName, caption: caption)
                }))
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                self?.present(ac, animated: true)
            }
        }
    }
    
    func savePicture(imageName: String, caption: String) {
        let picture = Picture(imageName: imageName, caption: caption)
        pictures.insert(picture, at: 0)
        
        DispatchQueue.global().async { [weak self] in
            if let pictures = self?.pictures {
                Helpers.savePictures(pictures: pictures)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.backgroundColor = .systemGray
        
        cell.title.text = pictures[indexPath.row].caption
        let path = Helpers.getImageURL(for: pictures[indexPath.row].imageName)
        cell.cellImageView.image = UIImage(contentsOfFile: path.path)
        cell.cellImageView.layer.borderColor = UIColor.black.cgColor
        cell.cellImageView.layer.borderWidth = 0.1
        cell.cellImageView.layer.cornerRadius = 5
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.pictures = pictures
        detailViewController.currentPicture = indexPath.row
        popping = true
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pictures.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Helpers.savePictures(pictures: pictures)
        }
    }
}

