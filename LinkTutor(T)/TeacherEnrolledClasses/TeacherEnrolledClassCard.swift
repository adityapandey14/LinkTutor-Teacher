//
//  TeacherEnrolledClassCard.swift
//  linkTutor
//
//  Created by user2 on 27/02/24.
//

import SwiftUI

struct TeacherEnrolledClassCard: View{
    var classCard: enrolledClassDataM
    var body: some View{
        HStack{
                VStack(alignment: .leading){
                    Text(classCard.skill)
                        .font(AppFont.mediumSemiBold)
                    
                    Text("Days")
                        .font(AppFont.smallReg)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                    Text(classCard.daysConducted)
                        .font(AppFont.smallReg)
                    Text("Timing")
                        .font(AppFont.smallReg)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                    Text(classCard.timing)
                        .font(AppFont.smallReg)
                }
            Spacer()
        }
        .frame(width: min(150,180), height: 140)
        .fixedSize()
        .padding()
        .background(.elavated)
        .cornerRadius(10)
    }

}

#Preview {
    TeacherEnrolledClassCard(classCard: enrolledClassMockData.sampleClassData)
}
