
import Foundation

protocol ContactProtocol {
    var title: String {get set}
    var phoneNumber: String {get set}
}

struct Contact: ContactProtocol {
    var title: String
    var phoneNumber: String
    
}

protocol ContactStorageProtocol {
    //загрузка списка контактов
    func load() -> [ContactProtocol]
    //обновление списка контактов
    func save(contacts: [ContactProtocol])
}

class ContactStorage: ContactStorageProtocol {
    //ссылка на хранилище
    private var storage = UserDefaults.standard
    
    //ключ, по которому будет происходить сохранение хранилища
    private var storageKey = "contacts"
    
    //перечисление с ключами для записи в user defaults
    private enum ContactKey: String {
        case title
        case phoneNumber
    }
    
    func load() -> [ContactProtocol] {
        var resultContacts: [ContactProtocol] = []
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for contact in contactsFromStorage {
            guard let title = contact[ContactKey.title.rawValue],
                  let phoneNumber = contact[ContactKey.phoneNumber.rawValue] else {continue}
            resultContacts.append(Contact(title: title, phoneNumber: phoneNumber))
        }
        return resultContacts
    }
    
    func save(contacts: [ContactProtocol]) {
        var arrayForStorage: [[String:String]] = []
        contacts.forEach{ contact in
            var newElementForStorage: Dictionary<String,String> = [:]
            newElementForStorage[ContactKey.title.rawValue] = contact.title
            newElementForStorage[ContactKey.phoneNumber.rawValue] = contact.phoneNumber
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
    
    
}


