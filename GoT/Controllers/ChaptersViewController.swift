//
//  FirstViewController.swift
//  GoT
//
//  Created by MCS Devices on 10/26/17.
//  Copyright © 2017 Mobile Consulting Solutions. All rights reserved.
//

import UIKit

struct segueIdentifiers {
    static let presentChapterFromAll = "presentChapterFromAll"
    static let presentChapterFromSaved = "presentChapterFromSaved"
    static let presentImageFromChapter = "presentImageFromChapter"
    
}

class ChaptersViewController: UIViewController {

    @IBOutlet weak var imageSlider: UIImageView!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var editable: Bool? = false;
    var got: Serie?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        got = Serie(imdbID: "tt0944947")
        imageSlider.contentMode = .scaleAspectFill
        imageSlider.image = #imageLiteral(resourceName: "slide1")
        imageLogo.image = UIImage(named: "logo3")
        tableView.isEditing = editable!
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "TableViewCellController" , bundle: nil), forCellReuseIdentifier: "TableViewCellController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ChaptersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          //  got.seasons.episodes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let n = got?.seasons?["\(section)"]?.episodes?.count{
            return n
        }else{
            return 0;
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellController", for: indexPath) as! TableViewCellController
        
        if let title = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.title] as! String?, let rating = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.imdbRating] as! String?, let episode = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.epidose] as! String?, let release = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.released] as! String? {
            cell.episodeLabel.text = "Episode: \(episode)"
            cell.titleLabel.text = title
            cell.releaseLabel.text = "Date released: \(release)"
            cell.ratingLabel.text = "iMDB rating: \(rating)"
            cell.ratingProgress.rating = Double(rating)!
            
        }
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.init(red: 0.9, green: 0.2, blue: 0.5, alpha: 0.2) :  UIColor.white
        return cell
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let n = got?.seasons?.count{
            return n
        }else{
            return 0;
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (got?.seasons?["\(section)"]?.title)
    }
}

extension ChaptersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers.presentChapterFromAll, sender: nil)
    }
}
