import PVLibrary
import PVSupport
import PVLogging

import Reachability
import RealmSwift
import UIKit
import RxSwift

final class PVSystemsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var candidates: [System]
    private var path: URL?
    private var conflictsController: ConflictsController?
    private var size: CGSize?
    public init(size: CGSize, conflictsController: ConflictsController, path: URL, candidates: [System]) {
        self.conflictsController = conflictsController
        self.candidates = candidates
        self.path = path
        self.size = size
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        self.candidates=[];
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTableViewViewModels()
    }

    func generateTableViewViewModels() {
        let alertController = UIAlertController(title: "Choose a System", message: nil, preferredStyle: .actionSheet)
        //alertController.popoverPresentationController?.sourceView = self.view
        //alertController.popoverPresentationController?.sourceRect = self.tableView.rectForRow(at: indexPath)
        self.candidates.forEach { system in
            alertController.addAction(.init(title: system.name, style: .default, handler: { _ in
                self.conflictsController!.resolveConflicts(withSolutions: [self.path!: system])
                self.done()
            }))
        }
        alertController.addAction(.init(title: NSLocalizedString("Delete", comment: "Delete file"), style: .destructive, handler: { _ in
            self.conflictsController!.deleteConflict(path: self.path!)
            self.done()
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: { _ in
            self.done()
        }))
        self.addChildViewController(alertController, toContainerView: self.view)
    }
    
    @IBAction func done() {
        presentingViewController?.dismiss(animated: true) { () -> Void in }
    }
}
