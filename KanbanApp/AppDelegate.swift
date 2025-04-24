import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Solicita autorização para notificações push ao iniciar o app
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permissão de notificações: \(granted)")
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        return true
    }
    
    // Recebe o device token e imprime-o (você pode enviá-lo ao seu backend, se necessário)
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
        // Opcional: chame um método no NetworkManager para enviar o token ao seu backend
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Falha no registro de notificações: \(error)")
    }
}
