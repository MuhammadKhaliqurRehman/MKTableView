//
//  MKTableView.swift
//  MKRoundRectTableView
//
//  Created by Muhammad Khaliq ur Rehman on 04/02/2017.
//  Copyright © 2017 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

@IBDesignable
class MKTableView: UITableView {

    
    //MARK: - Class Properties
    
    // For Cell Corner Radius
    @IBInspectable
    var cellCornerRadius: CGFloat = 10.0
    
    // For Cell Padding From Left and Right
    @IBInspectable
    var cellPaddingX: CGFloat = 20.0
    
    // For Cell Separator Color
    @IBInspectable
    var cellSeparatorColor: UIColor = UIColor.groupTableViewBackground
    
    // For Cell Separator Padding From Left
    @IBInspectable
    var cellSeparatorPaddingX: CGFloat = 0.0
    
    // For Cell Background Color
    @IBInspectable
    var cellBackgroundColor: UIColor = UIColor.white
    
    // For Section Header Background Color
    @IBInspectable
    var sectionHeaderBackgroundColor: UIColor = UIColor.clear
    
    // For Section Header Title Text Background Color
    @IBInspectable
    var sectionHeaderTitleBackgroundColor: UIColor = UIColor.darkGray
    
    // For Section Header Height
    @IBInspectable
    var headerHeight: CGFloat = 35
    
    // For Section Footer Background Color
    @IBInspectable
    var sectionFooterBackgroundColor: UIColor = UIColor.clear
    
    // For Section Footer Title Text Background Color
    @IBInspectable
    var sectionFooterTitleBackgroundColor: UIColor = UIColor.lightGray
    
    // For Section Footer Height
    @IBInspectable
    var footerHeight: CGFloat = 25
    
    
    //MARK: - Init Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    
    //MARK: - Public Methods
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView(tableView, willDisplay: cell, forRowAt: indexPath, with: tableView.backgroundColor!)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int, withTitle title: String) -> UIView? {
        return self.tableView(tableView, viewForHeaderInSection: section, withTitle: title, andBackground: sectionHeaderBackgroundColor)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int, withTitle title: String) -> UIView? {
        return self.tableView(tableView, viewForFooterInSection: section, withTitle: title, andBackground: sectionFooterBackgroundColor)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    
    //MARK: - Private Methods
    private func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath, with backgroundColor: UIColor) {
        
        cell.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
        cell.selectionStyle = .none
        
        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: cellPaddingX, dy: 0)
        
        var addLine = false
        
        // If Section has only One Row
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cellCornerRadius, cornerHeight: cellCornerRadius)
            
            // If First Row
        } else if indexPath.row == 0 {
            
            pathRef.move(to: CGPoint(x: CGFloat(bounds.minX), y: CGFloat(bounds.maxY)), transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: CGFloat(bounds.minX), y: CGFloat(bounds.minY)), tangent2End: CGPoint(x: CGFloat(bounds.midX), y: CGFloat(bounds.minY)), radius: CGFloat(cellCornerRadius), transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: CGFloat(bounds.maxX), y: CGFloat(bounds.minY)), tangent2End: CGPoint(x: CGFloat(bounds.maxX), y: CGFloat(bounds.midY)), radius: CGFloat(cellCornerRadius), transform: .identity)
            pathRef.addLine(to: CGPoint(x: CGFloat(bounds.maxX), y: CGFloat(bounds.maxY)), transform: .identity)
            
            addLine = true
            
            // If Last Row
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
            pathRef.move(to: CGPoint(x: CGFloat(bounds.minX), y: CGFloat(bounds.minY)), transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: CGFloat(bounds.minX), y: CGFloat(bounds.maxY)), tangent2End: CGPoint(x: CGFloat(bounds.midX), y: CGFloat(bounds.maxY)), radius: CGFloat(cellCornerRadius), transform: .identity)
            pathRef.addArc(tangent1End: CGPoint(x: CGFloat(bounds.maxX), y: CGFloat(bounds.maxY)), tangent2End: CGPoint(x: CGFloat(bounds.maxX), y: CGFloat(bounds.midY)), radius: CGFloat(cellCornerRadius), transform: .identity)
            pathRef.addLine(to: CGPoint(x: CGFloat(bounds.maxX), y: CGFloat(bounds.minY)), transform: .identity)
            
            // If Middle Row
        } else {
            
            pathRef.addRect(bounds, transform: .identity)
            
            addLine = true

        }
        
        layer.path = pathRef
        layer.fillColor = cellBackgroundColor.cgColor
        if addLine {
            let lineLayer = CALayer()
            let lineHeight: CGFloat = (1.0 / UIScreen.main.scale)
            lineLayer.frame = CGRect(x: CGFloat(bounds.minX) + cellSeparatorPaddingX, y: CGFloat(bounds.size.height - lineHeight), width: CGFloat(bounds.size.width - cellSeparatorPaddingX), height: lineHeight)
            lineLayer.backgroundColor = cellSeparatorColor.cgColor
            layer.addSublayer(lineLayer)
        }
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        testView.backgroundColor = UIColor.clear
        cell.backgroundView = testView
    
    }
    
    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int, withTitle title: String, andBackground color: UIColor) -> UIView? {
        let headerViewFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width - (2 * cellPaddingX), height: 35)
        let headerView = UIView(frame: headerViewFrame)
        
        let headerLabelFrame = CGRect(x: cellPaddingX + 15, y: 10, width: tableView.frame.size.width - (2 * cellPaddingX), height: 2000)
        let headerLabel = UILabel(frame: headerLabelFrame)
        headerLabel.text = title
        headerLabel.textColor = sectionHeaderTitleBackgroundColor
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        headerLabel.sizeToFit()
        
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = sectionHeaderBackgroundColor
        
        return headerView
    }
    
    private func tableView(_ tableView: UITableView, viewForFooterInSection section: Int, withTitle title: String, andBackground color: UIColor) -> UIView? {
        let footerViewFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width - (2 * cellPaddingX), height: 25)
        let footerView = UIView(frame: footerViewFrame)
        
        let footerLabelFrame = CGRect(x: cellPaddingX + 15, y: 5, width: tableView.frame.size.width - (2 * cellPaddingX), height: 2000)
        let footerLabel = UILabel(frame: footerLabelFrame)
        footerLabel.text = title
        footerLabel.textColor = sectionFooterTitleBackgroundColor
        footerLabel.font = UIFont.systemFont(ofSize: 12)
        footerLabel.sizeToFit()
        
        footerView.addSubview(footerLabel)
        footerView.backgroundColor = sectionFooterBackgroundColor
        
        return footerView
    }
        
}
