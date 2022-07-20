import Foundation
import SwiftUI

class homeViewModel: ObservableObject{
    @Published var repo = [Repositories]()
    
    func getInfo(url: String, completion: ((User)->Void)? = nil){
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }else{
                guard let data = data, let response = response as? HTTPURLResponse else {
                    print("ERROR: Couldn't read response object")
                    return
                }
                guard response.statusCode == 200 else {
                    print("ERROR: Server responded status \(response.statusCode)")
                    return
                }
                
                let decoder = JSONDecoder()
                let usr = try! decoder.decode(User.self, from: data)
                
                completion?(usr)
            }
        }
        .resume()
    }
    
    func getRepos(url: String){
        
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, _, _) in
            let result = try! JSONDecoder().decode([Repositories].self, from: data!)
            
            DispatchQueue.main.async {
                self.repo = result
            }
            
        }
        .resume()
    }
}
