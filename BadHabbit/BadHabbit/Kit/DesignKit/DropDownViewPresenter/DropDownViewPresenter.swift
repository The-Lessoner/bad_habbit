//
//  DropDownViewPresenter.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 16.07.23.
//

import UIKit
import SnapKit

protocol DropDownViewPresenterProtocol {
    func showDropDown(preferredSize: CGSize, animated: Bool)
}

extension DropDownViewPresenterProtocol {
    func showDropDown() {
        showDropDown(
            preferredSize: CGSize(
                width: UIView.noIntrinsicMetric,
                height: UIView.noIntrinsicMetric
            ),
            animated: true
        )
    }
}

final class DropDownViewPresenter: DropDownViewPresenterProtocol {
    
    typealias Config = DropDownViewPresenterConfig
    
    var hideOnTapOutside: Bool
    
    var dropDownOffset: CGFloat
    
    private weak var view: UIView?
    private weak var dropDownView: UIView?
    
    private lazy var overlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(overlayTapped)
        ))
        return view
    }()
    
    init(view: UIView, dropDownView: UIView, config: Config = .init()) {
        self.view = view
        self.dropDownView = dropDownView
        
        self.hideOnTapOutside = config.hideOnTapOutside
        self.dropDownOffset = config.dropDownOffset
    }
        
    func showDropDown(
        preferredSize: CGSize,
        animated: Bool
    ) {
        guard
            let view,
            let dropDownView,
            let window = UIApplication.shared.activeWindow
        else {
            return
        }
        
        window.addSubview(overlay)
        
        overlay.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        let viewFrameInWindow = view.convert(view.bounds, to: window)
        
        if let snapshot = view.snapshotView(afterScreenUpdates: false) {
            overlay.addSubview(snapshot)
            snapshot.frame = viewFrameInWindow
        }
        
        overlay.addSubview(dropDownView)
        
        let targetFrame = calculateDropDownFrame(
            viewFrame: viewFrameInWindow,
            windowFrame: window.frame,
            preferredSize: CGSize(
                width: preferredSize.width == UIView.noIntrinsicMetric ? view.frame.width : preferredSize.width,
                height: preferredSize.height == UIView.noIntrinsicMetric ? dropDownView.frame.height : preferredSize.height
            )
        )
        
        if animated {
            let initialFrame = CGRect(
                x: targetFrame.minX,
                y: targetFrame.minY,
                width: targetFrame.width,
                height: 0
            )
            
            dropDownView.frame = initialFrame
            overlay.backgroundColor = UIColor.clear
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut]) {
                dropDownView.frame = targetFrame
                self.overlay.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            }
        } else {
            dropDownView.frame = targetFrame
            overlay.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
    }
    
    func hideDropDown(animated: Bool = true) {
        guard let dropDownView else {
            return
        }
        
        let resetViews = {
            self.overlay.subviews.forEach { view in view.removeFromSuperview() }
            self.overlay.removeFromSuperview()
        }
        
        if animated {
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {
                    dropDownView.frame = CGRect(
                        origin: dropDownView.frame.origin,
                        size: CGSize(width: dropDownView.frame.width, height: 0.0)
                    )
                    self.overlay.backgroundColor = UIColor.clear
                },
                completion: { _ in resetViews() }
            )
        } else {
            resetViews()
        }
    }
    
    private func calculateDropDownFrame(viewFrame: CGRect, windowFrame: CGRect, preferredSize: CGSize) -> CGRect {
        let width: CGFloat
        let height: CGFloat
        let x: CGFloat
        let y: CGFloat
        
        width = min(windowFrame.width, preferredSize.width)
        
        let maxAvailableHeight = windowFrame.height - (viewFrame.maxY + dropDownOffset)
        height = min(maxAvailableHeight, preferredSize.height)
        
        if viewFrame.midX - width / 2 <= 0 {
            x = 0
        } else if viewFrame.midX + width / 2 >= windowFrame.maxX {
            x = windowFrame.maxX - width
        } else {
            x = viewFrame.midX - width / 2
        }
        
        y = viewFrame.maxY + dropDownOffset
        
        return .init(x: x, y: y, width: width, height: height)
    }
    
    @objc
    private func overlayTapped() {
        hideDropDown()
    }
}

extension UIApplication {
    var activeWindow: UIWindow? {
        let scene = connectedScenes.first {
            $0.activationState == .foregroundActive && $0 is UIWindowScene
        }
        let windowScene = scene as? UIWindowScene
        let window = windowScene?.windows.first(where: \.isKeyWindow)
        return window
    }
}
