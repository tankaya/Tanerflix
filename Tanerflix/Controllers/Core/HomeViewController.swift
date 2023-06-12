//
//  HomeViewController.swift
//  Tanerflix
//
//  Created by Taner Kaya on 16.04.2023.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    
    private var headerView: HeroHeaderUIView?
    
    
    //TableView'i kodla yaratmak icin asagidaki gibi bir tanimlama yapiyoruz.
    // homeFeedTable aslinda bizim bu ekranimizdaki TableView'imizi temsil ediyor.
    
    private let homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped) //Apple'in Ayarlar'da kullandigi gibi bir gruplama yaratiyor.
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
            
    }()
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular",  "Upcoming Movies", "Top Rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)  // tableview'i  gostermek icin cok cok onemli
        
        // Delegate'lari tanimlamayi unutma.
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        //TableView'in ustunde bir bosluk yaratmak icin
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        
        //Sol ustteki image'i cagirdik
        configureNavbar()
        
        //getTrendingMovies()
        
        configureHeroHeaderView()
                
        
    }
    
    private func configureHeroHeaderView(){
        
        APICaller.shared.getPopular { [weak self] result in
            switch result {
            case .success(let titles):
                
                let selectedTitle = titles.randomElement()
                
                self?.randomTrendingMovie = selectedTitle
                
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    //table view'in sinirlarinin korunmasini saglayan fonksiyon. bir tur constraint gorevi goruyor.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        
        
    }
    
    /*
    //JSON datayi cagiriyoruz.
    private func getTrendingMovies(){
        //APICaller.shared.getTrendingMovies { _ in //JSON cagirdigimiz hali
        
        APICaller.shared.getTrendingMovies { results in
            switch results {
                
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
                }
            }
            
        } */
        
    
    
    //Sol uste logomuzu koyduk
    private func configureNavbar(){
        var image = UIImage(named: "tanerflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    
}
    
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    //Dikey duzlemde kac adet section'dan olusacagini tanimliyoruz.
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    //Her bir section'da kac adet satir olacagini tanimliyoruz.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
                return UITableViewCell()
            }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTv.rawValue:
            
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.Upcoming.rawValue:
            
            APICaller.shared.getUpcoming { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopRated.rawValue:
            
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
            
            return cell
        }
        
    //Sectionlar arasindaki bosluk miktari
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //tableView'in ustunde ne kadar alanlik bir header olacagini tanimliyoruz.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
            
        }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    
    //Ekrani asagiya indirdikce baslik kismindaki butonlar yok olacak.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
