
import UIKit
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //let console = ConsoleDestination()  // log to Xcode Console
        let file    = FileDestination()       // log to default swiftybeaver.log file - where is this file??????
        let cloud   = SBPlatformDestination(appID: "PVnwev", appSecret: "Logamjrppgai8XfjrIzbirnVAfbfnogv", encryptionKey: "841QdeeozricunMVxafJhy99sl6LnRfu")
        
        let url = try? FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        
        let fileURL = url?.appendingPathComponent("mentaid.log")
        //let fileURL = URL(string: "file:///Home/Local Files/mentaid.log")
        print(fileURL)
        file.logFileURL = fileURL
        //log.addDestination(console)
        log.addDestination(file)
        
        let writeString = "Write this text to the fileURL as text in iOS using Swift"
        
        do {
            // Write to the file
            try writeString.write(to: fileURL!, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
        
        
        
        var readString = "" // Used to store the file contents
        do {
            // Read the file contents
            readString = try String(contentsOf: (fileURL)!)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        print("File Text: \(readString)")
        
        cloud.analyticsUserName = "Tester1"
        cloud.showNSLog         = false
        log.addDestination(cloud)
        
        log.info("Log 1")   // prio 3, INFO in green
        
        return true
    }

}
