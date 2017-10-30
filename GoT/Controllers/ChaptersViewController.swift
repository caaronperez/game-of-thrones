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
 
 var savedChapters: [[String: Any?]] = [[:]]

class ChaptersViewController: UIViewController {

    @IBOutlet weak var imageSlider: UIImageView!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var editable: Bool? = false;
    var series: [Any?] = []
    
    
    var got: Serie? {
        didSet {
           // tableView.reloadData()
        }
    }
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        got = Serie()
        series.append(got)
        got?.delegate = self
        got?.getData(imdbID: "tt0944947", closure: {
            //tableView.reloadData()
        })
        
        imageSlider.contentMode = .scaleAspectFill
        imageSlider.image = #imageLiteral(resourceName: "slide1")
        imageLogo.image = #imageLiteral(resourceName: "logo3")
        
        
        tableView.isEditing = editable!
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "TableViewCellController" , bundle: nil), forCellReuseIdentifier: "TableViewCellController")
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
 

 
extension ChaptersViewController: UITableViewDataSource {
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let n = got?.seasons?["\(section+1)"]?.episodes?.count{
            return n
        }else{
            return 0;
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellController", for: indexPath) as! TableViewCellController
        
        if let title = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.title] as! String? {
            cell.titleLabel.text = title
        }
        
        if let rating = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.imdbRating] as! String? {
            cell.ratingLabel.text = "iMDB rating: \(rating)"
            cell.ratingProgress.rating = Double(rating)!
        }
        
        if let episode = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.epidose] as! String? {
            cell.episodeLabel.text = "Episode: \(episode)"
        }
        
        if let release = got?.seasons?["\(indexPath.section)"]?.episodes?[indexPath.row][oMDBAPI.released] as! String? {
            cell.releaseLabel.text = "Date released: \(release)"
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
        return "Season \(section+1)"
    }
}

 extension ChaptersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if editable! == false {
            performSegue(withIdentifier: segueIdentifiers.presentChapterFromAll, sender: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let shareAction  = UITableViewRowAction(style: .normal, title: "Save") { (rowAction, indexPath) in
            
            self.displayShareSheet(indexPath: indexPath as NSIndexPath)
        }
        
        let deleteAction  = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
            self.tableView.setEditing(false, animated: true)
            
        }
        shareAction.backgroundColor = UIColor.blue
        return [shareAction,deleteAction]
    }
    
    func displayShareSheet(indexPath: NSIndexPath)
    {
       
        
    }
    
    @IBAction func didPressEdit(_ sender: Any) {
        editable = editable! ? false : true
        editButton.title = editable! ? "Done" : "Edit"
        self.navigationController?.isToolbarHidden = editable! ? false : true
        tableView.setEditing(editable!, animated: true)
        tableView.allowsMultipleSelection = true
    }
    
    @IBAction func didPressDelete(_ sender: Any) {
        
        if let indexPaths = tableView.indexPathsForSelectedRows {
            
            tableView.deleteRows(at: indexPaths, with: .automatic)
            tableView.reloadData()
            for indexPath in indexPaths {
                self.got?.seasons?["\(indexPath.section)"]?.episodes![indexPath.row].removeAll()
            }
        }

        editable = editable! ? false : true
        editButton.title = editable! ? "Done" : "Edit"
        self.navigationController?.isToolbarHidden = editable! ? false : true
        tableView.setEditing(editable!, animated: true)
    }
    
    
    @IBAction func didPressSave(_ sender: Any) {
        editable = editable! ? false : true
        editButton.title = editable! ? "Done" : "Edit"
        self.navigationController?.isToolbarHidden = editable! ? false : true
        tableView.setEditing(editable!, animated: true)
        
        if let indexPaths = tableView.indexPathsForSelectedRows {
            for indexPath in indexPaths {
                savedChapters.append(self.got?.seasons?["\(indexPath.section)"]?.episodes![indexPath.row] as! [String : Any?])
            }
        }
        
    }
    
 }
 
 
 extension ChaptersViewController {
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if editable! == false {
            if segue.identifier == segueIdentifiers.presentChapterFromAll {
                if let nextViewController = segue.destination as? ChapterViewController, let idChapter = got?.seasons?["\((tableView.indexPathForSelectedRow?.section)!+1)"]?.episodes?[(tableView.indexPathForSelectedRow?.row)!][oMDBAPI.imdbID] {
                    nextViewController.episodeID = idChapter as? String
                }
            }
        }else{
            
        }
    }
 }
 
 extension ChaptersViewController: NetworkManagerDelegateSerie {
    func didDownloadPost(postArray: Serie) {
        got = postArray
        tableView.reloadData()
    }
 }
 
