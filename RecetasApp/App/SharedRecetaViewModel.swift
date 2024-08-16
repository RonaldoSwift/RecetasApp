//
//  SharedRecetaViewModel.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 9/08/24.
//

import Foundation
import UIKit

class SharedRecetaViewModel: ObservableObject {
    //Esto sirve para ir de pantalla 1 a 2
    var receta: Receta? = nil
    //Usamos publicador cuando venimos de 2 a 1
    @Published var publicadorUIImage: UIImage? = nil
}
