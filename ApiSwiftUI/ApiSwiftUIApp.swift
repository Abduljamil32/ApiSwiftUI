import SwiftUI

@main
struct ApiSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomePage(user: User(avatar_url: "", followers: 1, following: 1,  login: "", repos_url: "", name: "", public_repos: 1))
        }
    }
}
