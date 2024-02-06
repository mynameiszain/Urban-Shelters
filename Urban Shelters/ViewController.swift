import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var page: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btn: UIButton!
    
    var array = ["Unknown 1","Untitled-4","Untitled-14","2","Untitled-1"]
    var lbl1array = ["Malé, Maldives","Dhigurah, Maldives","Meeru Island, Maldives","Maalhos, Maldives","Baa Atoll, Maldives"]
    var lbl2array = ["3,027 kilometers away","2,870 Kilometer away","3,012 kilometers away","2,938 Kilometer away","2,950 Kilometers away"]
    var lbl3array = ["571$/night","765$/night","650$/night","163$/night","514$/night"]
    var lbl4array = ["Sajjad","Sajjad","Mubaashir","Sajjad","Ahsan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        page.numberOfPages = 5 // Set the number of pages according to your data
    }
    @IBAction func btnnext (_ sender : UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "SigninVC") as! SigninVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count // Return the number of items in your collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! onboardingcell
        cell.img.image = UIImage(named: array[indexPath.row])
        cell.lbl1.text = lbl1array[indexPath.row]
        cell.lbl2.text = lbl2array[indexPath.row]
        cell.lbl3.text = lbl3array[indexPath.row]
        cell.lbl4.text = lbl4array[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let pageIndex = round(scrollView.contentOffset.x / collectionView.frame.width)
          page.currentPage = Int(pageIndex)
          
          if Int(pageIndex) == 4 {
              btn.isHidden = false
          } else {
              btn.isHidden = true
          }
      }
}
