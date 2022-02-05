#  PlutoView

**If you interested to know how `Pluto` had developed you can check my articles on medium**
- [Part 1](https://medium.com/swiftcairo/collapse-expand-headerview-with-tabs-part1-3fbad61d9028)
- [Part 2](https://medium.com/swiftcairo/collapse-expand-headerview-with-tabs-part-2-50913875ddd2)

`PlutoView` is swift library for iOS to add Collapse / Expand header view with horizontal scroll tabs.

# Main Tabs
- There is 3 main tabs in Pluto `ScrollViewTab`, `TableViewTab`, `CollectionViewTab`

1- **TableViewTab**
- You can use this Tab to handle your data in table and you can access tableView inside the tab to register cells and other property for table 
```swift
class FirstTab : TableViewTab {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func initViews () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell" )
        tableView.backgroundColor = .white
    }
}
```
2- **CollectionViewTab**
- You can use this Tab to handle your data in collectionView and you can access UICollectionView inside the tab to register cells and other property for collectionView

```swift
class SecondTab : CollectionViewTab {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func initViews () {
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CellImage.self , forCellWithReuseIdentifier: "cell")
    }
}
```
3- **ScrollViewTab**
- In this tab you can acess scrollView and the view inside it with call `parentView`, You can add your component inside `parentView`, but when you need to add bottom anchor for the last component you can use function `addBottomAnchor(view : UIView , constant : CGFloat)` and pass last component and positive constant from bottom like the [example](https://github.com/Yusef-Naser/PlutoView/blob/master/PlutoExample/cells/FirstTab.swift).

# how to use.
- You can use Pluto with 2 methods "adding a header " and "without header"

## Adding a header
- You can use this code to init PlutoView and adding header
```swift
import UIKit
import PlutoView
class ViewController: UIViewController {
     private lazy var collapse  : PlutoView = {
         let l = PlutoView(maxHeightType: .fixed(float: 250) , headerMinHeight: 70 )
         l.delegate = self
         l.registerTabs(tabs: [FirstTab.self  , SecondTab.self , ThirdTab.self])
         return l
     }()
     
     private let headerView : HeaderView = {
         let l = HeaderView()

         return l
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         view = collapse
         collapse.addHeader(header: headerView )
     }
 }
 
 extension ViewController : PlutoDelegate {
     func getPageIndex(page: Int) {

     }
     func didScrollView(_ scrollView: UIScrollView) {
         
     }
     func getCountTabs() -> Int {
        return 3
     }
     func tabForIndex(index: Int) -> TabCell? {
         if index == 0 {
             getPageIndex(page: 0)
             let cell = collapse.initTab(type: FirstTab.self, index: index ) as! FirstTab
             return cell
         }else if index == 1 {
             let cell = collapse.initTab(type: SecondTab.self , index: index ) as! SecondTab
             return cell
         }else if index == 2 {
             let cell = collapse.initTab(type: ThirdTab.self , index: index ) as! ThirdTab
             return cell
         }
         return nil
     }
 }
```
- in `PlutoDelegate` you must implement 4 functions
        1- **getPageIndex**
        - use this function when scroll from tab to another
        2- **didScrollView**
        - use this function when collapse / expand header
        3- **getCountTabs**
        - return count of tabs
        4- **tabForIndex**
        - You can use function `initTab` to init tabs and you can access these tabs

## Without header
- You can just create object from PlutoView by pass none property
and use it as Tabs only instead of creating collectionView and handle horizontal scroll for tabs
```swift
private lazy var collapse  : PlutoView = {
    let l = PlutoView(maxHeightType: .none , headerMinHeight: 70  )
    l.delegate = self
    l.registerTabs(tabs: [FirstTab.self  , SecondTab.self , ThirdTab.self])
    return l
}()
```

## Author
### Yusef Naser

- [Twitter](https://twitter.com/yusef_naser93)
- [GitHub](https://github.com/Yusef-Naser)
- [Linkedin](https://www.linkedin.com/in/yusef-naser-485b7710a)


## License
`PlutoView` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
