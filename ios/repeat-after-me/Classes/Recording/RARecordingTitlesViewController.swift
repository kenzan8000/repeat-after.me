import UIKit


/// Recording Titles List
class RARecordingTitlesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    /// Recording Titles List
    var recordingTitles: NSArray = []


    /// life cycle
    override func loadView() {
        super.loadView()

        self.recordingTitles = [
            "TEST1",
            "TEST2",
            "TEST3",
        ];
        self.tableView.registerClass(RARecordingTitlesRARecordingTitlesTableViewCell.self, forCellReuseIdentifier: "RARecordingTitlesRARecordingTitlesTableViewCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


/// UITableViewDelegate, UITableViewDataSource
extension RARecordingTitlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("pushRecordingViewController", sender: self)
    }

    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordingTitles.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "RARecordingTitlesRARecordingTitlesTableViewCell"
        var cell:RARecordingTitlesRARecordingTitlesTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as RARecordingTitlesRARecordingTitlesTableViewCell
/*
        if cell == nil {
            let nib:Array = NSBundle.mainBundle().loadNibNamed(identifier, owner: 0, options: nil)
            cell = nib[0] as? RARecordingTitlesRARecordingTitlesTableViewCell
        }
*/
        cell.textLabel?.text = recordingTitles[indexPath.row] as NSString

        return cell
    }
}
