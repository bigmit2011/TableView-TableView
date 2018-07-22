

import UIKit

class SecondTableViewController: UIViewController {
    
    var CellObjects: [FolderCell] = []// array to fill cells
    
     // need to get folder name from FirstTableViewCell
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    
    
    
    
}
    

extension SecondTableViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellObjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellFolderObject = CellObjects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell") as! SecondTableViewCell
        cell.setCell(cell: cellFolderObject)
        return cell
}
}
