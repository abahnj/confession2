import 'package:flutter/material.dart';

/// A controller for managing the state of a master-detail view.
class MasterDetailController<T> extends ChangeNotifier {
  /// Creates a master-detail controller.
  MasterDetailController({T? selectedItem}) : _selectedItem = selectedItem;

  /// The currently selected item.
  T? get selectedItem => _selectedItem;
  T? _selectedItem;

  /// Sets the selected item.
  void selectItem(T? item) {
    if (_selectedItem == item) return;
    _selectedItem = item;
    notifyListeners();
  }

  /// Clears the selected item.
  void clearSelection() {
    _selectedItem = null;
    notifyListeners();
  }

  /// Whether an item is selected.
  bool get hasSelection => _selectedItem != null;
}

/// A provider for a master-detail controller.
class MasterDetailControllerProvider<T> extends InheritedNotifier<MasterDetailController<T>> {
  /// Creates a master-detail controller provider.
  const MasterDetailControllerProvider({
    required super.notifier,
    required super.child,
    super.key,
  });

  /// Gets the controller from the context.
  static MasterDetailController<T> of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<MasterDetailControllerProvider<T>>();
    if (provider == null) {
      throw FlutterError('MasterDetailControllerProvider not found in context');
    }
    return provider.notifier!;
  }
}
