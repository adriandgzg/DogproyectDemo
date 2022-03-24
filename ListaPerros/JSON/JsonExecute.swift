//
//  JsonExecute.swift
//  ListaPerros
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import Foundation
class Urls {
    static let linkPerros = "https://jsonblob.com/api/945366962796773376"
}

class ExecuteJSON {
    
    func executeJSON(url:String, complited: @escaping (_ perro:[Perros])-> () ) {
        let urlSesion = URLSession.shared
        let url = URL(string: url)
        
        urlSesion.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    let response = try JSONDecoder().decode([Perros].self, from: data!)
                    DispatchQueue.main.async {
                        complited(response)
                    }
                }catch{
                    print("json error")
                }
            }
        }.resume()
    }
    
}
