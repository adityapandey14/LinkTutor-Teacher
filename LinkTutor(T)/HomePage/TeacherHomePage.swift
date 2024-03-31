import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct TeacherHomePage: View {
    @StateObject var skillViewModel = SkillViewModel()
    @StateObject var viewModel = RequestListViewModel()
    @State private var selectedDate: Date = Date()
    @State var userId = Auth.auth().currentUser?.uid
    @State var isShowingFilterViewPopup = false
    @ObservedObject var teacherViewModel = TeacherViewModel.shared
    @State private var isPresentingAddCourseSheet = false
    @State private var hasLoaded = false

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if let fullName = teacherViewModel.teacherDetails.first?.fullName {
                        let nameComponents = fullName.components(separatedBy: " ")
                        let firstName = nameComponents.first ?? ""
                        header(yourName: firstName)
                    }

                    Button(action: {
                        isPresentingAddCourseSheet.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text(" Add a Class !")
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 28)
                        .font(AppFont.mediumSemiBold)
                        .padding()
                        .background(Color.accent)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
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

                VStack {
                    // Today's classes section
                    HStack {
                        Text("My classes today")
                            .font(AppFont.mediumSemiBold)
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 15)
                    
                    // Today's classes cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        if let classesForSelectedDate = classesForToday(), !classesForSelectedDate.isEmpty {
                            VStack {
                                ForEach(classesForSelectedDate.filter { $0.teacherUid == userId && $0.requestAccepted == 1 }, id: \.id) { enrolledClass in
                                    calenderPage(className: enrolledClass.className, tutorName: enrolledClass.teacherName, startTime: enrolledClass.startTime.dateValue())
                                }
                            }
                        } else {
                            VStack {
                                Spacer()
                                Text("Have a break, No classes today")
                                    .foregroundColor(.gray)
                                    .padding()
                                Spacer()
                            }
                            .frame(height: 100)
                        }
                    }
                    
                    // My courses section
                    SectionHeader(sectionName: "My classes", fileLocation: enrolledClassCardList())

                    // My classes cards
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(skillViewModel.skillTypes) { skillType in
                            VStack() {
                                ForEach(skillType.skillOwnerDetails) { detail in
                                    if detail.teacherUid == userId {
                                        enrolledClassCard(documentId: detail.id,
                                                          className: detail.className,
                                                          days: detail.week,
                                                          startTime: detail.startTime.dateValue(),
                                                          endTime: detail.endTime.dateValue())
                                    }
                                }
                            }
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
                Spacer()
            } //vend
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
    
    func formattedWeekday(for timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func classesForToday() -> [EnrolledStudent]? {
        return viewModel.enrolledStudents.filter { enrolledClass in
            enrolledClass.week.contains(formattedWeekday(for: Timestamp(date: Date())))
        }
    }
}


#Preview {
    TeacherHomePage()
}



