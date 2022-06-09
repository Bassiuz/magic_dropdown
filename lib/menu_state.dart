/// [MenuState] determines the state of the menu is currently in.
///
/// [animating] is the state between a closed and opened menu, blocking inputs on the button to prevent issues while animating the menu.
enum MenuState {
  closed,
  animating,
  open,
}
