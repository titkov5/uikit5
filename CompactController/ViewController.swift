
import UIKit

class ViewController: UIViewController {
    
    let selectMeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(selectMeButton)
        selectMeButton.backgroundColor = .darkGray
        selectMeButton.layer.cornerRadius = 5
        selectMeButton.addTarget(self, action: #selector(showSubController), for: .touchUpInside)
        selectMeButton.setTitle("Tap on me", for: .normal)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        selectMeButton.frame = CGRect(x: view.center.x - 50, y: 150, width: 100, height: 44)
    }

    @objc
    func showSubController() {
        let popoverVC = PopoverViewController()
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.sourceView = selectMeButton
        popoverVC.popoverPresentationController?.permittedArrowDirections = .up
        popoverVC.popoverPresentationController?.delegate = self
        self.present(popoverVC, animated: true, completion: nil)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

class PopoverViewController: UIViewController {
    let segmentControl = UISegmentedControl(items: ["280", "150"])
    let closseButton = UIButton(type: .close)

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.preferredContentSize = CGSize(width: 300, height: 280)
        segmentControl.selectedSegmentIndex = 0
        self.view.addSubview(segmentControl)
        self.view.addSubview(closseButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentControl.frame = CGRect(x: view.center.x - 70.0, y: 20.0, width: 140, height: 44)
        segmentControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)

        closseButton.frame = CGRect(x: view.frame.width  - 54.0, y: 20, width: 44, height: 44)
        closseButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }

    @objc
    func close() {
        self.dismiss(animated: true)
    }

    @objc
    func valueChanged() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            if self.segmentControl.selectedSegmentIndex == 0 {
                preferredContentSize = CGSize(width: 300, height: 280)
            } else {
                preferredContentSize = CGSize(width: 300, height: 150)
            }
        }
    }
}
