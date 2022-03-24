//
//  ListadoPerrosStruct.swift
//  ListaPerros
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import Foundation
struct Perros:Decodable{
    var dogName:String?
    var description:String?
    var age:Int
    var image:String
}
