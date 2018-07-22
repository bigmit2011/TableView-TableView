

// CURRENTLY NOT BEING USED!!!!!!!!!!!!!!!!!


import UIKit

class ViewController: UIViewController {
    
    var folders : [String] = ["Sayaka", "Amit",
                              "Kuni", "Suni"]
    
    @IBAction func button(_ sender: Any) {
    }
    
    @IBOutlet weak var displayImage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        createFolders()
        moveImages()
        //printSayaka()
    }
    
    
    func createFolders() {
        for folder in self.folders{
            let documentsPath1 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
            let logsPath = documentsPath1.appendingPathComponent(folder)
            print(logsPath!)
            do {
                try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.debugDescription)
                NSLog("Unable to create directory \(error.debugDescription)")
            }
        }
    }
    
    
    func foldersInDocumentsDirectory()-> URL? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
        
        do {
            let foldersPathArray = try FileManager.default.contentsOfDirectory(atPath: documentsPath)
            
            let folderURL = URL(fileURLWithPath: documentsPath ).appendingPathComponent(foldersPathArray[Int(arc4random_uniform(UInt32(foldersPathArray.count-1)))])
            //print(folderURL)
            
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



}

