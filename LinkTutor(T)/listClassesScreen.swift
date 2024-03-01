import SwiftUI

struct listClassesScreen: View{
    @State private var showActionSheet = false
    @State private var selectedSortOption: SortOption = .lowToHigh
    @State private var selectedPrice: Double = 100.0 // Initial value for the slider
    var skillType: String
   // var classesData : classMockData

    enum SortOption: String, Identifiable {
        case lowToHigh = "Low to High"
        case highToLow = "High to Low"
        var id: String { self.rawValue }
    }
    
    var body: some View{
        NavigationView {
            ZStack{
                VStack{
                    accentHeader()
                    Spacer()
                }
                .ignoresSafeArea()
                VStack(alignment: .leading){
                    HStack{
                        Text("\(skillType)")
                            .font(AppFont.largeBold)
                        Spacer()
                        Button(action: {
                            showActionSheet.toggle()
                        }){
                            Image(systemName: "line.3.horizontal.decrease")
                                .resizable()
                                .clipped()
                                .frame(width: 25, height: 15)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(
                                title: Text("Filter Options"),
                                buttons: [
                                    .default(Text("Low to High Price")) {
                                        selectedSortOption = .lowToHigh
                                    },
                                    .default(Text("High to Low Price")) {
                                        selectedSortOption = .highToLow
                                    },
                                    .cancel(),
                                ]
                            )
                        }
                    }
                    .padding(.bottom, 15)
                    
                    Text("Relavent results")
                        .font(AppFont.smallReg)
                        .padding(.leading, 10)
                        .foregroundColor(Color.myGray)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10){
                            //Taking value from classesMockData
                            ForEach(classesMockData.classData) { classesData in
                                classPreviewCard(classData: classesData)
                            }

                        }
                    }.shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 12)
                    
                    Spacer()
                }
                .ignoresSafeArea()
                .padding([.top, .trailing, .leading])
                
            }
            //.background(gradientBackground())
            .background(Color.background)
        }
    }
}


#Preview {
    listClassesScreen(skillType: "Piano classes")
}


