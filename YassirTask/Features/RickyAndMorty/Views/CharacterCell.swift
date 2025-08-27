//
//  CharacterCell.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//
import UIKit

final class CharacterCell: UITableViewCell {
    static let reuseId = "CharacterCell"
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(speciesLabel)
        
        hStack.addArrangedSubview(avatarImageView)
        hStack.addArrangedSubview(vStack)
        
        container.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            hStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])
        
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        
        // Set background tint by status
        switch character.status.lowercased() {
        case "alive":
            container.backgroundColor = UIColor.clear
            container.layer.borderWidth = 1
            container.layer.borderColor = UIColor.systemGray5.cgColor
        case "dead":
            container.backgroundColor =  UIColor(red: 251/255, green: 231/255, blue: 235/255, alpha: 1)
        default:
            container.backgroundColor =  UIColor(red: 235/255, green: 246/255, blue: 251/255, alpha: 1)
        }

        if let url = URL(string: character.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self?.avatarImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
