import Foundation


struct Repositories : Decodable{
    
    var name: String
    var full_name: String
    var language: String?
    var html_url: String
}
