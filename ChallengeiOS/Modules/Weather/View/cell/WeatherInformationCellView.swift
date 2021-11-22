import UIKit

class WeatherInformationCellView: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fromNib()
        layer.masksToBounds = true
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setup(data: WheatherDataTableView) {
        titleLabel.text = data.week
        descriptionLabel.text = data.description
        
        guard let icon = URL(string: data.icon ?? "")
        else {
            return
        }

        weatherImage.load(url: icon)
    }
}
