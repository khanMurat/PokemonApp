//
//  PokemonViewController.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import UIKit
import Alamofire
import AlamofireImage

class PokemonViewController: UIViewController {
   
    //MARK: - UI Elements
    @IBOutlet weak var pokemonTableView: UITableView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - ViewModel
    private var pokemonListViewModel : PokemonListViewModel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        setViewModel()
        fetchPokemonList()
        setupActivityIndicator()
    }
    
    //MARK: - Setup Methods
    private func setViewModel(){
        let apiService = ApiService()
        pokemonListViewModel = PokemonListViewModel(apiService: apiService)
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - Data Fetching
    private func fetchPokemonList(){
        activityIndicator.startAnimating()
        pokemonListViewModel.fetchPokemons {[weak self] result in
            switch result {
            case .success:
                
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.pokemonTableView.reloadData()
                }
            case .failure(let error):
                self?.activityIndicator.stopAnimating()
                self?.showErrorAlert(error: error)
            }
        }
    }
}

//MARK: - TableView Datasource & Delegate

extension PokemonViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: Constants.pokemonCell, for: indexPath) as! PokemonTableViewCell
        let pokemonList = pokemonListViewModel.viewModelForCell(at: indexPath.row)
        
        cell.pokemonName.text = pokemonList.name.capitalized
        
        if let spriteUrl = URL(string: pokemonList.sprites.front_default){
            cell.pokemonImg.af.setImage(withURL: spriteUrl)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPokemon = pokemonListViewModel.viewModelForCell(at: indexPath.row)
        
        let detailViewModel = PokemonDetail(name: selectedPokemon.name, sprites: selectedPokemon.sprites, abilities: selectedPokemon.abilities)
        
        let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
        
        if let detailVC = storyboard.instantiateViewController(withIdentifier: Constants.detailVC) as? DetailViewController {
            
            detailVC.pokeDetail = detailViewModel
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
}
