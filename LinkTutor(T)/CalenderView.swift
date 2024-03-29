import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CalendarView: View {
    @StateObject var viewModel = RequestListViewModel()
    @State private var selectedDate: Date = Date()
    let userId = Auth.auth().currentUser?.uid

    
    let calendar = Calendar.current
    
    var body: some View {
        VStack(alignment: .leading){
            Text("My Timetable")
                .font(AppFont.largeBold)
                .padding()
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(CompactDatePickerStyle())
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color.elavated)
                .cornerRadius(10)

            Text(dateDescription(for: selectedDate))
                            .font(.headline)
                            .padding()
            
            VStack(spacing: 10){
                if let classesForSelectedDate = classesForSelectedDate(), !classesForSelectedDate.isEmpty {
                    ForEach(classesForSelectedDate.filter { $0.teacherUid == userId && $0.requestAccepted == 1 }, id: \.id) { enrolledClass in
                        
                        if enrolledClass.requestAccepted == 0 {
                            Text("Have a break No classes today")
                                .foregroundColor(.gray)
                                .padding()
                        }
                        else {
                            calenderPage(className: enrolledClass.className, tutorName: enrolledClass.teacherName, startTime: enrolledClass.startTime.dateValue())
                        }
                       
                    } 

                }
            }

            
            if Calendar.current.startOfDay(for: selectedDate) == Calendar.current.startOfDay(for: Date()) {
                Text(dateDescription(for: selectedDate.addingTimeInterval(24 * 60 * 60)))
                                .font(.headline)
                                .padding()
                
            VStack(spacing: 10) {
                    
                    if let classesForSelectedDate = classesForNextToSelectedDate(), !classesForSelectedDate.isEmpty {
                        if let userId = Auth.auth().currentUser?.uid {
                            ForEach(classesForSelectedDate, id: \.id) { enrolledClass in
                                if enrolledClass.teacherUid == userId {
                                    calenderPage(className: enrolledClass.className, tutorName: enrolledClass.teacherName, startTime: enrolledClass.startTime.dateValue())
                                }
                            }
                        }
                    } else {
                        Text("No classes found")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }

            }
            
            Spacer()
        }
        .padding()
        .background(Color.background)
        .onAppear {
            viewModel.fetchEnrolledStudents()
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
            return "Selected Day: \(formattedWeekday(for: date))"
        }
        
    }
    
    func classesForSelectedDate() -> [EnrolledStudent]? {
         return viewModel.enrolledStudents.filter { enrolledClass in
             enrolledClass.week.contains(formattedWeekday(for: selectedDate))
         }
     }
    
    func classesForNextToSelectedDate() -> [EnrolledStudent]? {
         return viewModel.enrolledStudents.filter { enrolledClass in
             enrolledClass.week.contains(formattedWeekday(for: selectedDate.addingTimeInterval(24 * 60 * 60)))
         }
     }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
    
