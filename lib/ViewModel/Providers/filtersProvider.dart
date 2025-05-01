import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Filterprv extends StateNotifier<Map<filters, bool>> {
  // Constructor
  Filterprv() : super({}) {
    _loadFilters();
  }

  // Load filters from SharedPreferences
  Future<void> _loadFilters() async {}

  // Set filters based on chosen filters
  void setFilters(Map<filters, bool> chosenFilters) {
    state = chosenFilters;
    _saveFilters(); // Save to SharedPreferences
  }

  // Set individual filter
  void setFilter(filters filter, bool value) {
    state = {...state, filter: value};
    _saveFilters(); // Save to SharedPreferences
  }

  // Empty filters
  void empty() {
    state = {
      filters.containsCaffeine: true,
      filters.containsNuts: true,
      filters.isDairy: true,
      filters.isDecaf: true,
      filters.isSugary: true,
    };
    _saveFilters(); // Save to SharedPreferences
  }

  // Save filters to SharedPreferences
  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final filtersMap = {
      filters.containsCaffeine.toString(): state[filters.containsCaffeine],
      filters.containsNuts.toString(): state[filters.containsNuts],
      filters.isDairy.toString(): state[filters.isDairy],
      filters.isDecaf.toString(): state[filters.isDecaf],
      filters.isSugary.toString(): state[filters.isSugary],
    };
    await prefs.setString('filters', jsonEncode(filtersMap)); // Save as JSON
  }
}

// Provider declaration
final filterProvider = StateNotifierProvider<Filterprv, Map<filters, bool>>(
  (ref) => Filterprv(),
);
