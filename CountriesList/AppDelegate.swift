import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: ME очевидно есть пара лишних строк
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainController          = CLMainTableViewController()
        let navigationController    = UINavigationController(rootViewController: mainController)
        
        window                      = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController  = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
}
