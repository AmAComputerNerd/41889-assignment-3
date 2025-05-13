# 41889-assignment-3
Assignment 3 for 41889 Application Development in the iOS Environment

## Collaborators
- AmAComputerNerd: Jonathon Thomson (25488154)
- Grimmace19: Kyan Grimm (25482187)
- TakedownChain23: Isaac Thomas (25341708)
- treggosaurus: Tristan Huang (25322025)

## Developer Guide
Things to keep in mind while developing!
### Adding a new View
When adding a new View, you must add it inside the <b>NavigationHelper</b> class, inside the <i>Helpers</i> folder. This class is responsible for the app's navigation, so any View which should be able to be navigated to needs to be added into the <code>viewFactories</code> dictionary in that file. The format will look something like below:
```swift
// ViewFactories for views with a default constructor.
// When making a new View you need to navigate to that DOESN'T need some kind of info passed to it, add it below:
private let viewFactories: [String: () -> AnyView] = [
  ReflectionHelper.getClassNameFromType(HomeView.self): { AnyView(HomeView()) },
  ...
  // Insert your view here
];
```
This is all you need to do to enable navigation to your View! Somewhat easy.

### Navigating to other views with NavigationManager
Navigation to a view can be set up using the navigationManager environment variable. This is an @EnvironmentObject which is accessible in all View classes. To add the navigationManager object to your View, try to replicate a setup like this:
```swift
class SomeView: View {
  @EnvironmentObject var navigationManager: NavigationManager;
  
  // Then you can use it like this:
  var body: some View {
      Button("Example Button") {
          navigationManager.navigate(to: MyView.self)
      }
  }
}
```
When running the app normally, this variable will be populated automatically and allow us to navigate to any View by just calling the NavigationManager.navigate() function! Don't forget to also edit the Preview() section at the bottom of the View! Previews work differently from running the app regularly, so your preview window will crash if you don't add in the environment object manually down there :(
```swift
#Preview {
    MyView()
        .environmentObject(NavigationManager()) // Adds a "dummy" object for NavigationManager()
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardSet.self, Flashcard.self]) // Adds a "dummy" DB that doesn't contain any data, in cases the View depends on some DB data.
}
```

### Using DataHelper in your View
If your View needs access to the User or any other kind of persistent data, you'll need to make a few modifications to be able to access the <b>DataHelper</b>, which controls DB-related functions in the app. 
Firstly, you'll need to add some functions inside your ViewModel like below:
```swift
private var dataHelper: DataHelper? = nil;
    
func refresh(modelContext: ModelContext) {
    if let dataHelper = dataHelper {
        dataHelper.refreshContext(modelContext: modelContext);
    } else {
        self.dataHelper = DataHelper(modelContext: modelContext);
    }
    
    // Populate any other variables that need access to persistent data below
    // e.g.
    self.user = self.dataHelper!.fetchUser();
}
```
We'll call the refresh() function in place of using an initialiser to set data. You can edit this function however you like by the way - add in extra parameters or do whatever, as long as the ModelContext is still passed in and the DataHelper is initialised this way it should all work! Once this function has been called, we can use the value stored in the dataHelper variable in any other function needed in our ViewModel.

Now that you've edited your ViewModel, we'll need to make some changes to the View too to call this new function. First up, we'll create an Environment variable for our ModelContext. At the top of the class, above the `var body = ...` declaration, add these lines:
```swift
// Assuming you already have a variable for your ViewModel set and for NavigationManager, if necessary.
@Environment(.\modelContext) private var modelContext;

...
// In the Previews code at the bottom of the View:
#Preview {
    MyView()
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardSet.self, Flashcard.self]) // This will ensure the Previews continue to work.
}
```
Now the slightly trickier bit - we need to call viewModel.refresh() once the page has loaded, but before any important activities can take place like button presses. We can use the .onAppear() hook for this. For example, see below a simple View - notice the .onAppear() hook at the end:
```swift
var body: some View {
    VStack {
        Text("Hello nerds")
    }
    .onAppear() {
        // Call the refresh() function, which will initialise all ViewModel variables and the DataHelper connection.
        viewModel.refresh(modelContext: modelContext)
    }
}
```
And we're done - your View should now be set up for DataHelper access!

### Add backgrounds to your page
If you wanna add background support, you'll first need to set up your page for DataHelper access above as you'll need access to the User object retrieved through DataHelper.fetchUser(). When you've got that, you should modify your View to match this template below:
```swift
var body: some View {
    ZStack {
        BackgroundView(spriteName: viewModel?.user.spriteName)
        // ... The rest of your View content, e.g.
        VStack {
            Text("EEEEE")
        }
    }
}
```
Now your page should dynamically update based on the user's selected background! :)

### DB not working?
If you've just pulled master and your DB is not working and saving data, it might be because SwiftData (the system we use for persistent data storage) can't automigrate the current data you have saved to the new schema. In this case, you can fix this error by deleting the app on the iPhone simulator that pops up when you press Run. This deletes all related data and should allow you to start fresh.

If you're still unsure, take a look at how FirstTimeSetupView and FirstTimeSetupViewModel were made - they're pretty simple and showcase all these ideas well.
