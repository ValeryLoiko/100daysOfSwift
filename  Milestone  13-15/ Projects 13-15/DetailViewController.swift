//
//  DetailViewController.swift
//   Projects 13-15
//
//  Created by Diana on 12/01/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let countryName = UILabel()
    private let countryFlag = UIImageView()
    private let areaLabel = UILabel()
    private let populationLabel = UILabel()
    private let regionLabel = UILabel()
    private let languagesLabel = UILabel()
    private let timezonesLabel = UILabel()
    
    
    var selectedCountry: CountryInfo? {
        didSet {
            print(Country.self)
            if let country = selectedCountry {
                updateUI(with: country)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedCountry)
        
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray4
        
        // Country Flag
        view.addSubview(countryFlag)
        countryFlag.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100) // Укажите желаемый размер
        }
        
        // Country Name
        view.addSubview(countryName)
        countryName.snp.makeConstraints { make in
            make.top.equalTo(countryFlag.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        // Area Label
        view.addSubview(areaLabel)
        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(countryName.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Population Label
        view.addSubview(populationLabel)
        populationLabel.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Region Label
        view.addSubview(regionLabel)
        regionLabel.snp.makeConstraints { make in
            make.top.equalTo(populationLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Languages Label
        view.addSubview(languagesLabel)
        languagesLabel.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Timezones Label
        view.addSubview(timezonesLabel)
        timezonesLabel.snp.makeConstraints { make in
            make.top.equalTo(languagesLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func updateUI(with country: CountryInfo) {
        countryName.text = country.countryName
        areaLabel.text = "Area: \(country.area)"
        populationLabel.text = "Population: \(country.population)"
        regionLabel.text = "Region: \(country.region.rawValue)"
        
        // Обработка языков
        if let languages = country.languages {
            let languageStrings = languages.compactMap { $0.value }.joined(separator: ", ")
            languagesLabel.text = "Languages: \(languageStrings)"
        }
        
        
        timezonesLabel.text = "Timezones: \(country.timezones.joined(separator: ", "))"
        
        if let url = URL(string: country.flagURL) {
             DispatchQueue.global().async {
                 if let imageData = try? Data(contentsOf: url),
                    let image = UIImage(data: imageData) {
                     DispatchQueue.main.async {
                         self.countryFlag.image = image
                     }
                 }
             }
         }
    }
    
}
