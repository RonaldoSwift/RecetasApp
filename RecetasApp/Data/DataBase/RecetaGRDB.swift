//
//  RecetaGRDB.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 19/08/24.
//

import Foundation
import Combine
import GRDB

var databaseQueue: DatabaseQueue!
class RecetaGRDB {
    
    let publicadorInsertarReceta = PassthroughSubject<String, Error>()
    let publicadorGetReceta = PassthroughSubject<[RecetaEntity], Error>()
    
    //Creamos la base de datos
    
    func inicializadorBaseDeDatosiOS15() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("db.sqlite")
        let dataBasePath = fileURL.path
        databaseQueue = try! DatabaseQueue(path: dataBasePath)
    }
    
    //Creamos la tabla
    func crearTablaDeReceta() {
        do {
            try databaseQueue.write  ({ dataBase in
                try dataBase.create(table: "RecetaEntity",body: { tableDefinition in
                    tableDefinition.primaryKey("id", .integer)
                    tableDefinition.column("title", .text).notNull()
                    tableDefinition.column("image", .text).notNull()
                })
            })
        } catch let error {
            print("Error en la creacion de la tabla")
            print(error)
        }
    }
    
    func insertarRecetaALaTabla(id: Int, title: String, image: String) {
        let recetaEntity = RecetaEntity(
            id: id,
            title: title,
            image: image
        )
        do {
            try databaseQueue.write ({ database in
                try recetaEntity.insert(database)
                publicadorInsertarReceta.send("Se guardo en Favorito")
            })
        } catch let error {
            publicadorInsertarReceta.send(completion: .failure(error))
        }
    }
    
    func getRecetaFromTable() {
        let recetasEntity: [RecetaEntity] = try! databaseQueue.read({ database in
            try RecetaEntity.fetchAll(database)
        })
        publicadorGetReceta.send(recetasEntity)
    }
    
    //USANDO QUERY
    func getRecetaFromTable2() {
        var recetasEntity:[RecetaEntity] = []
        do {
            try databaseQueue.read({ (database:Database) in
                let rows = try Row.fetchAll(database, sql: "SELECT id, title, image FROM RecetaEntity")
                recetasEntity = rows.map { (row: Row) in
                    RecetaEntity(
                        id: row[0],
                        title: row[1],
                        image: row[2]
                    )
                }
            })
            publicadorGetReceta.send(recetasEntity)
        } catch let error {
            publicadorGetReceta.send(completion: .failure(error))
        }
    }
    
    //USANDO QUERY
    func insertarRecetaALaTabla2(id: Int, title: String, image: String) {
        do {
            try databaseQueue.write { (dataBase:Database) in
                try dataBase.execute(sql: "INSERT INTO RecetaEntity (id, title, image) VALUES (?, ?, ?)", arguments: [id, title, image])
                publicadorInsertarReceta.send("Se inserto Correctamente")
            }
        } catch let error {
            publicadorInsertarReceta.send(completion: .failure(error))
        }
    }
}
