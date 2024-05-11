import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var page: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btn: UIButton!
    var array = [String]()
    var lbl1array = [String]()
    var lbl2array = [String]()
    var lbl3array = [String]()
    var lbl4array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        apicall()
    }
func apicall()
    {
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/get_properties.php")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            // Inside the completion handler of your URLSession data task

            do {
                // Parse the JSON data
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    // Update your arrays with fetched data
                    for property in jsonArray {
                        if let title = property["title"] as? String,
                           let dealer = property["dealer_name"] as? String,
                           let detail = property["detail"] as? String,
                           let background_image = property["background_image"] as? String
                        {
                            self.array.append(background_image)
                            self.lbl3array.append(dealer)
                            self.lbl1array.append(title)
                            self.lbl2array.append(detail)
                        }
                    }
                    
                    // Reload the collection view to reflect changes
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.page.numberOfPages = self.array.count
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }

        }

        task.resume()

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
//        cell.img.image = UIImage(named: array[indexPath.row])
        if let imageURLString = array[indexPath.row] as? String, let imageURL = URL(string: imageURLString) {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    // Set the downloaded image to the UIImageView
                    cell.img.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        cell.lbl1.text = lbl1array[indexPath.row]
        cell.lbl2.text = lbl2array[indexPath.row]
        cell.lbl3.text = lbl3array[indexPath.row]
//        cell.lbl4.text = lbl4array[indexPath.row]
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
          
        if Int(pageIndex) == array.count - 1 {
              btn.isHidden = false
          } else {
              btn.isHidden = true
          }
      }
}
