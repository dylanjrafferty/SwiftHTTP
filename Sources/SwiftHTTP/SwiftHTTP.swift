import Foundation

let request = Request {
    URL(fileURLWithPath: "Testing123")
    
    Body(encoding: .json) {
        Data()
    }
    
    Header {
        KeyValue(key: "Authorization", value: "Bearer asdasdfdsads")
    }
}
