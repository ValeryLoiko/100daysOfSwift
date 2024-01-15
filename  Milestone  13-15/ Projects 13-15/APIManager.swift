//
//  APIManager.swift
//   Projects 13-15
//
//  Created by Diana on 05/01/2024.
//

import UIKit

class APIManager {
    static let shared = APIManager()
    private let urlString = "https://restcountries.com/v3.1/all/"
    
    private init() {}
    
    func fetchData(completion: @escaping (Result<Countries, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let countries = try decoder.decode(Countries.self, from: data)
                    completion(.success(countries))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
    }
}


//    // Функция для загрузки данных о странах
//    func fetchCountriesData(completion: @escaping (Result<Countries, Error>) -> Void) {
//        let urlString = "https://restcountries.com/v3.1/all/"
//
//        // Создание URL
//        if let url = URL(string: urlString) {
//            // Создание URLSession
//            let session = URLSession.shared
//
//            // Создание задачи запроса
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//
//                // Проверка данных
//                if let responseData = data {
//                    do {
//                        // Попытка декодирования данных
//                        let countries = try JSONDecoder().decode(Countries.self, from: responseData)
//                        completion(.success(countries))
//                    } catch {
//                        completion(.failure(error))
//                    }
//                }
//            }
//
//            // Запуск задачи
//            task.resume()
//        } else {
//            // Обработка некорректного URL
//            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])
//            completion(.failure(error))
//        }
//    }

// Использование функции для загрузки данных
//    fetchCountriesData { result in
//        switch result {
//        case .success(let countries):
//            // Обработка данных о странах
//            print("Получены данные о \(countries.count) странах")
//            // Здесь можно выполнять операции с данными о странах
//            // Например, выводить информацию о каждой стране
//            
//        case .failure(let error):
//            // Обработка ошибки загрузки данных
//            print("Ошибка при загрузке данных: \(error)")
//        }
//    }

