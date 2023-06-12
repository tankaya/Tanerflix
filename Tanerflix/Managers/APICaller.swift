//
//  APICaller.swift
//  Tanerflix
//
//  Created by Taner Kaya on 18.04.2023.
//

import Foundation

struct Constants {
    
    static let API_KEY = "ffa67b620496655f3ce85d419b18e1fc"
    
    static let baseURL = "https://api.themoviedb.org"
    
    static let YoutubeAPI_KEY = "AIzaSyBsOInhiomulSRfcthYeNVM8AJemFgfenU"
    
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    
    static let shared = APICaller()
    
    //func getTrendingMovies(completion: @escaping (String) -> Void){ // sadece JSON cektigimiz hali
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.results))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.results))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.results))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getUpcoming(completion: @escaping (Result<[Title], Error>) -> Void){
        
    
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.results))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    
    
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.results))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.results))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
        
        
    }
    
    // BURADAKI FONKSIYON YAPISINI KESIN CALIS.
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return
            
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.results))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
        
    }
    
    func getMovie(with query:String, completion: @escaping (Result<VideoElement, Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do{
                /*let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)*/ // Modelleri olusturmadan once JSON'i cekip kontrol ettik.
                
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                //print(results.results[0].original_name) // results arrayindeki ilk elemanin ismini getirecek.
                completion(.success(results.items[0]))
                
                
            }catch{
                //print(error.localizedDescription) //JSON cagirdigimiz eski hali
                
                //completion(.failure(error)) // APIError'u olusturmadan onceki hali
                
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
        
    }
}



