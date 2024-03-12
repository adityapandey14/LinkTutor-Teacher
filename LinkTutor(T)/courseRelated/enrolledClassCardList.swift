//
//  enrolledClassCardList.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 12/03/24.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore


struct enrolledClassCardList: View {
    @ObservedObject var skillViewModel = SkillViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
 
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                ForEach(skillViewModel.skillTypes) { skillType in
                    VStack(alignment: .leading) {
                       
                        
                        ForEach(skillType.skillOwnerDetails) { detail in
                            if detail.teacherUid == "7poyqhviIHOvEYKau5S8zwiuko42" {
                                VStack(alignment: .leading) {
                                    
                                    enrolledClassCard(documentId: detail.id,
                                                      className: detail.className,
                                                      days: detail.week,
                                                      startTime: detail.startTime,
                                                      endTime: detail.endTime)
                                    // Add other fields as needed
                                }
                                .padding()
                            }
                        }
                    }
                    .onAppear() {
                        
                        // await viewModel.fetchUser()
                        skillViewModel.fetchSkillOwnerDetails(for: skillType)
                    }
                    .padding()
                    
                }
            }
        }
    }
}


#Preview {
    enrolledClassCardList()
}
