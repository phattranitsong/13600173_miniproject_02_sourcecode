//
//  Question.swift
//  13600173_mnp_THL_1
//
//  Created by songsuay on 11/9/18.
//  Copyright © 2018 ICTSUIM. All rights reserved.
//

class Question{
    let answer : Bool
    let questionText : String
    init(text : String, correctAnswer : Bool) {
        questionText = text
        answer = correctAnswer
    }
}
