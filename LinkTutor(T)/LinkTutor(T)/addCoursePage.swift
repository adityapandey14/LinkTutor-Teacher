import SwiftUI
import MapKit
struct CustomSectionHeader: View {
    var title: String

    var body: some View {
        Text(title)
            .font(AppFont.smallSemiBold)
            .textCase(.none)// Customize background color as needed
    }
}
struct LocationPopupView: View {
    @Binding var isPresented: Bool
    @Binding var locationSearchText: String
    @Binding var selectedLocation: CLLocationCoordinate2D?

    var body: some View {
        VStack {
            Text("Choose Location")
                .font(.title)
                .padding()

            MapViewExample(searchString: $locationSearchText, selectedLocation: $selectedLocation)
                .ignoresSafeArea()

            Button("Done") {
                isPresented = false
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct addCoursePage: View {
    @State private var className = ""
    @State private var selectedDates: [Date] = []
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var locationSearchText = ""
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var classFee = ""
    @State private var feeType: FeeType = .monthly
    @State private var selectedMode: ClassMode = .online
    @State private var chooseDays: Day = .Monday
    @State private var selectedDays: [Day] = []
    @State private var isLocationPopupPresented = false
    
    
    enum FeeType: String, CaseIterable {
        case monthly = "Per Month"
        case yearly = "Per Year"
    }

    enum ClassMode: String, CaseIterable {
        case online = "Online"
        case offline = "Offline"
    }

    enum Day: String, CaseIterable {
        case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    }

    var body: some View {
        Form {
            // Class Details Section
            Section(header: CustomSectionHeader(title: "Class Details")) {
                TextField("Class Name", text: $className)

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

                DatePicker("Start Time", selection: $startTime, displayedComponents: [ .hourAndMinute])
                    .datePickerStyle(.compact)
                DatePicker("End Time", selection: $endTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.compact)

                HStack{
                    TextField("Location", text: $locationSearchText)
                    Button("Choose location") {
                        isLocationPopupPresented.toggle()
                    }
                    .foregroundColor(.red)
                    .sheet(isPresented: $isLocationPopupPresented) {
                        LocationPopupView(isPresented: $isLocationPopupPresented, locationSearchText: $locationSearchText, selectedLocation: $selectedLocation)
                    }
                }

            }
            .listRowBackground(Color.elavated)

            // Class Fee Section
            Section(header: CustomSectionHeader(title: "Class Fee")) {
                TextField("Fee", text: $classFee)
                Picker("Fee Type", selection: $feeType) {
                    ForEach(FeeType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .listRowBackground(Color.elavated)
            
            // Modes Section
            Section(header: CustomSectionHeader(title: "Modes")) {
                Picker("Select Mode", selection: $selectedMode) {
                    ForEach(ClassMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .listRowBackground(Color.elavated)
            
            // Buttons Section
            
            HStack {
                Button("Cancel") {
                    // Handle cancel action
                }
                .foregroundColor(.red)

                Spacer()

                Button("Add Class") {
                    // Handle add class action
                }
            }
        }
        .navigationTitle(Text("Add Class").font(.custom("SF Rounded", size: 22)))
        .background(Color.background)
        .scrollContentBackground(.hidden)
    }
}

struct addCoursePage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            addCoursePage()
        }
    }
}
