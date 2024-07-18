//
//  CellsCreationViewController.swift
//  CellularFilling
//
//  Created by Станислава on 18.07.2024.
//

import UIKit

class CellsCreationViewController: UIViewController {

    private lazy var backgroundView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var createButton = UIButton()
    
    private let tableView = UITableView()
    private lazy var dataSource = makeDataSource()
    
    private var output: CellsCreationViewOutput

    init(output: CellsCreationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightPurpure
        
        setupBackgroundView()
        setupTitle()
        setupButton()
    }

    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.purpure?.cgColor ?? UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        backgroundView.layer.addSublayer(gradient)
        gradient.frame = backgroundView.bounds
        setupTableView()
    }
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = .black
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        titleLabel.text = Strings.title.rawValue
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setupButton() {
        createButton.backgroundColor = .lightPurpure
        createButton.setTitle(Strings.buttonTitle.rawValue, for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.layer.cornerRadius = 4
        
        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 36),
            createButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16)
        ])
        
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    @objc func createButtonTapped() {
        output.createButtonTapped()
    }
    
    private func scrollToBottom() {
        let numberOfSections = tableView.numberOfSections
        let numberOfRows = tableView.numberOfRows(inSection: numberOfSections-1)
        
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows-1, section: numberOfSections-1)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    private func setupTableView() {
        backgroundView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = dataSource
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
            tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -22)
        ])
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, cellModel in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
                fatalError("Cannot create Cell")
            }
            cell.configure(with: cellModel.type)
            cell.selectionStyle = .none
            return cell
        }
        return dataSource
    }
}

extension CellsCreationViewController: CellsCreationViewInput {
    func applySnapshot(cells: [CellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellModel>()
        snapshot.appendSections([.main])
        
        snapshot.appendItems(cells, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: true)
        scrollToBottom()
    }
}
                                            
extension CellsCreationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}

