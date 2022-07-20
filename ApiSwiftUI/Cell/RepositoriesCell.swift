import SwiftUI

struct RepositoriesCell: View {
    
    var repo: Repositories
    
    var body: some View{
        VStack{
            HStack{
                // Rondom Color and Name
                ZStack{
                    Color.random
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    Text(String((repo.name.first!)).uppercased())
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                // Name and Fullname
                HStack{
                    VStack(alignment:.leading){
                        Text(repo.name)
                            .fontWeight(.black)
                            .foregroundColor(.black)
                        Text(repo.full_name)
                            .fontWeight(.bold)
                            .foregroundColor(.black.opacity(0.7))
                    }
                    Spacer()
                    VStack(alignment:.trailing){
                        Link(destination: URL(string: repo.html_url)!) {
                            Image(systemName: "link.circle.fill")
                                .font(.largeTitle)
                        }
                        
                    }
                }
            }
            Divider()
        }
        
    }
}

struct RepositoriesCell_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesCell(repo: Repositories(name: "Ilyos", full_name: "Maxmudov", html_url: "dsdc"))
    }
}

// Color Rondom
extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
