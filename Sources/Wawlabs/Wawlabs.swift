import Foundation


public struct Wawlabs {
    
    var ID : String
    var prefix: String
    var schema = "https://"
    var search = ".wawlabs.com/avx_wse?cm=conv&f=True&d=True&q="
    var recom = ".wawlabs.com/avx_eac?q="
    var didYouMean = ".wawlabs.com/avx_dym?q="
    
    
    init(id: String, specialDomain: String) { // Constructor
        self.prefix = specialDomain
        self.ID = id
    }
    
    
   public func recommendation(query: String) -> String {
        var body: String = ""

        let url = URL(string: self.schema + self.prefix + self.recom )
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                body = dataString
            }
            
        }
        task.resume()
        return body
    }
    
    public func didYouMean(query: String) -> String{
        var body: String = ""
        let url = URL(string: self.schema + self.prefix + self.didYouMean )
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                body = dataString
            }
            
        }
        task.resume()
        return body
    }
    
   public func search(query: String) -> String {
        var body: String = ""

        let url = URL(string: self.schema + self.prefix + self.search )
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                body = dataString
            }
            
        }
        task.resume()
        return body
    }
}
