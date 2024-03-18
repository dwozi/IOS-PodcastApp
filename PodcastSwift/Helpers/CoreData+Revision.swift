//
//  CoreData+Revision.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 18.03.2024.
//

import UIKit
import CoreData
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 let context = appDelegate.persistentContainer.viewContext
struct CoreDataController{
    static func addCoreData(model:PodcastsData,podcast:Podcast){
        model.feedUrl = podcast.feedUrl
        model.imageUrl = podcast.imageUrl
        model.artistName = podcast.artistName
        model.trackName = podcast.trackName
        appDelegate.saveContext()
    }
    
    static func deleteCoreData(values: [PodcastsData],podcast : Podcast){
        let value = values.filter({$0.feedUrl == podcast.feedUrl})
        context.delete(value.first!)
        appDelegate.saveContext()
    }
    
    static func fetchCoreData(fetchRequest: NSFetchRequest<PodcastsData>,completion: @escaping([PodcastsData]) -> Void){
        do {
            let result = try context.fetch(fetchRequest)
            completion(result)
        } catch  {
            
        }
    }
}
