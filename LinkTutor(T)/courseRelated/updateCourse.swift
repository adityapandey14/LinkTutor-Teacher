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
    @Environment(\.presentationMode) var presentationMode
    
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
                List{
                    Section(header: CustomSectionHeader(title: "Class Details").foregroundColor(.white)){
                        TextField("Skill Type", text: $skillType)
                            .autocapitalization(.none)
                            .cornerRadius(10)
                        TextField("Academy Name", text: $academyName)
                            .cornerRadius(10)
                        TextField("Class Name", text: $className)
                            .cornerRadius(10)
                    }
                    .listRowBackground(Color.darkbg)
                    .multilineTextAlignment(.leading)
                    
                    // Choose Days
                    Section{
                        DatePicker("Start Time", selection: $startTime, displayedComponents: [ .hourAndMinute])
                            .datePickerStyle(.compact)
                            .font(AppFont.smallReg)
                        DatePicker("End Time", selection: $endTime, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(.compact)
                            .font(AppFont.smallReg)
                    }
                    .listRowBackground(Color.darkbg)
                    
                    //choose mode
                    Section(header: CustomSectionHeader(title: "Modes")) {
                        Picker("Select Mode", selection: $selectedMode) {
                            ForEach(ClassMode.allCases, id: \.self) { mode in
                                Text(mode.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .listRowBackground(Color.clear)
                    
                    //choose days
                    Section(header: CustomSectionHeader(title: "Choose days").foregroundColor(.white)){
                        HStack{
                            Spacer()
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
                            .frame(maxWidth: .infinity)
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                    
                    //Fee
                    Section(header: CustomSectionHeader(title: "Fee per month").foregroundColor(.white)){
                        TextField("Class Fee", value: $classFee, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    .listRowBackground(Color.darkbg)
                    .multilineTextAlignment(.leading)
                    
                    //update button
                    HStack{
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
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Update details")
                                .foregroundColor(.white)
                                .font(AppFont.mediumSemiBold)
                        }
                        .frame(width:250, height: 25)
                        .padding()
                        .background(Color.accent)
                        .cornerRadius(50)
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }//liend
                .scrollContentBackground(.hidden)
                .font(AppFont.smallReg)
                
            }//vend
            .background(Color.background)
        }
    }
}


#Preview {
    updateCourse( documentId: "something")
}
