//
//  LocationManager.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var didUpdateLocation: ((CLLocationCoordinate2D) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationPermission() {
        print("Requesting location permission")
        locationManager.requestWhenInUseAuthorization()
        checkAuthorizationStatus()
    }

    func startUpdatingLocation() {
        print("Starting location updates")
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        print("Stopping location updates")
        locationManager.stopUpdatingLocation()
    }

    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        case .denied, .restricted:
            print("Location permission not granted")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("Unknown authorization status")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Updated location: \(location.coordinate)")
        didUpdateLocation?(location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationStatus()
    }
}
