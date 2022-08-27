
import UIKit

class ViewController: UIViewController {
    private var contacts = [ContactProtocol]()
    
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
    
    //    //создание ячейки
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        //значение для параметра reuseIdentifier устанавливается на "contactCellIndetifier"(MyCell) для экономии ресурсов и использования возможности "переиспользования ячейки" и делаем проверку на наличие такой ячейки
    //        guard var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") else {print("Create a new cell for row with index \(indexPath.row)")
    //            var newCell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
    //            //происходит конфигурация ячейки
    //            var configuration = newCell.defaultContentConfiguration()
    //            configure(cell: &newCell, for: indexPath)
    ////            configuration.text = "Row \(indexPath.row)"
    ////            newCell.contentConfiguration = configuration
    //            return newCell
    //        }
    //        print("Use old cell for row with index \(indexPath.row)")
    //        configure(cell: &cell, for: indexPath)
    //        return cell
    //    }
    //}
    
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


