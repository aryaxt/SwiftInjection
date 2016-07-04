# SwiftInjection
[![Build Status](https://api.travis-ci.org/aryaxt/SwiftInjection.svg)](https://api.travis-ci.org/aryaxt/SwiftInjection)
[![Version](http://cocoapod-badges.herokuapp.com/v/SwiftInjection/badge.png)](http://cocoadocs.org/docsets/SwiftInjection)

A dependency container for Swift

#### Setting up Dependencies

A Module file is where you define your dependencies. The goal is to abstract out all your dependencies in this file. The only class in your project that should know about concrete implementations should be the module class, the rest of the classes in your application should be using these implementations through interfaces.

You could have multiple module classes in order to organize your dependencies
```swift
public class AppModule: DIModule {
	
	public func load(container: DIContainer) {
		container.bind(type: URLSession.self) { URLSession.shared() }
		container.bind(type: HttpService.self) { HttpClient(baseUrl: "https://api.github.com", urlSession: container.resolve(type: URLSession.self)) }
		container.bind(type: GithubService.self) { GithubHttpClient(httpService: container.resolve(type: HttpService.self)) }
		container.bind(type: UserDefaults.self, asSingleton: false) { UserDefaults.standard() }
		container.bind(type: AnalyticsTracker.self, named: GoogleAnalyticsTracker.analyticsIdentifier()) { GoogleAnalyticsTracker() }
		container.bind(type: AnalyticsTracker.self, named: AmplitudeAnalyticsTracker.analyticsIdentifier()) { AmplitudeAnalyticsTracker() }
	}
	
}

class AppDelegate: UIResponder, UIApplicationDelegate {
	override init() {
		super.init()
		DIContainer.instance.addModule(AppModule())
	}
}
```

#### Binding Internal classes
avoid direct use of singletons to make your code more testable
```swift
container.bind(type: URLSession.self) { URLSession.shared() }
```
#### Binding classes as singleton
Instead of adding singleton logic to your classes simply bind them as singleton
Note: Structs are not compatible with singleton pattern
```swift
// Bind class as singleton
bind(Session.self, asSingleton: true) { Session() }

// Bind protocol to an implementation as singleton
bind(AnalyticsTracker.self, asSingleton: true) { GoogleAnalyticsTracker() }
```
#### Bind Named Instances
In cases where you have multiple implementations for a single protocol you can use named binding to retrieve the correct instance
```swift
bind(AnalyticsTracker.self, named: "Google") { GoogleAnalyticsTraker() }
bind(AnalyticsTracker.self, named: "Amplitude") { AmplitudeAnalyticsTracker() }

// Inject expected instance
let googleAnalyticsTracker: AnalyticsTracker = inject(named: "Google")
let amplitudeAnalyticsTracker: AnalyticsTracker = inject(named: "Amplitude")

// Get all implementations for a given protocol (great for chain of responssibilities)
let trackers: [AnalyticsTracker] = injectAll()
```

#### Property Injection
Only use property injection on root level, for anything else below the viewController use constructor injection
```swift
class ViewController: UIViewController {
	let githubService: GithubService = inject() // Injects the implementation defined in module
	let session = inject(Session.self) // injects the singleton instance
	let analyticTrackers: [AnalyticsTracker] = injectAll() // Injects all implemetations of AnalyticsTracker
}
```

#### Constructor Injection
Simpy pass dependencies through the intiializer and define binding in the module file
```swift
protocol GithubService { }

protocol HttpService { }

class GithubHttpClient: GithubService {
	let httpService: HttpService
	// Constructor injection
	init(httpService: HttpService) {
		self.httpService = httpService
	}
}

class AppModule: DIModule {
	func load(container: DIContainer) {
		container.bind(type: URLSession.self) { URLSession.shared() }
		container.bind(type: HttpService.self) { HttpClient(baseUrl: "https://api.github.com", urlSession: container.resolve(type: URLSession.self)) }
		container.bind(type: GithubService.self) { GithubHttpClient(httpService: container.resolve(type: HttpService.self)) }
	}
}

class ViewController: UIViewController {
	// Property Injection
	// This will return an instance of GithubHttpClient with all depndencies as defined in module
	let githubService: GithubService = inject()
}
```

