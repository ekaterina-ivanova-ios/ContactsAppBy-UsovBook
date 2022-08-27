
import Foundation

protocol ContactProtocol {
    var title: String {get set}
    var phoneNumber: String {get set}
}

struct Contact: ContactProtocol {
    var title: String
    
    var phoneNumber: String
    
    
}
