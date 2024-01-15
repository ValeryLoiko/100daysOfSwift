//
//  ViewController.swift
//   Projects 13-15
//
//  Created by Diana on 05/01/2024.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private properties
    private var collectionView: UICollectionView!
    private var countryInfoArray = [CountryInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        APIManager.shared.fetchData { result in
            switch result {
            case .success(let countries):
                print("rabotaet")
                self.updateUI(with: countries)
            case .failure(let error):
                print("Ошибка при загрузке данных: \(error.localizedDescription)")
            }
            
        }
        print("viewDidLoad")
    }
    
    private func updateUI(with countries: Countries) {
        for country in countries {
            let countryInfo = CountryInfo(
                flagURL: country.flags.png,
                countryName: country.name.common,
                area: country.area,
                population: country.population,
                region: country.region,
                languages: country.languages,
                timezones: country.timezones
            )

            countryInfoArray.append(countryInfo)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

private extension ViewController {
    func initialize() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray4
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        title = "Countries and Flags"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func showDetailsForCountry(at index: Int) {
        let selectedCountry = countryInfoArray[index]
        let detailVC = DetailViewController()
        detailVC.selectedCountry = selectedCountry
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailsForCountry(at: indexPath.row)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("countryInfoArray \(countryInfoArray.count)")
        return countryInfoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let countryInfo = countryInfoArray[indexPath.item]
        print("cell \(countryInfo.flagURL)")

        cell.configure(flagURL: countryInfo.flagURL, countryName: countryInfo.countryName)
        return cell
    }
}
