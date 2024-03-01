//
//  TeacherEnrolledClassList.swift
//  linkTutor
//
//  Created by user2 on 27/02/24.
//

import SwiftUI

struct TeacherEnrolledClassList: View {
    var classdata : enrolledClassDataM
  
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 10) {
                ForEach(enrolledClassMockData.classData){
                    classCard in TeacherEnrolledClassCardV(classCard: classCard)
                }
                
            }
        }
    }
}

#Preview{
    TeacherEnrolledClassList(classdata: enrolledClassMockData.sampleClassData)
}
