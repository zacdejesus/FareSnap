import XCTest
import Combine
import MapKit
@testable import fareSnap 

class MockLocationManager: LocationManagerProtocol {
    @Published private(set) var userLocation: CLLocationCoordinate2D?
    
    var userLocationPublisher: AnyPublisher<CLLocationCoordinate2D?, Never> {
        $userLocation.eraseToAnyPublisher()
    }
    
    func requestPermission() {}
    func startUpdatingLocation() {}
    
    func simulateLocationUpdate(_ location: CLLocationCoordinate2D) {
        userLocation = location
    }
}

class ContentViewModelTests: XCTestCase {
    var sut: ContentViewModel!
    var mockLocationManager: MockLocationManager!
    
    override func setUp() {
        super.setUp()
        mockLocationManager = MockLocationManager()
        sut = ContentViewModel(locationManager: mockLocationManager)
    }
    
    override func tearDown() {
        sut = nil
        mockLocationManager = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.userLocation.latitude, 34.011_286, accuracy: 0.000001)
        XCTAssertEqual(sut.userLocation.longitude, -116.166_868, accuracy: 0.000001)
    }
    
    func testUserLocationUpdate() {
        let expectation = XCTestExpectation(description: "User location update")
        
        let newLocation = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
        
        let cancellable = sut.$userLocation.sink { location in
            if location.latitude == newLocation.latitude && location.longitude == newLocation.longitude {
                expectation.fulfill()
            }
        }
        
        mockLocationManager.simulateLocationUpdate(newLocation)
        
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }
    


}

