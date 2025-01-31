/// A simple web application for displaying images from a URL.
///
/// This application allows users to input an image URL, which is then displayed
/// in a container. Users can double-click the image to toggle fullscreen mode
/// and use a context menu for additional fullscreen options.
///
/// ## Usage
/// 1. Enter a valid image URL in the input field.
/// 2. Click the "Load Image" button to display the image.
/// 3. Double-click the image to enter or exit fullscreen mode.
/// 4. Click the "+" button to open a context menu with fullscreen options.
///
/// ## Dependencies
/// - `dart:html`: For manipulating HTML elements.
/// - `dart:js`: For calling JavaScript functions.
///
/// ## Functions
/// - `main`: Initializes the application and sets up event listeners.
/// - `toggleFullscreen`: Toggles the fullscreen state of the application.

import 'dart:html';
import 'dart:js' as js;

void main() {
  // Query selectors for input field, button, and image container.
  final input = querySelector('#urlInput') as InputElement;
  final button = querySelector('#loadImageBtn') as ButtonElement;
  final imageContainer = querySelector('#image-container') as DivElement;

  // Listener for the load image button click event.
  button.onClick.listen((event) {
    final imageUrl = input.value;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      // Clear previous image
      imageContainer.children.clear();

      // Create and style a new image element.
      final image = ImageElement(src: imageUrl)
        ..style.maxWidth = '100%'
        ..style.height = 'auto';

      // Append the image to the container and make it visible.
      imageContainer.append(image);
      imageContainer.style.display = 'block'; // Show image container

      // Listener for double-click event to toggle fullscreen.
      image.onDoubleClick.listen((event) {
        toggleFullscreen();
      });
    }
  });

  // Query selector for the plus button and context menu.
  final plusButton = querySelector('#plusButton') as ButtonElement;
  final contextMenu = querySelector('#context-menu') as DivElement;

  // Listener for the plus button click event to toggle the context menu.
  plusButton.onClick.listen((event) {
    event.stopPropagation();
    contextMenu.style.display =
        contextMenu.style.display == 'block' ? 'none' : 'block';
    document.body!.style.backgroundColor =
        contextMenu.style.display == 'block' ? 'rgba(0, 0, 0, 0.5)' : '#f0f0f0';
  });

  // Listener for clicks on the document to close the context menu.
  document.onClick.listen((event) {
    if (contextMenu.style.display == 'block') {
      contextMenu.style.display = 'none';
      document.body!.style.backgroundColor = '#f0f0f0';
    }
  });

  // Listeners for entering and exiting fullscreen from the context menu.
  querySelector('#enterFullscreenBtn')!.onClick.listen((event) {
    toggleFullscreen();
    contextMenu.style.display = 'none';
    document.body!.style.backgroundColor = '#f0f0f0';
  });

  querySelector('#exitFullscreenBtn')!.onClick.listen((event) {
    toggleFullscreen();
    contextMenu.style.display = 'none';
    document.body!.style.backgroundColor = '#f0f0f0';
  });
}

/// Toggles the fullscreen state of the application by calling a JavaScript function.
void toggleFullscreen() {
  js.context.callMethod('toggleFullscreen');
}