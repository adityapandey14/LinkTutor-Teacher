//
//  updateCourse.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 12/03/24.
//

import SwiftUI

struct updateCourse: View {
    @EnvironmentObject var viewModel: AuthViewModel
  //  @State private var currentUserUID: User?
  //  @State private var teacherUid: String = ""
    var documentId : String
    @State private var skillType: String = ""
    @State private var academyName: String = ""
    @State private var className = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var classFee : Int = 0
    @State private var selectedMode: ClassMode = .online
    @State private var selectedDays: [Day] = []
    @State private var isTeacherHomePageActive = false

    enum ClassMode: String, CaseIterable {
        case online = "Online"
        case offline = "Offline"
    }

    enum Day: String, CaseIterable {
        case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    }

    var body: some View {
        
        NavigationLink(destination: TeacherHomePage(), isActive: $isTeacherHomePageActive) {
              
            }
            .hidden()
        
        
        NavigationStack{
            
            VStack{
                
                VStack {
                    Section(header: CustomSectionHeader(title: "Class Details")) {
                        TextField("Skill Type", text: $skillType)
                        TextField("Academy Name", text: $academyName)
                        TextField("Class Name", text: $className)
                        
                        
                        // Choose Days VStack...
                        
                                    
                        
                        
                        DatePicker("Start Time", selection: $startTime, displayedComponents: [ .hourAndMinute])
                                            .datePickerStyle(.compact)
                        
                                        DatePicker("End Time", selection: $endTime, displayedComponents: [.hourAndMinute])
                                            .datePickerStyle(.compact)
                    }
                    .listRowBackground(Color.elavated)
                    
                    Section(header: CustomSectionHeader(title: "Modes")) {
                        Picker("Select Mode", selection: $selectedMode) {
                            ForEach(ClassMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .leading){
                    Text("Choose Days")
                    HStack {
                        ForEach(Day.allCases, id: \.self) { day in
                            Text(String(day.rawValue.first!))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(selectedDays.contains(day) ? Color.cyan.cornerRadius(10) : Color.gray.cornerRadius(10))
                                .onTapGesture {
                                    if selectedDays.contains(day) {
                                        selectedDays.removeAll(where: {$0 == day})
                                    } else {
                                        selectedDays.append(day)
                                    }
                                }
                        }
                    }
                }
                .padding(.bottom, 10)
                
                VStack(alignment : .leading){
                    
                    Text("Fees")
                        .fontWeight(.bold)
                        .font(.system(size: 20).weight(.bold))
                        .fontDesign(.rounded)
                    TextField("Class Fee", value: $classFee, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Spacer()
                Button(action: {
                       // Handle add class action
                       viewModel.updateCourseData(
                           skillType: skillType,
                           academyName: academyName,
                           className: className,
                           mode: selectedMode.rawValue,
                           fees: classFee,
                           week: selectedDays.map { $0.rawValue },
                           startTime: startTime.description,
                           endTime: endTime.description, 
                           documentId: documentId
                       )

                       // Activate the navigation to TeacherHomePage
                       isTeacherHomePageActive = true
                   }) {
                       Text("Update Class")
                           .foregroundColor(.white)
                           .font(AppFont.mediumSemiBold)
                           .padding()
                           .background(Color.blue)
                           .cornerRadius(20)
                   }
                
                
            }
        }
        .padding()
    }
}


#Preview {
    updateCourse( documentId: "something")
}
