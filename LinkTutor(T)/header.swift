import SwiftUI

struct header: View{
    var yourName: String
    var body: some View{
        NavigationStack {
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        HStack{
                            Text("Hi")
                            Text(yourName)
                        }
                        .foregroundColor(.black)
                        .font(AppFont.largeBold)
//                            .padding(.bottom, 1)
                        Spacer()
                        //myProfileView
                        NavigationLink(destination: myProfileView()){
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipped()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                        }
                    }
                    Text("Ready to inspire minds today?")
                        .foregroundStyle(Color.black)
                        .font(AppFont.mediumReg)
                }
                Spacer()
            }
            .foregroundColor(.black)
        }
    }
}

//struct adding: View{
//    var body: some View{
//        
//    }
//}
//#Preview {
//    adding()
//}
#Preview {
        header(yourName: "Emma")
}
