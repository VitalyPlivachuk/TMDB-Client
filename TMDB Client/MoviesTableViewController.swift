//
//  MoviesTableViewController.swift
//  TMDB Client
//
//  Created by Vitaly Plivachuk on 27.06.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController, UISearchBarDelegate, UINavigationControllerDelegate{
    
    var moviesSearchResult = [movieInSearchResults]()
    var movieTitleSearchBar = UISearchBar()
    var genresStruct = [Double:String]()
    
    override func viewDidLoad() {
        fillGenresDictionary()
        super.viewDidLoad()
        movieTitleSearchBar.placeholder = "Search movies"
        movieTitleSearchBar.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Updating...")
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        if let navigationController = self.navigationController {
            if let topItem = navigationController.navigationBar.topItem {
                topItem.titleView = movieTitleSearchBar
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationViewController = segue.destination as! MovieDetailsViewController
                
                if let movieTitle = moviesSearchResult[indexPath.row].title{
                    destinationViewController.movieTitle = movieTitle
                }
                
                if let releaseDate = moviesSearchResult[indexPath.row].releaseDate{
                    destinationViewController.releaseDate = formattedReleaseDate(releaseDate:releaseDate)!
                }
                
                if let vote = moviesSearchResult[indexPath.row].vote{
                    destinationViewController.vote = String(format: "%.1f", vote)
                }
                
                if let poster = moviesSearchResult[indexPath.row].posterImage{
                    destinationViewController.poster = poster
                }
                
                if let overview = moviesSearchResult[indexPath.row].overview{
                    destinationViewController.overview = overview
                }
                
                if let voteCount = moviesSearchResult[indexPath.row].voteCount{
                    destinationViewController.voteCount = String(format: "%.0f", voteCount)
                }
                
                if let genres = moviesSearchResult[indexPath.row].genres{
                    for genre_id in genres{
                        if let genre = genresStruct[genre_id] {
                            destinationViewController.genre.append("\(genre) ")
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moviesSearchResult.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        if let title = moviesSearchResult[indexPath.row].title{
            cell.title?.text = title
        }
        if let year = moviesSearchResult[indexPath.row].releaseDate{
            cell.year?.text = formattedReleaseDate(releaseDate:year)
        }
        if let vote = moviesSearchResult[indexPath.row].vote{
            cell.vote?.text = String(format: "%.1f", vote)
        }
        if let poster = moviesSearchResult[indexPath.row].posterImage{
            cell.poster?.image = poster
        }
        // Configure the cell...
        return cell
    }
    
    
    func formattedReleaseDate(releaseDate: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: releaseDate)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print(searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovie(name: searchBar.text!)
        searchBar.endEditing(true)
        refreshControl?.beginRefreshing()
    }
    
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        print("refresh")
        searchMovie(name: movieTitleSearchBar.text!)
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
        
    }
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    func searchMovie(name:String) {
        moviesSearchResult = []
        let urlPath = "https://api.themoviedb.org/3/search/movie?api_key=27d48b387d2634ab02cb81ad091bdbef&language=en-US&query=\(name.replacingOccurrences(of: " ", with: "%20"))&page=1&include_adult=true"
        guard let endpoint = URL(string: urlPath) else {
            print("Error creating endpoint")
            return
        }
        URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {
                    throw JSONError.ConversionFailed
                }
                print(json)
                if let results = (json["results"] as? [[String: AnyObject]]) {
                    for result in results{
                        let movie = movieInSearchResults(parsedJson: result)
                        self.moviesSearchResult.append(movie)
                    }
                }
                DispatchQueue.main.async(execute: {self.do_table_refresh()})
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            }.resume()
        //DispatchQueue.main.async(execute: {self.do_table_refresh()})
    }
    
    func do_table_refresh()
    {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func fillGenresDictionary() {
        let urlPath = "https://api.themoviedb.org/3/genre/movie/list?api_key=27d48b387d2634ab02cb81ad091bdbef&language=en-US"
        guard let endpoint = URL(string: urlPath) else {
            print("Error creating endpoint")
            return
        }
        URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {
                    throw JSONError.ConversionFailed
                }
                print(json)
                if let results = (json["genres"] as? [[String: AnyObject]]) {
                    for result in results{
                        if let id  = result["id"] as? Double{
                            if let genre = result["name"] as? String{
                                self.genresStruct[id] = genre
                            }
                        }
                    }
                }
                DispatchQueue.main.async(execute: {self.do_table_refresh()})
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            }.resume()
    }
    
}
