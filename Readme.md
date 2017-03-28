# NavigationBarTransitioning

This project aims to provide a clean solution for navigation bar style transitioning along with a show or pop operation.

## Motivation

It's very hard to change only color of navigation bar between two view controllers in a navigation stack. Setting color in either view controller's view life cycle methods may work in the end but if we wanted to change the color interactively while going from one to the other, thing can get very challenging and you can find yourself pulling out all your hair.

This project provides two view controllers, a master and a detail. Think about master scene as a list of items. Detail scene provides a parallax header and a content for the selected item. As we have a parallax item on detail scene, it's fair enough to expect to see a transparent backgrounded navigation bar with an overlaid back button on the left and a possible action bar button on the right.

At this point we have a few possible show and pop operations:

- **'Show' from master**: This is a plain old push animation. No user interaction, no anything. We expect a smooth color transition on the navigation bar along with the push animation.

- **'Pop' from detail**: Just tap the back button and this is also a plain old pop animation. No user interaction on this one either. Again we expect a smooth color transition on the navigation bar along with the pop animation. But here's *problem #1*.

- ***Interactively* 'pop' from detail**: Swipe from the edge and see the smooth transition as you pop! But the *problem #2* arises when you just change your mind and decide to stick with detail scene. Return to the detail scene and watch navigation bar flicking in a manner of time.

## Things I've tried

### Subclassing UINavigationController

I've created a subclass of UINavigationController and overridden several methods for showing and popping view controllers and tried to animate changes there. 

Result: The same problems above.

### Subclassing UINavigationBar

Also I've tried subclassing UINavigationBar and overridden `pushItem(_:animated:)`, `popItem(animated:)`, and `setItems(_:animated:)` methods. I was thinking to animate navigation bar style change in these methods.

Result: UINavigationController doesn't call `pushItem(_:animated:)` but an internal method.

### Using UINavigationControllerDelegate

The last solution I've tried and I think most cleaner and simpler one is this. Also present in this repo. I'm simply using `navigationController(_:willShow:animated:)` method and using the view controller's `transitionCoordinator` to animate changes.

Result: The same problems above.

## Project structure

There are 4 main components.

- **NavigationController**: A UINavigationController subclass. Assigns itself as its own delegate and uses its `navigationController(_:willShow:animated:)` method. Also implements functions to call navigation bar style updates.

- **NavigationBar**: A UINavigationBar subclass. Provides style update functions and left as is in case of further modifications are needed.

- **NavigationItem**: A UINavigationItem subclass. Conforms to NavigationBarStyling protocol and provides a default value for `navigationBarStyle` property. View controllers have this class set as their navigation items in Main.storyboard file.

- **NavigationBarStyle**: Defines a navigation bar style with options which UINavigationBar provides by default for customizations. Also it's home to NavigationBarStyling protocol. There are two predefined styles by default.

## What do I want?

I want the community's help to solve the above problems! I'm sick of it already and very tired. I believe that there must be a way to achieve the desired effect, but I guess I can't see them somehow. So any help would be appreciated!

Thanks four your help and please spread the word!

## Side note

Detail scene uses the same mechanism as in [EasyParallax](https://github.com/iltercengiz/EasyParallax) for parallax effect.
