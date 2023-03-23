//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - UIElements
    var pokeDetail : PokemonDetail?
    
    
    @IBOutlet weak var pokeDetailImg: UIImageView!
    
    @IBOutlet weak var pokeDetailName: UILabel!
    
    @IBOutlet weak var abiltyTableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageURL = pokeDetail?.sprites.front_default {
            pokeDetailImg.af.setImage(withURL: URL(string: imageURL)!)
        }
        
        pokeDetailName.text? = pokeDetail?.name.capitalized ?? ""
        abiltyTableView.delegate = self
        abiltyTableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated:true)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor(named:Constants.customColor)
    }
    

}
    //MARK: - AbiltyTableView Delegate&DataSource
extension DetailViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokeDetail?.abilities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.abilityCell, for: indexPath)
        
        cell.textLabel?.text = pokeDetail?.abilities[indexPath.row].ability.name
        
        return cell
        
    }
}
