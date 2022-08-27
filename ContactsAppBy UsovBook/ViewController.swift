
import UIKit

class ViewController: UIViewController {
    private var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort { $0.title < $1.title }
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func showNewContactAlert() {
        //создание алерт контролера
        let alertController = UIAlertController(title: "Create new contact", message: "Enter name and phone number", preferredStyle: .alert)
        
        //добовляем первое текстовое поле в алерт контролер
        alertController.addTextField{ textField in
            textField.placeholder = "Name"
        }
        //добовляем второе текстовое поле в алерт контролер
        alertController.addTextField{ textField in
            textField.placeholder = "Phone number"
        }
        
        //создаем кнопки
        //кнопка создания контакта
        let createButton = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text else {return}
            
            // создаем новый контакт
            let contact = Contact(title: contactName, phoneNumber: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        //кнопка отмены
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //добавляем кнопки в алерт контролер
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        
        //отображаем алерт контролер
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //метод определяет, какое кол-во ячеек будет в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    //вариант создание ячейки номер 2 без повторного использования return
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Use old cell for row with index \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Create a new cell for row with index \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
}


extension ViewController {
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        //основной текст ячейки задается при помощи .text
        configuration.text = contacts[indexPath.row].title
        //дополнительный текст ячейки задается при помощи .phoneNumber
        configuration.secondaryText = contacts[indexPath.row].phoneNumber
        cell.contentConfiguration = configuration
    }
}

extension ViewController {
    private func loadContacts() {
        contacts.append(
        Contact(title: "Маникюр Света", phoneNumber: "+79001002021"))
        contacts.append(
        Contact(title: "Стилист Жанна", phoneNumber: "+79001002022"))
        contacts.append(
        Contact(title: "Лор", phoneNumber: "+79001002030"))
        contacts.append(
        Contact(title: "Ветеринарка", phoneNumber: "+79001002040"))
        contacts.append(
        Contact(title: "Обои для ванной", phoneNumber: "+79301002021"))
        contacts.append(
        Contact(title: "Не отвечать", phoneNumber: "+79101002022"))
        contacts.append(
        Contact(title: "Зубной", phoneNumber: "+79001202030"))
        contacts.append(
        Contact(title: "Мамуля", phoneNumber: "+79001302040"))
        contacts.sort{ $0.title < $1.title}
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //delete cell
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
    return actions
    }
}



/**
 //создание ячейки
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //значение для параметра reuseIdentifier устанавливается на "contactCellIndetifier"(MyCell) для экономии ресурсов и использования возможности "переиспользования ячейки" и делаем проверку на наличие такой ячейки
     guard var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") else {print("Create a new cell for row with index \(indexPath.row)")
         var newCell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
         //происходит конфигурация ячейки
         var configuration = newCell.defaultContentConfiguration()
         configure(cell: &newCell, for: indexPath)
//            configuration.text = "Row \(indexPath.row)"
//            newCell.contentConfiguration = configuration
         return newCell
     }
     print("Use old cell for row with index \(indexPath.row)")
     configure(cell: &cell, for: indexPath)
     return cell
 }
}
 */
 
