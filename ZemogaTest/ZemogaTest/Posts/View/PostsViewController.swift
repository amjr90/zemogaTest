//
//  PostsViewController.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 17/08/22.
//
//  This template was created by AMJR
//

import Foundation
import UIKit
import Domain

class PostsViewController: UIViewController, PostsViewProtocol{
    
    var presenter: PostsPresenterProtocol?
    
    lazy var refreshIconButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath"), style: .plain, target: self, action: #selector(refresh))
        return item
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All","Favorites"])
        segmentedControl.addTarget(self, action: #selector(segmentedChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete All", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(deleteAllPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let refreshControl = UIRefreshControl()
    
    var posts: [Post] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.notifyViewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.notifyViewDidAppear()
    }
    
    func setTitle(){
        title = "Posts"
        navigationItem.rightBarButtonItems = [refreshIconButton]
    }
    
    func setupView(){
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(deleteButton)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor),
            segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -8),
            
            deleteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func showPosts(posts: [Post]) {
        self.posts = posts
        refreshControl.endRefreshing()
    }
    
    @objc func segmentedChanged(_ sender: UISegmentedControl){
        if let postFilter = PostFilter(rawValue: sender.selectedSegmentIndex){
            presenter?.segmentedControlChanged(postFilter: postFilter)
        }
    }
    
    @objc func deleteAllPressed(_ sender: UIButton){
        presenter?.deleteAllPressed()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.fetchPost()
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier) as? PostTableViewCell else {return UITableViewCell()}
        cell.configure(with: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.pushDetail(post: posts[indexPath.row])
    }
}
