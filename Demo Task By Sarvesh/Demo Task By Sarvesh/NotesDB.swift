//
//  NotesDB.swift
//  Demo Task By Sarvesh
//
//  Created by Nilesh Vernekar on 11/04/21.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation

//public class CurrentNotes: NSManagedObject {
//
//}
//
//extension CurrentNotes {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentNotes> {
//        return NSFetchRequest<CurrentNotes>(entityName: "ProfileCache")
//    }
//
//    @NSManaged public var data: Data?
//
//}
class NotesDB: NSObject {
    
    
private var cacheManager: CacheManager?
   
   init(modelName: String,entityName: String) {
       cacheManager = CacheManager(modelName: modelName, entityName: entityName)
   }
    
      func readNotesFromCache<T: Codable>() -> T? {
         
         if let notes: [CurrentNotes] = cacheManager?.retrieveData() {
             if let notesModel = notes.first {
                 do {
                     return try JSONDecoder().decode(T.self, from: notesModel.data ?? Data())
                 } catch _ {
                     return nil
                 }
             }
             
         }
         return nil
     }
    fileprivate func insertNotes(notesListModel: notesDic) -> Bool {
           let encoder =  JSONEncoder()
           
           do {
               let cache = CurrentNotes(context: (cacheManager?.getManagedObject())!)
               let data = try encoder.encode(notesListModel)
               cache.data = data
               
               return cacheManager?.saveContextIfChanged() == true ? true : false
           } catch {
               return false
           }
       }
    
    func updateNotes<T: Codable>(model: T) -> Bool {
          if let notes: [CurrentNotes] = cacheManager?.retrieveData() {
              if let notesModel = notes.first {
                  let encoder = JSONEncoder()
                  do {
                      let data = try encoder.encode(model)
                      notesModel.data = data
                      
                      return cacheManager?.saveContextIfChanged() == true ? true : false
                  } catch {
                      return false
                  }
              }
              
          }
          return false
      }
    func createnote(noteListModel: notesDic) -> Bool {
         if let notes: [CurrentNotes] = cacheManager?.retrieveData() {
             if notes.count > 0 {
                 return self.updateNotes(model:noteListModel)
             } else {
                 return self.insertNotes(notesListModel: noteListModel)
             }
         } else {
            return self.insertNotes(notesListModel: noteListModel)
         }
         
     }
}
struct ConstantsStrings {
    static let xcdatamodeld = "Demo_Task_By_Sarvesh"
    static let modelEntity = "CurrentNotes"
}
