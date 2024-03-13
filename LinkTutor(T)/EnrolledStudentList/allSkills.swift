//
//  allSkills.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 13/03/24.
//

import SwiftUI

struct allSkills: View {
    @ObservedObject var viewModel = SkillViewModel()
    @State private var selectedSkillType: SkillType?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.skillTypes) { skillType in
                    VStack(alignment: .leading) {
                        Text("Skill Type: \(skillType.id)")
                            .font(.headline)
                            .onTapGesture {
                                selectedSkillType = skillType
                                viewModel.fetchSkillOwnerDetails(for: skillType)
                            }
                            .padding()
                        
                        
                        
                        ForEach(skillType.skillOwnerDetails.filter { $0.teacherUid == "1"  }) { detail in
                            VStack(alignment: .leading) {
                                Text("Class Name: \(detail.className)")
                                    .padding()
                                Text("Academy: \(detail.academy)")
                                    .padding()
                                Text("Price: \(detail.price)")
                                    .padding()
                                Text("week: \(detail.week)")
                                    .padding()
                                    .foregroundColor(.red)
                                
                                enrolledClassCard(documentId: detail.id, className: detail.className, days: detail.week, startTime: detail.startTime, endTime: detail.endTime)
                                // Add other fields as needed
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    allSkills()
}
