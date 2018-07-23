//
//  FirstTableViewController.swift
//  testProduct
//
//  Created by Amit on 7/17/18.
//  Copyright © 2018 Amit. All rights reserved.
//

import UIKit

class FirstTableViewController: UIViewController {
    
    
        
    @IBOutlet weak var tableView: UITableView!
    
    // folder we will create in documents folders
    var folders : [String] = ["Sayaka", "Amit",
                                  "Kuni", "Suni"]
    //data objects to populate cells in FirstTableView
    var dataCells: [FolderCell] = []
    var selectedIndex = Int()
    
    //data objects to populate cells in SecondTableView if tapped! (gesture)
    var imageObjects :[FolderCell] = []
      
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        createFolders() //create folders
        moveImages() // move images to folders
        dataCells =  createArrayData() //create dataObjects
            
    }
        
        func createFolders() {
            for folder in self.folders{
                let documentsPath1 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
                let logsPath = documentsPath1.appendingPathComponent(folder)
                do {
                    try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
                } catch let error as NSError {
                    print(error.debugDescription)
                    NSLog("Unable to create directory \(error.debugDescription)")
                }
            }
        }
        
        //NOT USING!!!!!!!
        func foldersInDocumentsDirectory()-> URL? {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
            
            do {
                let foldersPathArray = try FileManager.default.contentsOfDirectory(atPath: documentsPath)
                
                let folderURL = URL(fileURLWithPath: documentsPath ).appendingPathComponent(foldersPathArray[Int(arc4random_uniform(UInt32(foldersPathArray.count-1)))])
                
                
                return folderURL
                
            }
                
            catch {
                print("Error")
                return nil
            }
            
        }
        
        
        
        
        
        func moveImages(){
            let fileManager = FileManager.default
            let imagePath = Bundle.main.resourcePath! //+ "/Images/"
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
            let allImageDirectories =  try! fileManager.contentsOfDirectory(atPath: documentDirectory)
            let imageDirectories = allImageDirectories[1...(allImageDirectories.count-1)]
            
            for directory in imageDirectories{
                let imageDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(directory, isDirectory: true)
                
                
                do{
                    let imageNames = try fileManager.contentsOfDirectory(atPath: imagePath)
                    for image in imageNames{
                        let ext = NSURL(fileURLWithPath:image ).pathExtension
                        if ext == "jpg"{
                            let imageData =  UIImage(named: image)
                            let fileURL = imageDirectory.appendingPathComponent(image)
                            if let data = UIImageJPEGRepresentation(imageData!, 1.0),
                                !FileManager.default.fileExists(atPath: fileURL.path) {
                                do {
                                    
                                    // writes the image data to disk
                                    try data.write(to: fileURL)
                                    print("file saved")
                                } catch {
                                    print("error saving file:", error)
                                }
                            }            }
                    }}
                catch{
                    print("Missing Images")}
                
            }
            
            }
        func createArrayData()->[FolderCell]{
                var folderCells: [FolderCell] = []
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path else {
                print("NO DOCUMENT DIRECTORY")
                return []
            }
            
                let allImageDirectories =  try! FileManager.default.contentsOfDirectory(atPath: documentDirectory)
            
                let imageDirectories = allImageDirectories[1...(allImageDirectories.count-1)]
            
            for directory in imageDirectories{
                    //print("This" + directory)
                    
                guard let imageDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(directory, isDirectory: true) else{
                    print("No image Directory")
                    return []
                }
                
                guard let allImages =  try? FileManager.default.contentsOfDirectory(atPath: imageDirectory.path) else{
                    print("No image files")
                    return []
                }
                   
                let displayImage =  UIImage( named: allImages[0])
                folderCells.append(FolderCell(image: displayImage!, label :directory))
                
                
            }
            
            
                    
            return folderCells
                }
    
        func getImageObjects(folder: String) ->  [String] {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let folderDirectory = documentDirectory.appendingPathComponent(folder)
            let imageFiles = try! FileManager.default.contentsOfDirectory(atPath: folderDirectory.path)
            return imageFiles //image files of folder
        
    }
    
    
    func createImagesArray(imageFiles: [String]) -> [FolderCell]{
        var tempArray:[FolderCell] = []
        for imageFile in imageFiles{
        
        let image = UIImage(named: imageFile)
            tempArray.append(FolderCell(image: image!, label: imageFile))
        
        
        }
        return tempArray        }
    
    //segue to secondTableViewCell
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goToSecond"{
            let vc: SecondTableViewController = segue.destination as! SecondTableViewController
            
            let folderLabel = dataCells[selectedIndex].label
            let imageFiles = getImageObjects(folder:folderLabel)
            vc.CellObjects = createImagesArray(imageFiles: imageFiles)
        }
        
    }
            
    
            
        }
        
        
        

   

// EXTENSIONS!

extension FirstTableViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCells.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let folderCell = dataCells[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableCell") as! FirstTableViewCell
            cell.setCell(cell:folderCell)
        
            cell.delegate = self
            return cell
        
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
    }
}


extension FirstTableViewController:LabelCellDelegate {
    func func1(sender: Any) {
        self.performSegue(withIdentifier: "goToSecond", sender: self)
    }
    
}


