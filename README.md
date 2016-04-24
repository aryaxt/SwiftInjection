# SwiftInjection

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
