# shrine

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

By now, you might have noticed what we call a ‘platform variance'. Material knows that each platform, Android, iOS, Web, is different. And that users have different expectations. For example, on iOS, titles are almost always centered and that is the default behavior supplied by UIKit. On Android, it's left aligned. So if you're using an Android emulator or device, your title should be aligned to the left. For an iOS simulator or device, it should be centered.


Cards are independent elements that display content and actions on a single subject. They're a flexible way to present similar content as a collection.

The AspectRatio widget decides what shape the image takes no matter what kind of image is supplied

We called copyWith() on the default light ThemeData, and then passed in some custom property values (copyWith() is a common method you'll find on many classes and widgets in Flutter). This command returns an instance of the widget that matches the instance it's called on, but with the specified values replaced.


// <https://pub.dev/packages/shrine_images>
// <https://stackoverflow.com/questions/68972127/fix-all-const-warning-flutter>



<https://stackoverflow.com/questions/51907159/default-values-of-an-optional-parameter-must-be-constant>


Notice we mark certain properties required. This is a best practice for properties in the constructor that have no default value and cannot be null and therefore should not be forgotten.


LayoutBuilder is a special widget whose builder callback provides size constraints.

The widget tree performs layout by traversing towards the leaves. Constraints are passed down the tree but sizes usually aren't calculated until the leaf returns its size based on the constraints. If a leaf needed to know its parent's size, it couldn't since it's not yet calculated.

LayoutBuilder is used when a widget must know its parent widget's size in order to lay itself out (and the parent size does not depend on the child.) LayoutBuilder takes a function that returns a Widget.
