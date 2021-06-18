import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.window = self.window ?? UIWindow()
        self.window!.rootViewController = SitesWireFrame.createSitesModule()
        self.window!.makeKeyAndVisible()
        guard scene is UIWindowScene else { return }
    }
}

