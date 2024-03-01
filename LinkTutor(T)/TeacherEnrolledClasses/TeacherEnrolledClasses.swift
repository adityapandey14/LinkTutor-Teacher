//
//  TeacherEnrolledClasses.swift
//  linkTutor
//
//  Created by user2 on 27/02/24.
//

import SwiftUI

struct TeacherEnrolledClasses: View {
    var classdata : enrolledClassDataM
  
    
    var body: some View {
        VStack{
            HStack{
                Text("Heading")
                    .font(AppFont.largeBold)
                Spacer()
            }
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10) {
                    ForEach(enrolledClassMockData.classData){
                        classCard in TeacherEnrolledClassCardV(classCard: classCard)
                    }
                }
            }
        }
        .padding()
        .background(Color.background)
    }
}

#Preview{
    TeacherEnrolledClasses(classdata: enrolledClassMockData.sampleClassData)
}


struct TeacherEnrolledClassCardV: View{
    var classCard: enrolledClassDataM
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text(classCard.skill)
                    .font(AppFont.mediumSemiBold)
                Spacer()
            }
            VStack(alignment: .leading){
                Text("Days")
                    .font(AppFont.smallSemiBold)
                    .foregroundColor(.gray)
                    .padding(.top, 1)
                Text(classCard.daysConducted)
                    .font(AppFont.smallReg)
            }
            VStack(alignment: .leading){
                VStack{
                    Text("Timing")
                        .font(AppFont.smallSemiBold)
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                    Text(classCard.timing)
                        .font(AppFont.smallReg)
                }
            }
        }
        .frame(width: min(150,180), height: 130)
        .padding()
        .background(.elavated)
        .cornerRadius(10)
        
//        VStack{
//            HStack{
//                VStack(alignment: .leading){
//                    Text(classCard.skill)
//                        .font(AppFont.mediumSemiBold)
//                    HStack{
//                        VStack{
//                            Text("Days")
//                                .font(AppFont.smallSemiBold)
//                                .foregroundColor(.gray)
//                                .padding(.top, 1)
//                            Text(classCard.daysConducted)
//                                .font(AppFont.smallReg)
//                        }
//                        VStack{
//                            Text("Timing")
//                                .font(AppFont.smallSemiBold)
//                                .foregroundColor(.gray)
//                                .padding(.top, 1)
//                            Text(classCard.timing)
//                                .font(AppFont.smallReg)
//                        }
//                    }
//                    
//                    
//                }
//                Spacer()
//            }
//            .frame(width: 300, height: 150)
//            .fixedSize()
//            .padding()
//            .background(.elavated)
//            .cornerRadius(10)
//            
//        }
        
        
        
    }
    
    
    
}

