//
//  ChapterViewController.swift
//  GoT
//
//  Created by MCS Devices on 10/29/17.
//  Copyright © 2017 Mobile Consulting Solutions. All rights reserved.
//

import UIKit
import Cosmos
import AlamofireImage

class ChapterViewController: UIViewController {

    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var metascoreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var imdbidLabel: UILabel!
    @IBOutlet weak var imdbVotes: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var ratingCosmos: CosmosView!
    var chapter: Chapter?
    var episodeID: String?
    var row: String?
    var section: String?
    var networkRequests: [Any?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imdbID = episodeID {
            chapter = Chapter(imdbID: imdbID)
            chapter?.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChapterViewController: NetworkManagerImage {
    func didDownloadImage(image: UIImage) {
        posterImage.image = image
    }
}

extension ChapterViewController: NetworkManagerDelegateChapter {
 
    func didDownloadPost(postArray: Chapter) {
        seasonLabel.text = postArray.seasonChapter
        yearLabel.text = postArray.yearChapter
        episodeLabel.text = postArray.episode
        runtimeLabel.text = postArray.runtime
        ratedLabel.text = postArray.reated
        metascoreLabel.text = postArray.metascore
        plotLabel.text = postArray.plot
        imdbidLabel.text = postArray.imdbID
        imdbVotes.text = postArray.imdbVotes
        countryLabel.text = postArray.country
        languageLabel.text = postArray.language
        awardsLabel.text = postArray.awards
        typeLabel.text = postArray.type
        writerLabel.text = postArray.writer
        genreLabel.text = postArray.genreChapter
        directorLabel.text = postArray.director
        actorsLabel.text = postArray.actors
        if let rating = Double(postArray.imdbRating!){
            ratingCosmos.rating = rating
        }
        if let name = postArray.titleChapter {
            navigationItem.title = "\(name)"
        } else {
            navigationItem.title = "Details"
        }
        
        posterImage.layer.cornerRadius = posterImage.frame.size.width/2
        posterImage.clipsToBounds = true
        
        let pictureTap = UITapGestureRecognizer(target: self,action: #selector(self.imageTapped(_:)))
        posterImage.addGestureRecognizer(pictureTap)
        
        let myNetworkManager = NetworkManager()
        networkRequests.append(myNetworkManager)
        myNetworkManager.image = self
        if let urlImage = postArray.poster {
            myNetworkManager.getImage(imgUrl: urlImage)
        }
    }
}

extension ChapterViewController {
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer){
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .white
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullScreenImage(_ sender: UITapGestureRecognizer){
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
        
    }
}

extension ChapterViewController: UIActionSheetDelegate {
    @IBAction func showAlert(sender: AnyObject) {
        let alert = UIAlertController(title: "Select an option", message: "Choose between delete or save a chapter locally", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Save", style: .default , handler:{ (UIAlertAction)in
            //SavedEpisodes.sharedInstance.saveChapter(chapter: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            //SavedEpisodes.sharedInstance.deleteChapter(chapter: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
            print("Bye bitch")
        }))
        
        self.present(alert, animated: true, completion: {
            print("Complete")
        })
    }
}
