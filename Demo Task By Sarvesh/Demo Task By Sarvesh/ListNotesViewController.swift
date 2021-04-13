//
//  ViewController.swift
//  Demo Task By Sarvesh
//
//  Created by Nilesh Vernekar on 11/04/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import CoreData
class notesDic: Codable {
    var notesarray : [Notes]?
}
struct Notes:  Codable {
    var titleT: String? = ""
    var descT: String? = ""
    init(titleT: String?,descT: String?) {
        self.descT = descT
        self.titleT = titleT
    }
}


class ListNotesViewController: UIViewController {
    
   
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var noteTable: UITableView!
    
    var noteData: [Notes]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTable.register(UINib(nibName: NotesTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: NotesTableViewCell.cellIdentifier)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchNotes()
    }
    @IBAction func addBtnPressed(_ sender: Any) {
        guard let Vc = storyboard?.instantiateViewController(withIdentifier: "DetailNotesViewController") as? DetailNotesViewController else {
            return
        }
       // Vc.title = "Notes"
        Vc.delegate = self
        navigationController?.pushViewController(Vc, animated: true)
    }
    
}
extension ListNotesViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.cellIdentifier, for: indexPath) as! NotesTableViewCell
        cell.Lbl.text = noteData?[indexPath.row].titleT ?? ""
        cell.descLbl.text = noteData?[indexPath.row].descT ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let Vc = storyboard?.instantiateViewController(withIdentifier: "DetailNotesViewController") as? DetailNotesViewController else {
            return
        }
        let data = noteData?[indexPath.row].titleT
//        Vc.titlefield.text = noteData?[indexPath.row].titleT ?? ""
//        Vc.notesDetail.text = noteData?[indexPath.row].descT ?? ""
        Vc.delegate = self
        Vc.index = indexPath.row
        Vc.notesData = noteData?[indexPath.row]
        navigationController?.pushViewController(Vc, animated: true)
    }
    
    
}
extension ListNotesViewController: callNotes {
    func displayDetail(title: String,desc:String) {
//        model.append((title,desc))
        var data = Notes(titleT: title, descT: desc)
        if noteData == nil {
           
            noteData?.append(data)
        } else{
           noteData?.append(data)
        }
      
        
        self.noteTable.reloadData()
//        saveNotes(title: title, descP:desc)
        let notes = notesDic()
        notes.notesarray = noteData
        saveNotes(model: notes)
    }
    
    fileprivate func saveNotes(model: notesDic) {
          
          let noteDBDataSource = NotesDB(modelName: ConstantsStrings.xcdatamodeld, entityName: ConstantsStrings.modelEntity)
          
        noteDBDataSource.createnote(noteListModel: model)
      }
    
    fileprivate func fetchNotes() {
          let noteDBDataSource = NotesDB(modelName: ConstantsStrings.xcdatamodeld, entityName: ConstantsStrings.modelEntity)
          
          if let notes: notesDic = noteDBDataSource.readNotesFromCache() {
              
            
            noteData = notes.notesarray
          }
      }
}
