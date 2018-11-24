//
//  QuestionBank.swift
//  13600173_mnp_THL_1
//
//  Created by songsuay on 11/9/18.
//  Copyright © 2018 ICTSUIM. All rights reserved.
//

import Foundation
class QuestionBank{
    
    var list = [Question] ()
    
    init() {
        let item = Question (text: "ไปไหนมาค่ะ?",correctAnswer:false)
        list.append(item)
        list.append(Question(text: "รำคาน", correctAnswer: false))
        list.append(Question(text: "อนุญาติ", correctAnswer: false))
        list.append(Question(text: "ผัดไทย", correctAnswer: true))
        list.append(Question(text: "น้ำมันก๊าซ", correctAnswer: false))
        list.append(Question(text: "อัพเดท", correctAnswer: false))
        list.append(Question(text: "ลำไย", correctAnswer: true))
        list.append(Question(text: "เครื่องสำอาง", correctAnswer: true))
        list.append(Question(text: "ลักษณะนาม", correctAnswer: false))
        list.append(Question(text: "ฑาทิม", correctAnswer: false))
        
        list.append(Question(text: "สวัสดีคะ", correctAnswer: false))
        list.append(Question(text: "ช็อกโกแลต", correctAnswer: true))
        list.append(Question(text: "ไอศครีม", correctAnswer: false))
        list.append(Question(text: "กราฟฟิก", correctAnswer: false))
        list.append(Question(text: "โอกาศ", correctAnswer: false))
        list.append(Question(text: "สังเกต", correctAnswer: true))
        list.append(Question(text: "ผัดกระเพรา", correctAnswer: false))
        list.append(Question(text: "ผูกพันธ์", correctAnswer: false))
        list.append(Question(text: "ลายเซ็นต์", correctAnswer: false))
        list.append(Question(text: "อีเมล", correctAnswer: true))
        
    }
}

