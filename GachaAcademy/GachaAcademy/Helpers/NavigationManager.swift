//
//  NavigationManager.swift
//  Use with EnvironmentObject to easily navigate around the application programmatically.
//  Views without constructors / needed information can be instantiated by passing in the class of the view (ClassName.self).
//  Views with constructors can be instantiated using a closure, e.g. { AnyView(ViewName(info: "Yes")) }
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import Foundation
import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentView: AnyView = AnyView(FirstTimeSetupView()); // The instance to the View in which the nav manager is pointing to.
    @Published var supportsNavigation: Bool = false; // Whether this View should use a NavigationView UI element to handle in-view navigation (shows a back button in the top left). From there, NavigationLinks will handle that kind of navigation and the NavigationManager is used to reset or change the navigation stack to a View outside of that tree.
    
    // ViewFactories for views with a default constructor.
    // When making a new View you need to navigate to that DOESN'T need some kind of info passed to it, add it below:
    private let viewFactories: [String: () -> AnyView] = [
        ReflectionHelper.getClassNameFromType(FirstTimeSetupView.self): { AnyView(FirstTimeSetupView()) },
        ReflectionHelper.getClassNameFromType(HomeView.self): { AnyView(HomeView()) },
        ReflectionHelper.getClassNameFromType(GachaView.self): { AnyView(GachaView()) },
        ReflectionHelper.getClassNameFromType(ProfileView.self): { AnyView(ProfileView()) },
        ReflectionHelper.getClassNameFromType(SetSelectionView.self): { AnyView(SetSelectionView()) }
        ReflectionHelper.getClassNameFromType(QuizView.self): { AnyView(QuizView()) }
    ];
    
    func navigate(to: Any.Type? = nil, withParams: (() -> AnyView)? = nil, supportsNavigation: Bool = false) {
        self.supportsNavigation = supportsNavigation;
        // If Navigation is provided with a closure (complex navigation using withParams):
        if let factory = withParams {
            self.currentView = factory();
            return;
        // If Navigation is provided with a name (simple navigation using to):
        } else if let viewType = to {
            let viewName = ReflectionHelper.getClassNameFromType(viewType);
            if let factory = viewFactories[viewName] {
                self.currentView = factory();
                return;
            }
        }
        // Otherwise, if no conditions fit, show a blank page with text to let the developer / user know.
        self.currentView = AnyView(Text("Failed to navigate to the selected page - check your code. Have you referenced the view type incorrectly, or failed to add your new view to NavigationManager.viewFactories?"));
    }
}
