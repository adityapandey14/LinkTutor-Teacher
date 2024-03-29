//import SwiftUI
//
//struct TeacherTimetableClass: Identifiable, Hashable {
//    let id: UUID
//    var className: String
//    var tutorName: String
//    var classStartTime: Date
//    var classEndTime: Date
//}
//
//struct teachersTimetablePageSwiftUIView: View {
//    var allClasses: [TeacherTimetableClass] // Update the type to TeacherTimetableClass
//    @State private var selectedDate: Date = Date()
//    @State private var isShowingFilterViewPopup = false
//    
//    var body: some View {
//                
//                VStack(alignment: .leading) {
//                    HStack {
//                        Text("My Timetable")
//                            .font(AppFont.largeBold)
//                            
//                        Spacer()
//
//                        Button(action: {
//                            isShowingFilterViewPopup.toggle()
//                        }) {
//                            Image(systemName: "calendar")
//                                .foregroundColor(.accent)
//                                .font(.system(size: 30))
//                                .clipped()
//                        }
//                    }
//                    .padding(.bottom, 15)
//                    .sheet(isPresented: $isShowingFilterViewPopup, content: {
//                        VStack {
//                            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
//                                .datePickerStyle(GraphicalDatePickerStyle())
//                                .padding()
//
//                            HStack {
//                                Button("Clear") {
//                                    selectedDate = Date()
//                                    isShowingFilterViewPopup.toggle()
//                                }
//
//                                Spacer()
//
//                                Button("Apply") {
//                                    isShowingFilterViewPopup.toggle()
//                                }
//                            }
//                        }
//                        .padding()
//                    })
//                    .padding()
//                    
//                ScrollView {
//                        // Filtered classes section
//                        if formattedDate(date: selectedDate) != formattedDate(date: Date()) &&
//                            formattedDate(date: selectedDate) != formattedDate(date: Date().addingTimeInterval(24 * 60 * 60)) {
//                            HStack {
//                                Text("\(formattedDate(date: selectedDate))")
//                                    .font(AppFont.mediumSemiBold)
//                                    .padding()
//                                Spacer()
//                                Button("Clear") {
//                                    selectedDate = Date()
//                                    isShowingFilterViewPopup = false
//                                }
//                            }
//                            
//                            if filteredClasses.isEmpty {
//                                Text("No classes Found!")
//                                    .font(.title)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.black)
//                                    .padding([.horizontal, .vertical], 15)
//                                    .background(Color.white)
//                                    .cornerRadius(20)
//                            } else {
//                                ForEach(filteredClasses, id: \.self) { timetableClass in
//                                    TimeTableCardSwiftUIView(
//                                        className: timetableClass.className,
//                                        tutorName: timetableClass.tutorName,
//                                        classStartTime: timetableClass.classStartTime,
//                                        classEndTime: timetableClass.classEndTime
//                                    )
//                                }
//                            }
//                        }
//
//
//                        // Today's classes section
//                        HStack{
//                            Text("Today")
//                                .font(AppFont.mediumSemiBold)
//                                .padding()
//                            Spacer()
//                        }
//
//                        VStack(spacing: 10){
//                            ForEach(todayClasses, id: \.self) { timetableClass in
//                                TimeTableCardSwiftUIView(
//                                    className: timetableClass.className,
//                                    tutorName: timetableClass.tutorName,
//                                    classStartTime: timetableClass.classStartTime,
//                                    classEndTime: timetableClass.classEndTime
//                                )
//                            }
//                        }
//
//                        // Tomorrow's classes section
//                        HStack{
//                            Text("Tomorrow")
//                                .font(AppFont.mediumSemiBold)
//                                .padding()
//                            Spacer()
//                        }
//
//                        VStack(spacing: 10){
//                            ForEach(tomorrowClasses, id: \.self) { timetableClass in
//                                TimeTableCardSwiftUIView(
//                                    className: timetableClass.className,
//                                    tutorName: timetableClass.tutorName,
//                                    classStartTime: timetableClass.classStartTime,
//                                    classEndTime: timetableClass.classEndTime
//                                )
//                            }
//                        }
//                    }
//                    .padding()
//                }//enddd
//                .background(Color.background)
//    }
//    
//    
//
//    private func formattedDate(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd - MM - yyyy"
//        return formatter.string(from: date)
//    }
//
//    private var todayClasses: [TeacherTimetableClass] {
//        return filterClasses(for: Date())
//    }
//
//    private var tomorrowClasses: [TeacherTimetableClass] {
//        return filterClasses(for: Date().addingTimeInterval(24 * 60 * 60))
//    }
//
//    private var filteredClasses: [TeacherTimetableClass] {
//        filterClasses(for: selectedDate)
//    }
//
//    private func filterClasses(for date: Date) -> [TeacherTimetableClass] {
//        return allClasses.filter { timetableClass in
//            let calendar = Calendar.current
//            return calendar.isDate(timetableClass.classStartTime, inSameDayAs: date)
//        }
//    }
//}
//
//struct teachersMyTimetablePageSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        teachersTimetablePageSwiftUIView(allClasses: [
//            TeacherTimetableClass(
//                id: UUID(),
//                className: "Math",
//                tutorName: "John Doe",
//                classStartTime: Date(),
//                classEndTime: Date().addingTimeInterval(3600)
//            ),
//            TeacherTimetableClass(
//                id: UUID(),
//                className: "History",
//                tutorName: "Jane Smith",
//                classStartTime: Date().addingTimeInterval(86400),
//                classEndTime: Date().addingTimeInterval(90000)
//            ),
//            TeacherTimetableClass(
//                id: UUID(),
//                className: "English",
//                tutorName: "Carol",
//                classStartTime: Date().addingTimeInterval(2 * 24 * 60 * 60),
//                classEndTime: Date().addingTimeInterval(2 * 24 * 60 * 60 + 3600)
//            ),
//        ])
//    }
//}
