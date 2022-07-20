import SwiftUI
import SDWebImageSwiftUI

struct HomePage: View {
    static var UrlGithub = "https://api.github.com/users/Abduljamil32"
    @ObservedObject var viewModel = homeViewModel()
    @State var user: User
    
    var body: some View {
        NavigationView{
            VStack{
                if !user.avatar_url.isEmpty {
                    VStack{
                        HStack{
                            // User Image
                            ZStack{
                                RoundedRectangle(cornerRadius: 18).stroke(lineWidth: 5)
                                    .frame(width: 101, height: 101)
                                    .foregroundColor(Color.red)
                                WebImage(url: URL(string: user.avatar_url))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(18)
                            }
                            
                            Spacer()
                            // Followers and Following
                            VStack(spacing: 50){
                                
                                Text("Followers: ")
                                    .fontWeight(.medium)
                                    .font(.system(size: 17)) +
                                Text("\(user.followers)")
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                
                                Text("Following: ")
                                    .fontWeight(.medium)
                                    .font(.system(size: 17)) +
                                Text("\(user.following)")
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                
                            }.padding(.top).padding(.bottom)
                            
                            Spacer()
                        }
                        // Public repositories Count
                        HStack{
                            Text("Public repositories: ")
                                .fontWeight(.medium)
                                .font(.system(size: 17)) +
                            
                            Text("\(user.public_repos)")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            
                            Spacer()
                        }.padding(.leading)
                        
                        // User Location
                        //                        HStack{
                        //                            Text("Location: ")
                        //                                .fontWeight(.medium)
                        //                                .font(.system(size: 17)) +
                        //
                        //                            Text(user.location)
                        //                                .fontWeight(.bold)
                        //                                .font(.system(size: 20))
                        //
                        //                            Spacer()
                        //                        }.padding(.leading)
                        
                        // ScrollView  Repositories
                        ScrollView(showsIndicators: false){
                            if !viewModel.repo.isEmpty{
                                ForEach(0..<viewModel.repo.count, id: \.self){ item in
                                    
                                    RepositoriesCell(repo: viewModel.repo[item])
                                        .padding(.horizontal)
                                }
                            }else{
                                ProgressView()
                            }
                        }.padding(.top)
                        
                        
                    }.padding()
                } else {
                    ProgressView()
                    Text("No Internet")
                }
            }
            .navigationBarTitle(user.name, displayMode: .inline)
        }
        .onAppear{
            viewModel.getInfo(url: HomePage.UrlGithub) { user in
                print(user)
                self.user = user
                viewModel.getRepos(url: user.repos_url)
            }
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(user: User(avatar_url: "", followers: 1, following: 1, login: "", repos_url: "", name: "", public_repos: 1))
    }
}
