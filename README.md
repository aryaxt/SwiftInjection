# SwiftInjection
[![Build Status](https://api.travis-ci.org/aryaxt/SwiftInjection.svg)](https://api.travis-ci.org/aryaxt/SwiftInjection)
[![Version](http://cocoapod-badges.herokuapp.com/v/SwiftInjection/badge.png)](http://cocoadocs.org/docsets/SwiftInjection)

A dependency container for Swift

#### Setup
```swift
public class AppModule: DIAbstractModule, DIModule {
	public func load() {
		bind(DatabaseAdapter.self) { MySqlAdapter() }
		bind(UserStorage.self) { UserStorage() }
		bind(Session.self, asSingleton: true) { Session() }
		bind(NSUserDefaults.self) { NSUserDefaults.standardUserDefaults() }
	}
}

class AppDelegate: UIResponder, UIApplicationDelegate {
	override init() {
		super.init()
		DIContainer.instance.addModule(AppModule())
	}
}
```

#### Binding
Bind protocol to implementation
```swift
bind(DatabaseAdapter.self) { MySqlAdapter() }
// Then when it needs to be injected
let dbAdapter = inject(DatabaseAdapter.self)
```
Bind as Singleton
```swift
bind(Session.self, asSingleton: true) { Session() }
// Then when it needs to be injected
let session = inject(Session.self)
```
Bind Named Instances
```swift
bind(AnalyticsTracker.self, named: "Google") { GoogleAnalyticsTraker() }
bind(AnalyticsTracker.self, named: "Amplitude") { AmplitudeAnalyticsTracker() }
// Then when it needs to be injected
let googleAnalyticsTracker = inject(AnalyticsTracker.self, named: "Google")
let arrayOfAnalyticsTrackers = injectAll(AnalyticsTracker.self)
```

#### Property Injection
```swift
class ViewController: UIViewController {
	let userStorage = inject(UserStorage.self) // new instance
	let session = inject(Session.self) // singleton instance
	let userDefaults = inject(NSUserDefaults.self) // shared instance
}
```

#### Constructor Injection
```swift
protocol DatabaseAdapter {  
   func execute(query: String) -> Result
}

class MySqlAdapter: DatabaseAdapter {  
   func execute(query: String) -> Result { /* Implementation */  }
}

class UserStorage {
   let databaseAdapter: DatabaseAdapter
   
   init(databaseAdapter: DatabaseAdapter = inject(DatabaseAdapter.self)) {
      self.databaseAdapter = databaseAdapter
   }
   
   func fetchUsers() -> Users {
      return databaseAdapter.execute(SOME_QUERY)
   }
}

// Add binding in module
bind(DatabaseAdapter.self) { MySqlAdapter() }
bind(UserStorage.self) { UserStorage() }

// Here we get a user storage that is using MySqlAdapter
let userStorage = inject(UserStorage.self)
```

#### Chain of Responssibilities
```swift
class ViewController: UIViewController {
	// Injects all instances of AnalyticsTracker protocol (GoogleAnalyticsTracker & AmplitudeAnalyticsTracker)
	// analyticsTrackers type is [AnalyticsTracker]
	let analyticsTrackers = injectAll(AnalyticsTracker.self)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		userDeanalyticsTrackers.forEach { $0.trackEvent("HomePage") }
	}
}
```

