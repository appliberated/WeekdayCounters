// Copyright 2020 Appliberated. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:weekday_counters/common/app_strings.dart';
import 'package:weekday_counters/models/counter.dart';
import 'package:weekday_counters/utils/utils.dart';
import 'package:weekday_counters/widgets/color_list_tile.dart';

/// Drawer extra actions enumeration.
enum DrawerExtraActions { settings, help, rate }

/// A material design drawer that shows navigation links for all available counters.
class CountersDrawer extends StatelessWidget {
  /// Creates a counters drawer widget.
  const CountersDrawer({
    Key key,
    @required this.title,
    this.counters,
    this.onExtraSelected,
  })  : assert(title != null),
        super(key: key);

  /// The title of the drawer displayed in the drawer header.
  final String title;

  /// The map of counters.
  final Counters counters;

  /// Called when the user taps a drawer list tile.
  final void Function(DrawerExtraActions value) onExtraSelected;

  void _onExtraActionTap(BuildContext context, DrawerExtraActions action) {
    Navigator.pop(context);
    if (onExtraSelected != null) onExtraSelected(action);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        selectedColor: Colors.black,
        child: ListView(
          children: <Widget>[
            _buildDrawerHeader(context),
            ...CounterType.values.map((type) => _buildCounterListTile(context, type)),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(AppStrings.settingsItemTitle),
              onTap: () => _onExtraActionTap(context, DrawerExtraActions.settings),
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text(AppStrings.helpItemTitle),
              onTap: () => _onExtraActionTap(context, DrawerExtraActions.help),
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text(AppStrings.rateItemTitle),
              onTap: () => _onExtraActionTap(context, DrawerExtraActions.rate),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight + 8.0,
      child: DrawerHeader(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  Widget _buildCounterListTile(BuildContext context, CounterType counterType) {
    return ColorListTile(
      color: Counter.colorOf(counterType),
      title: Counter.nameOf(counterType),
      subtitle: toDecimalString(context, counters[counterType].value),
      enabled: counterType == counters.current.type,
      selected: counterType == counters.current.type,
      onTap: () => Navigator.pop(context),
    );
  }
}
