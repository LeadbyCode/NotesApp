# NotesApp
Notes are stored in local DB using core data
Notes app iOS **#Configuring the Storyboard

The Project consist of 1 Cache Manager 2 DetailNotesViewController.swift 3.ListNotesViewController.swift 4.NotesDB.swift 5.NotesTableViewCell.swift 6.NotesTableViewCell.xib

We want to create an app that can display notes. The app will consist of two different view controllers, the first one will display a list of notes, the second one will display the details of a note when it is selected from the list. We will design the entire layout of this app in storyboard. Open the Main.storyboard file to get started.

##Setting up the ListNotesViewController

Let's start by creating the first view controller that displays a list of notes. Whenever we want to display items in a list on iOS we use a component called UITableView. Since that component is used very often Interface Builder provides a template view controller called Table View Controller that provides a basic table view and a ViewController that is associated with it. Before we create it let's remove the default view controller that has been created as part of the template:

NotesDB : it consist of function to update and retrieve the data stored in local DB

DetailNotesViewController : Is used to display the detail of notes which can be edited using textfield and textview
