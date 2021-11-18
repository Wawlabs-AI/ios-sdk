import Foundation
import UIKit

public struct Wawlabs {
    
    var ID : String
    var prefix: String
    var schema = "https://"
    var search = ".wawlabs.com/avx_wse?cm=conv&f=True&d=True&q="
    var recom = ".wawlabs.com/avx_eac?q="
    var didYouMean = ".wawlabs.com/avx_dym?q="
    
    
    public init(id: String, specialDomain: String, queries: String) { // Constructor
        self.prefix = specialDomain
        self.ID = id
        self.search = self.search + queries
    }
    
    
   public func recommendation(query: String) -> String {
       
        let url = URL(string: self.schema + self.prefix + self.recom + query )
        guard let requestUrl = url else { fatalError() }
       return self.fetchApi(url: requestUrl)
    }
    
    public func didYouMean(query: String) -> String{
        
         let url = URL(string: self.schema + self.prefix + self.didYouMean + query )
         guard let requestUrl = url else { fatalError() }
        return self.fetchApi(url: requestUrl)
    }
    
   public func search(query: String) -> String {
       
       
        let url = URL(string: self.schema + self.prefix + self.search + query )
        guard let requestUrl = url else { fatalError() }
       self.sendAnalytic()
       return self.fetchApi(url: requestUrl)
        // Create URL Request
     
    }
  
    func sendAnalytic() {
        
        let url = URL(string: "https://wa.wawlabs.com")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
       
        // Specify HTTP Method to use
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
       var deviceId: String = ""
       if let uuid = UIDevice.current.identifierForVendor?.uuidString {
           deviceId = uuid
       }
        
        let body = ["uid":self.ID,"ga":deviceId,"device_os":"ios"]
       let data  = try? JSONSerialization.data(withJSONObject: body)
              
        request.httpBody = data
        
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
               print("has been sent! \(dataString)")
            }
            
        }
        task.resume()
    }
    
    func fetchApi (url: URL) -> String{
        var body: String = ""
         var request = URLRequest(url: url)

         // Specify HTTP Method to use
         request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)
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
                 semaphore.signal()
                 
                 
             }
             
         }
         task.resume()
        semaphore.wait()
    
         return body
    }
}
