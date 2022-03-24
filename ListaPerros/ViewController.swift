//
//  ViewController.swift
//  ListaPerros
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    var perro:[Perros] = []
    @IBOutlet weak var tablaPerros: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaPerros.delegate = self
        tablaPerros.dataSource = self
        
        let jsonExecute = ExecuteJSON()
        jsonExecute.executeJSON(url: Urls.linkPerros) { perro in
            self.perro = perro
            self.tablaPerros.reloadData()
        }
        let celdaPerro = UINib(nibName: "PerrosCeldaTableViewCell", bundle: nil)
        tablaPerros.register(celdaPerro, forCellReuseIdentifier: "celdaPerro")
        
/*############# llamado de funcion para search bar #######################################################*/
        self.searchBar()
    }
    
/*############ funciones para search bar #################################################################*/
    func searchBar () {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        self.tablaPerros.tableHeaderView = searchBar
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            let apiRequest = ExecuteJSON()
            apiRequest.executeJSON(url: Urls.linkPerros) { perro in
                self.perro = perro
                self.tablaPerros.reloadData()
            }
            
        }else {
            if searchBar.selectedScopeButtonIndex == 0 {
                perro = perro.filter({ dog in
                    return dog.dogName!.lowercased().contains(searchText.lowercased())
                })
            }
        }
        self.tablaPerros.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return perro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPerros.dequeueReusableCell(withIdentifier: "celdaPerro", for: indexPath) as! PerrosCeldaTableViewCell
        
        celda.backgroundColor = UIColor.hexStringToUIColor(hex: "F8F8F8")
        
        celda.lblNombrePerro.text = perro[indexPath.row].dogName?.capitalized
        celda.lblNombrePerro.textColor = UIColor.hexStringToUIColor(hex: "333333")
        celda.lblNombrePerro.backgroundColor = UIColor.white
        celda.lblDescripcionPerro.text = perro[indexPath.row].description?.capitalized
        celda.lblDescripcionPerro.textColor = UIColor.hexStringToUIColor(hex: "666666")
        
        celda.lblEdadPerro.text = String(perro[indexPath.row].age)
        
        
        
        //let linkCompleto = perro[indexPath.row].image
        celda.imgPerro?.downloaded(from: perro[indexPath.row].image)
        celda.imgPerro?.layer.cornerRadius = (celda.imgPerro?.frame.height)! / 12
        celda.imgPerro?.contentMode = .scaleAspectFill
        celda.imgPerro?.clipsToBounds = true
        
        return celda
    }
    
}

extension UIColor {
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
