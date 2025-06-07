//
//  SceneDelegate.swift
//  HoldemStackTracker
//
//  Created by 江幡将太 on 2025/06/04.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // オプションで UIWindow `window` を設定し、提供された UIWindowScene `scene` にアタッチするには、このメソッドを使用します。
        // ストーリーボードを使用している場合、 `window` プロパティは自動的に初期化され、シーンにアタッチされます。
        // このデリゲートは接続するシーンやセッションが新しいことを意味しません（代わりに `application:configurationForConnectingSceneSession` を参照してください）。
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        
        let vc = FirstViewController()
        let navVC = UINavigationController(rootViewController: vc)

        window.rootViewController = navVC
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        // シーンがシステムから解放されるときに呼び出される。
        // これは、シーンがバックグラウンドに入った直後、またはセッションが破棄されたときに発生する。
        // シーンが次に接続したときに再作成できる、このシーンに関連するすべてのリソースを解放する。
        // そのセッションは必ずしも破棄されなかったので、シーンは後で再接続するかもしれません（代わりに `application:didDiscardSceneSessions` を参照してください）。
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        // シーンが非アクティブ状態からアクティブ状態に移動した時にコールされる。
        // このメソッドを使用して、シーンが非アクティブであった時に一時停止された（または、まだ開始されていない）タスクを再開します。
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        // シーンがアクティブ状態から非アクティブ状態に移行するときに呼び出される。
        // これは、一時的な中断（電話の着信など）により発生する可能性がある。
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        // シーンが背景から前景に遷移するときに呼び出される。
        // このメソッドを使用すると、背景に入るときに行われた変更を元に戻すことができます。
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        // シーンがフォアグラウンドからバックグラウンドに遷移するときに呼び出される。
        // このメソッドを使用してデータを保存し、共有リソースを解放し、シーンを現在の状態に戻すのに十分なシーン固有のステート情報を保存する。
    }


}
