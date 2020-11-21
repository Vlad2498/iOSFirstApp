//
//  GameResultDatabaseManager.swift
//  FirstApp
//
//  Created by Ioan-Vlad Vamos on 2020-11-18.
//

import Foundation
import CoreData

class GameResultDatabaseManager {
    
    func create(withNumberOfQuestions numberOfQuestions: Int, withRightAnswer rightAnswers: Int) -> GameResult? {
        let managedObjectContext = DatabaseManager.shared.managedObjectContext
        
        let gameResult = NSEntityDescription.insertNewObject(forEntityName: "GameResult", into: managedObjectContext) as? GameResult
        
        //Setting the data
        gameResult?.numberOfQuestions = Int32(numberOfQuestions)
        gameResult?.rightAnswers = Int32(rightAnswers)
        gameResult?.date = Date()
        
        return gameResult
    }
    
    func save() {
        DatabaseManager.shared.saveContext()
    }
    
}
