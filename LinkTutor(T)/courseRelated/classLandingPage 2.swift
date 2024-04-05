//
//  classLandingPage.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 29/03/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct classLandingPage: View {
    @ObservedObject var viewModel = SkillViewModel()
    @State private var userId: String?
    
    var body: some View {
        VStack{
            ScrollView {
                ForEach(viewModel.skillTypes) { skillType in
                    VStack(alignment: .leading) {
                        self.skillTypeVStack(skillType: skillType)
                    }
                    .onAppear() {
                        userId = Auth.auth().currentUser?.uid
                        viewModel.fetchSkillOwnerDetails(for: skillType)
                    }
                }
            }
        }
    } //body
    
    func skillTypeVStack(skillType: SkillType) -> some View {
        VStack(alignment: .leading) {
            ForEach(skillType.skillOwnerDetails.filter { $0.teacherUid == userId }) { detail in
                VStack(alignment: .leading, spacing: 10) {
                    self.detailNavigationLink(detail: detail)
                }
            }
        }
    }
    
    func detailNavigationLink(detail: SkillOwnerDetail) -> some View {
        NavigationLink(destination: LandingPageCard( skillOwnerDetailsUid : detail.id,
                                                   academy: detail.academy,
                                                    documentId: detail.id,
                                                     className: detail.className,
                                                     startTime: detail.startTime.dateValue(), // Convert to Date
                                                     endTime: detail.endTime.dateValue(), // Convert to Date
                                                     week: detail.week,
                                                     mode: detail.mode,
                                                     price: Int(detail.price))) {
            enrolledClassCard(documentId: detail.id,
                              className: detail.className,
                              days: detail.week,
                              startTime: detail.startTime.dateValue(),
                              endTime: detail.endTime.dateValue())
        }
    }
}

struct classLandingPage_Previews: PreviewProvider {
    static var previews: some View {
        classLandingPage()
    }
}

struct LandingPageCard: View {
    var skillOwnerDetailsUid : String
    var academy: String
    var documentId: String
    var className: String
    var startTime: Date // Changed to Date
    var endTime: Date // Changed to Date
    var week: [String]
    var mode: String
    var price: Int
    
    @State private var showingUpdateCourse = false
    @State private var showingStudentList = false
    
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @ObservedObject var teacherViewModel = TeacherViewModel.shared
    let userId = Auth.auth().currentUser?.uid

    var body: some View {
        VStack(alignment: .leading) {
            //header
            HStack{
                VStack(alignment: .leading) {
                    Text("\(className)")
                        .font(AppFont.largeBold)
                    
                    if let teacherDetails = teacherViewModel.teacherDetails.first {
                        Text("by \(teacherDetails.fullName)")
                            .font(AppFont.mediumReg)
                    } else {
                        Text("Loading...")
                            .font(AppFont.mediumReg)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            
            //STARS
            HStack {
                let reviewsForSkillOwner = reviewViewModel.reviewDetails.filter {  $0.skillOwnerDetailsUid == "\(skillOwnerDetailsUid)" }
                                                      
                if !reviewsForSkillOwner.isEmpty {
                    let averageRating = reviewsForSkillOwner.reduce(0.0) { $0 + Double($1.ratingStar) } / Double(reviewsForSkillOwner.count)
                    
                    Text("\(averageRating, specifier: "%.1f") ⭐️")
                        .padding([.top, .bottom], 4)
                        .padding([.leading, .trailing], 12)
                        .background(Color.elavated)
                        .cornerRadius(50)
                    
                    Text("\(reviewsForSkillOwner.count) Review\(reviewsForSkillOwner.count == 1 ? "" : "s")")
                        .font(AppFont.smallReg)
                        .foregroundColor(.black).opacity(0.6)
                } else {
                    Text("No Review")
                        .font(AppFont.smallReg)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.leading, 5)
            
            HStack{
                //update
                Button(action: {
                    //action
                    showingUpdateCourse = true
                }) {
                    Text("Update details")
                        .font(AppFont.smallReg)
                        .foregroundColor(.white)
                        .padding(10)
                        .padding(.horizontal)
                }
                .background(Color.accent)
                .cornerRadius(20)
//                .padding([.top, .bottom], 10)
//                .padding(.leading, 5)
                .sheet(isPresented: $showingUpdateCourse) {
                    // Present the update course view here
                    updateCourse(documentId: documentId)
                }
                
                //students list
                Button(action: {
                    //action
                    showingStudentList = true
                }) {
                    Text("Students enrolled")
                        .font(AppFont.smallReg)
                        .foregroundColor(.black)
                        .padding(10)
                        .padding(.horizontal)
                }
                .background(Color.elavated)
                .cornerRadius(20)
//                .padding([.top, .bottom], 10)
//                .padding(.leading, 5)
                .sheet(isPresented: $showingStudentList) {
                    // Present the update course view here
                    enrolledStudentList(className: className)
                }
            }
            // QuickInfoBox
            let teacherDetails = teacherViewModel.teacherDetails.first(where: { $0.id == userId })
            if let teacherDetails = teacherDetails {
                quickInfoCard(tutorAddress: "\(teacherDetails.city)".capitalized, startTime: startTime, endTime: endTime , tutionFee: price )
                    .padding([.top, .bottom], 10)
            }
            
            //modes
            HStack {
                VStack(alignment: .leading) {
                    Text("Mode")
                        .font(AppFont.mediumSemiBold)
                        .padding(.bottom, 5)
                        .padding(.top)
                    VStack {
                        if mode == "both" {
                            HStack {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.black).opacity(0.6)
                                Text("Online")
                                    .font(AppFont.smallReg)
                                    .foregroundColor(.black)
                                Spacer()
                            }.padding(5)
                            HStack {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.black).opacity(0.6)
                                Text("Offline")
                                    .font(AppFont.smallReg)
                                    .foregroundColor(.black)
                                Spacer()
                            }.padding(5)
                        }
                        else{
                            HStack {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.black).opacity(0.6)
                                Text("\(mode)".capitalized)
                                    .font(AppFont.smallReg)
                                    .foregroundColor(.black)
                                Spacer()
                            }.padding(5)
                        }
                    }
                }
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Reviews")
                        .font(AppFont.mediumSemiBold)
                        .padding(.bottom, 5)
                        .padding(.top)

                    ForEach(reviewViewModel.reviewDetails.filter { $0.skillOwnerDetailsUid == "\(skillOwnerDetailsUid)" }) { teacherDetail in
                        
                        if let formattedDate = formatDate(teacherDetail.time) {
                            reviewCard(reviewRating: teacherDetail.ratingStar , review: "\(teacherDetail.comment)", time: "\(formattedDate)")
                        }
                      
                    }// End of For loop
                }
                .padding([.top, .bottom], 10)
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .background(Color.background)
    }
    func formatDate(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY" // Date format: dayOfMonth month
        return dateFormatter.string(from: date)
    }
    
    func formatDateTime(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a" // Date format: dayOfMonth month year hour:minute AM/PM
        return dateFormatter.string(from: date)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


//struct enrolledLandingPage: View {
//  
//    var skillUid : String
//    var skillOwnerDetailsUid : String
//    var className: String
//    let teacherUid = Auth.auth().currentUser?.uid
//    
//    var academy: String
// 
//    var startTime: Date // Changed to Date
//    var endTime: Date // Changed to Date
//    var week: [String]
//    var mode: String
//    var price: Int
//
//    @State private var isCopied = false
//    @State private var showAlert = false
//    
//    @ObservedObject var studentViewModel = StudentViewModel.shared
//    
//    @State var showingUpdate = false
//    @ObservedObject var teacherViewModel = TeacherViewModel.shared
//    @ObservedObject var reviewViewModel = ReviewViewModel()
//    @EnvironmentObject var viewModel: AuthViewModel
//    @ObservedObject var skillViewModel = SkillViewModel()
//    @State private var showDeleteAlert = false
//    
//    
//
//
//    var body: some View {
//        NavigationStack {
//          
//                    VStack {
//               
//                            
//                            
//                            VStack {
//                                VStack {
//                                    // Header
//                                    HStack {
//                                        VStack(alignment: .leading) {
//                                            Text("\(academy)")
//                                                .font(AppFont.largeBold)
//
//                                            if let teacherDetails = teacherViewModel.teacherDetails.first {
//                                                Text("by \(teacherDetails.fullName)")
//                                                    .font(AppFont.mediumReg)
//                                            } else {
//                                                Text("Loading...")
//                                                    .font(AppFont.mediumReg)
//                                            }
//                                        }
//                                        .padding(.horizontal)
//                                        Spacer()
//                                    }
//
//                                    ScrollView(.vertical) {
//                                        if !teacherViewModel.teacherDetails.isEmpty {
//                                            // View content using teacherViewModel.teacherDetails
//                                            if let teacherDetails = teacherViewModel.teacherDetails.first {
//                                                // Rating and Review
//                                                HStack {
//                                                    let reviewsForSkillOwner = reviewViewModel.reviewDetails.filter { $0.teacherUid == teacherUid && $0.skillOwnerDetailsUid == skillOwnerDetailsUid }
//                                                                                          
//                                                    if !reviewsForSkillOwner.isEmpty {
//                                                        let averageRating = reviewsForSkillOwner.reduce(0.0) { $0 + Double($1.ratingStar) } / Double(reviewsForSkillOwner.count)
//                                                        
//                                                        Text("\(averageRating, specifier: "%.1f") ⭐️")
//                                                            .padding([.top, .bottom], 4)
//                                                            .padding([.leading, .trailing], 12)
//                                                            .background(Color.background)
//                                                            .cornerRadius(10)
//                                                        
//                                                        Text("\(reviewsForSkillOwner.count) Review\(reviewsForSkillOwner.count == 1 ? "" : "s")")
//                                                            .font(AppFont.smallReg)
//                                                            .foregroundColor(.black)
//                                                    } else {
//                                                        Text("No Review")
//                                                            .font(AppFont.smallReg)
//                                                            .foregroundColor(.black)
//                                                    }
//                                                    Spacer()
//                                                }
//
//                                                // Enroll button
//                                              
//                                                HStack {
//                                                    Button(action: {
//                                                        showDeleteAlert.toggle()
//                                                
//                                                    }) {
//                                                        Text("Unenroll")
//                                                            .font(AppFont.actionButton)
//                                                            .foregroundColor(.white)
//                                                    }
//                                                    .frame(minWidth: 90, minHeight: 30)
//                                                    .background(Color.red)
//                                                    .cornerRadius(8)
//                                                    .alert(isPresented: $showDeleteAlert) {
//                                                        Alert(
//                                                            title: Text("Unenroll from class"),
//                                                            message: Text("Are you sure?"),
//                                                            primaryButton: .destructive(Text("Delete")) {
//                                                                Task {
//                                                                    RequestListViewModel().deleteEnrolled(id: id)
//                                                                }
//                                                            },
//                                                            secondaryButton: .cancel()
//                                                        )
//                                                    }
//                                                    Spacer()
//                                                }
//                                                
//                                             
//                                                QuickInfoCard(tutorAddress: "\(teacherDetails.city)", startTime: endTime , endTime: endTime, tutionFee: price )
//                                                                                       .padding([.top, .bottom], 10)
//                                              
//                                                // QuickInfoBox
//                                              
//                                               //Phone fill , message fill code
//                                                HStack {
//                                                    HStack {
//                                                        Image(systemName: "phone.fill")
//                                                            .font(.system(size: 15))
//
//                                                        Text(String("\(teacherDetails.phoneNumber)"))
//                                                            .font(AppFont.actionButton)
//                                                    }
//                                                    .padding([.top, .bottom], 6)
//                                                    .padding([.leading, .trailing], 12)
//                                                    .background(Color.phoneAccent)
//                                                    .foregroundStyle(Color.black)
//                                                    .cornerRadius(50)
//                                                    .onTapGesture {
//                                                        let phoneNumberString = "\(teacherDetails.phoneNumber)"
//                                                        UIPasteboard.general.string = phoneNumberString
//                                                        isCopied = true
//                                                    }
//                                                    .alert(isPresented: $isCopied) {
//                                                        Alert(title: Text("Copied!"), message: Text("Phone number copied to clipboard."), dismissButton: .default(Text("OK")))
//                                                    }
//
//                                                    HStack {
//                                                        Image(systemName: "message.fill")
//                                                            .font(.system(size: 15))
//                                                        Text("iMessage")
//                                                            .font(AppFont.actionButton)
//                                                    }
//                                                    .padding([.top, .bottom], 4)
//                                                    .padding([.leading, .trailing], 12)
//                                                    .background(Color.messageAccent)
//                                                    .foregroundStyle(Color.black)
//                                                    .cornerRadius(50)
//                                                 
//                                                    Spacer()
//                                                }
//                                                .padding([.top, .bottom], 10)
//
//                                                HStack {
//                                                    VStack(alignment: .leading) {
//                                                        Text("Mode")
//                                                            .font(AppFont.mediumSemiBold)
//                                                            .padding(.bottom, 5)
//                                                            .padding(.top)
//                                                        VStack {
//                                                            if mode == "both" {
//                                                                HStack {
//                                                                    Image(systemName: "checkmark")
//                                                                        .font(.system(size: 20))
//                                                                    Text("Online")
//                                                                        .font(AppFont.smallReg)
//                                                                        .foregroundColor(.gray)
//                                                                    Spacer()
//                                                                }.padding(5)
//                                                                HStack {
//                                                                    Image(systemName: "checkmark")
//                                                                        .font(.system(size: 20))
//                                                                    Text("Offline")
//                                                                        .font(AppFont.smallReg)
//                                                                        .foregroundColor(.gray)
//                                                                    Spacer()
//                                                                }.padding(5)
//                                                            }
//                                                            else{
//                                                                HStack {
//                                                                    Image(systemName: "checkmark")
//                                                                        .font(.system(size: 20))
//                                                                    Text("\(mode)")
//                                                                        .font(AppFont.smallReg)
//                                                                        .foregroundColor(.gray)
//                                                                    Spacer()
//                                                                }.padding(5)
//                                                            }
//                                                        }
//                                                    }
//                                                    Spacer()
//                                                }
//
//                                                HStack {
//                                                    VStack(alignment: .leading) {
//                                                        Text("Reviews")
//                                                            .font(AppFont.mediumSemiBold)
//                                                            .padding(.bottom, 5)
//                                                            .padding(.top)
//
//                                                        ForEach(reviewViewModel.reviewDetails.filter { $0.skillUid == "\(skillUid)" && $0.teacherUid == "\(teacherUid)" && $0.skillOwnerDetailsUid == "\(skillOwnerDetailsUid)" }) { teacherDetail in
//                                                            
//                                                            if let formattedDate = formatDate(teacherDetail.time) {
//                                                                reviewCard(reviewRating: teacherDetail.ratingStar , review: "\(teacherDetail.comment)", time: "\(formattedDate)")
//                                                            }
//                                                          
//                                                        }// End of For loop
//                                                    }
//                                                    .padding([.top, .bottom], 10)
//                                                    Spacer()
//                                                }
//                                                Spacer()
//                                            } else {
//                                                Text("Loading...")
//                                                    .font(AppFont.mediumReg)
//                                            }
//                                        } else {
//                                            Text("Loading...")
//                                                .padding()
//                                        }
//                                    }
//                                    .padding()
//                                }
//                                .background(Color.background)
//                                .onAppear {
//
//                                    DispatchQueue.main.async {
//                                        Task {
//                                            await teacherViewModel.fetchTeacherDetailsByID(teacherID: teacherUid)
//                                        }
//                                    }
//                                }
//                            }//End of VStack
//                            
//                     
//                  
//                } //End of both if let statement of skillViewModel
//         
//        }//End of navigation Stack
//    }
//    
//    func formatDate(_ date: Date) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMMM YYYY" // Date format: dayOfMonth month
//        return dateFormatter.string(from: date)
//    }
//    
//    private func openMessagesApp(withPhoneNumber phoneNumber: String) {
//            let smsUrlString = "sms:\(phoneNumber)"
//            guard let smsUrl = URL(string: smsUrlString) else { return }
//            UIApplication.shared.open(smsUrl)
//        }
//}
//
//
//
//
//
//import SwiftUI
//import Firebase
//
//struct QuickInfoCard: View {
//    var tutorAddress: String
//    var startTime: Date
//    var endTime: Date
//    var tutionFee: Int
//    
//    // DateFormatter to format Timestamp to Time
//    private let timeFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "h:mm a" // Format: "3:30 PM"
//        return formatter
//    }()
//    
//    var body: some View {
//        VStack {
//            // Address
//            VStack(alignment: .leading) {
//                Text("Address")
//                    .font(AppFont.smallSemiBold)
//                HStack {
//                    Image("location")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(.white)
//                    Text("\(tutorAddress)")
//                        .font(AppFont.smallReg)
//                    Spacer()
//                }
//                .offset(y: -5)
//            }
//            .padding(.bottom, 5)
//            
//            // Timing
//            VStack(alignment: .leading) {
//                Text("Timing")
//                    .font(AppFont.smallSemiBold)
//                HStack {
//                    Text(formattedTime(startTime))
//                        .padding(.trailing, 10)
//                        .font(AppFont.smallReg)
//                    Spacer()
//                }
//            }
//            .padding(.bottom, 5)
//            
//            // Fee
//            VStack(alignment: .leading) {
//                Text("Fee")
//                    .font(AppFont.smallSemiBold)
//                HStack {
//                    Text("₹\(tutionFee) /month")
//                        .font(AppFont.smallReg)
//                    Spacer()
//                }
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: 180)
//        .background(Color.elavated)
//        .cornerRadius(10)
//    }
//    
//    // Function to format Timestamp to Time
//    private func formattedTime(_ date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm" // Date format: hour:minute (24-hour format)
//        return dateFormatter.string(from: date)
//    }
//
//}
//
//
//
//struct reviewCard: View {
//    var reviewRating: Int
//    var review: String
//    var time: String
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Text("\(String(repeating: "⭐️", count: reviewRating))")
//                    .font(AppFont.actionButton)
//                Spacer()
//                Text("\(time)")
//                    .font(AppFont.actionButton)
//                    .foregroundStyle(.gray)
//            }
//            HStack {
//                Text("\(review)")
//                    .font(AppFont.smallReg)
//                Spacer()
//            }
//            .padding([.top, .bottom], 5)
//            Divider()
//                .background(Color.elavated)
//        }
//    }
//}




