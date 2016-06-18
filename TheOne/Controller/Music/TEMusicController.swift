//
//  TEMusicController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEMusicController: UIViewController {
    
    var pageView: TEPageableView!
    let viewModel = TEMusicViewModel()
    

    override func viewDidLoad() {
        
        setupView()
        
        setupData()
    }
    
    
    // MARK: - Private Method
    func setupView() {
        
        title = "音乐"
        
        setupCommentItem()
        
        pageView = TEPageableView(frame: self.view.bounds)
        pageView.dataSource = self
        pageView.viewDelegate = self
        
        view.addSubview(pageView)
        view.backgroundColor = UIColor.whiteColor()
        


    }
    
    func setupData() {
        
        viewModel.fetchIDList()
        
        viewModel.listReady.observeNext { [unowned self] in
            self.pageView.reloadData()
        }
        
    }
}

extension TEMusicController: TEPageableDataSource,TEPageableDelegate {
    
    // MARK: - Pageable Datasource
    func pageableView(pageView: TEPageableView) -> NSInteger {
        
        return viewModel.orders.value.count
    }
    
    func pageableView(pageView: TEPageableView, cardCellForColumnAtIndexPath indexPath: NSIndexPath) -> UIView {
        
        var cell = pageView.dequeueReusableCell() as? UITableView
        
        if cell == nil {
            
            cell = UITableView()
            cell!.delegate = self
            cell!.delegate = self
            cell!.estimatedRowHeight = 70.0
            cell!.rowHeight = UITableViewAutomaticDimension
            cell!.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
            cell!.registerNib(UINib.init(nibName: String(TECommentCell), bundle: nil), forCellReuseIdentifier: String(TECommentCell))
            
        }
        
        return cell!
    }
    
    // MARK: - Pageable Delegate
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        return view.bounds
    }
    
    
}

extension TEMusicController: UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        case 1:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TECommentCell), forIndexPath: indexPath) as! TECommentCell
            cell.content.text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa "
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)

        }
    }
    
    // MARK: - Delegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "相似歌曲"
        case 2:
            return "评论列表"
        default:
            return nil
        }
    }
    
}