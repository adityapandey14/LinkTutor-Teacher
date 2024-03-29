import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct TeacherHomePage: View{
    @StateObject var skillViewModel = SkillViewModel()
    @StateObject var viewModel = RequestListViewModel()
    @State private var selectedDate: Date = Date()
    @State var userId = Auth.auth().currentUser?.uid
    @StateObject var viewModel1 = listClassesScreenModel()
    @State var isShowingFilterViewPopup = false
    @ObservedObject var teacherViewModel = TeacherViewModel.shared
    @State private var isPresentingAddCourseSheet = false
    @State private var hasLoaded = false
    
        var body: some View{
        NavigationView {
            VStack{
                VStack{
                    
                    if let fullName = teacherViewModel.teacherDetails.first?.fullName {
                        let nameComponents = fullName.components(separatedBy: " ")
                        let firstName = nameComponents.first ?? ""
                        header(yourName: firstName)
                    }
                    
//                    NavigationLink(destination : addCoursePage()){
//                        HStack{
//                            Image(systemName: "plus")
//                            Text(" Add Class !")
//                            Spacer()
//                        }
//                        .font(AppFont.mediumSemiBold)
//                        .padding()
//                        .background(Color.accent)
//                        .foregroundStyle(Color.black)
//                        .cornerRadius(20)
//                    }
                    Button(action: {
                                isPresentingAddCourseSheet.toggle()
                            }) {
                                HStack {
//                                    Spacer()
//                                    Image("addClass2")
//                                        .resizable()
//                                        .frame(width: 140, height: 90)
//                                        .offset(y:5)
//                                    Spacer()
                                    Image(systemName: "plus")
                                    Text(" Add a Class !")
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: 28)
                                .font(AppFont.mediumSemiBold)
                                .padding()
                                .background(Color.accent)
                                .foregroundColor(Color.black) // Use foregroundColor instead of foregroundStyle
                                .cornerRadius(20)
                            }
                            .sheet(isPresented: $isPresentingAddCourseSheet) {
                                addCoursePage()
                            }
                    .padding(.top)
                }
                .padding(.bottom, 10)
                .onAppear {
                    Task {
                        let userId = Auth.auth().currentUser?.uid
                        await teacherViewModel.fetchTeacherDetailsByID(teacherID: userId!)
                    }
                }
                

                VStack{
                    //today classes section
                    HStack(){
                        Text("Your classes today")
                            .font(AppFont.mediumSemiBold)
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 15)
                    
                    //today classes cards
                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack{
                            if let classesForSelectedDate = classesForToday(), !classesForSelectedDate.isEmpty {
                                HStack{
                                    ForEach(classesForSelectedDate.filter { $0.teacherUid == userId && $0.requestAccepted == 1 }, id: \.id) { enrolledClass in
                                        calenderPage(className: enrolledClass.className, tutorName: enrolledClass.teacherName, startTime: enrolledClass.startTime.dateValue())
                                    }
                                }
                            } else {
                                VStack{
                                    Spacer()
                                    Text("Have a break, No classes today")
                                        .foregroundColor(.gray)
                                        .backgroundStyle(Color.red)
                                        .padding()
                                    Spacer()
                                }
                                .frame(height: 100)
                            }
//                        }
                    }
                    
                    //My cources section
                    SectionHeader(sectionName: "My classes", fileLocation: enrolledClassCardList())
                        .onTapGesture {
//                            viewModel.TeacherEnrolledClassFramework = TeacherEnrolledClasses(classdata: enrolledClassMockData.sampleClassData)
                        }
                    
                    
                    //My classes cards
                    ScrollView(.vertical, showsIndicators: false){
                        ScrollView(.horizontal, showsIndicators: false){
                            
                            ForEach(skillViewModel.skillTypes) { skillType in
                                //                            VStack {
                                HStack(spacing: 10) {
                                    ForEach(skillType.skillOwnerDetails) { detail in
                                        if detail.teacherUid == userId {
                                            enrolledClassCard(documentId: detail.id,
                                                              className: detail.className,
                                                              days: detail.week,
                                                              startTime: detail.startTime,
                                                              endTime: detail.endTime)
                                        }
                                    }
                                }
                                //                            }
                                .onAppear {
                                    // Fetch user ID and trigger fetching enrolled details
                                    if let currentUser = Auth.auth().currentUser {
                                        userId = currentUser.uid
                                        fetchEnrolledDetails(for: skillType)
                                    }
                                }
                            }
                        }
                       
                    }
                }
            } // v full end
            .padding()
            .background(Color.background)
        }
        .onAppear {
            viewModel.fetchEnrolledStudents()
        }
            
    }
    private func fetchEnrolledDetails(for skillType: SkillType) {
        // Ensure fetching is performed only once
        guard !hasLoaded else { return }
        
        // Fetch skill owner details
        Task {
             skillViewModel.fetchSkillOwnerDetails(for: skillType)
            hasLoaded = true
        }
    }
    
    func formattedWeekday(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func dateDescription(for date: Date) -> String {
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let selectedDay = Calendar.current.startOfDay(for: date)
        
        if selectedDay == today {
            return "Today, \(formattedWeekday(for: date))"
        } else if selectedDay == tomorrow {
            return "Tomorrow, \(formattedWeekday(for: date))"
        } else {
            return "Selected Date: \(formattedWeekday(for: date))"
        }
        
    }
    
    func classesForToday() -> [EnrolledStudent]? {
         return viewModel.enrolledStudents.filter { enrolledClass in
             enrolledClass.week.contains(formattedWeekday(for: Date()))
         }
     }
    
    func classesForSelectedDate() -> [EnrolledStudent]? {
         return viewModel.enrolledStudents.filter { enrolledClass in
             enrolledClass.week.contains(formattedWeekday(for: Date().addingTimeInterval(24 * 60 * 60)))
         }
     }
    
       
}

#Preview {
    TeacherHomePage()
}



