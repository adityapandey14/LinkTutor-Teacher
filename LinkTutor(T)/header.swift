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
                            .foregroundStyle(Color.white)
                            .font(AppFont.largeBold)
//                            .padding(.bottom, 1)
                        Spacer()
                        //myProfileView
                        NavigationLink(destination: myProfileView()){
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipped()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        }
                    }
                    Text("Ready to inspire minds today?")
                        .foregroundStyle(Color.white)
                        .font(AppFont.mediumReg)
                }
                Spacer()
                
                
            }
        }
    }
}

#Preview {
        header(yourName: "Emma")
}
