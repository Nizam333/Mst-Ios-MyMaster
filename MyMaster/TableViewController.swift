//
//  TableViewController.swift
//  MyMaster
//
//  Created by Suriya on 7/1/16.
//  Copyright (c) 2016 MST. All rights reserved.
//

import UIKit

class TableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
   // let people=[
  //  ("Nizam","Trichy"),
   //     ("Jamal","Saudi Arabia"),
   //     ("Mansoor","Japan")
   // ]
    
    let people=[
        ("Nizam"),
        ("Jamal"),
        ("Mansoor")
    ]
    let videos=[("title1","file1"),("title2","file2"),("title3","file3")]
    
     var stringArray = Array<String>()
    
    
    var str_nizam="nizam"
    
    var databasePath = NSString()
    func openDb(){
    
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            let querySQL = "SELECT name,address, phone FROM CONTACTS"
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,withArgumentsInArray: nil)
            
            if results?.next() == true {
                
                while results?.next() == true
                {
                    if let resultString = results?.stringForColumn("name")
                    {
                        stringArray.append(resultString)
                    }
                }
                
                
                //var text = results?.stringForColumnIndex(1)
                
               // stringArray.append(text!)
                
                
               // println("the address is \(text)")
                
                // address.text = results?.stringForColumn("address")
               // phone.text = results?.stringForColumn("phone")
               // status.text = "Record Found"
            } else {
               // status.text = "Record not found"
               // address.text = ""
               // phone.text = ""
            }
            contactDB.close()
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
    }
//sections
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //rows
         func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       
            
        return stringArray.count
            
          }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell=UITableViewCell()
        
        
        
        
        let (personName)=stringArray[indexPath.row]
        cell.textLabel?.text=personName
            
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            return "Contacts"
            
      
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell \(indexPath.row)", terminator: "")
        //self.navigationController?.popViewControllerAnimated(true)
        
        let destination = mapViewController() // Your destination
        navigationController?.pushViewController(destination, animated: true)
        
        // println("You selected cell")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] 
        
        databasePath = (docsDir as NSString).stringByAppendingPathComponent("contacts.db")
        
        if !filemgr.fileExistsAtPath(databasePath as String) {
            
            let contactDB = FMDatabase(path: databasePath as String)
            
            if contactDB == nil {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    print("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }
        }
        openDb()
    }
}



