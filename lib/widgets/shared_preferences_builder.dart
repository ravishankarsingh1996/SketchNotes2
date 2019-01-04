import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// StreamBuilder to provide nicer access to shared preferences
/// 
/// class Example extends StatelessWidget {
/// 	@override
/// 	Widget build(BuildContext context) {
/// 		return SharedPreferencesBuilder<String>(
/// 			pref: 'access_token',
/// 			builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
/// 				return snapshot.hasData ? Text(snapshot.data) : Container();
/// 			},
/// 		);
/// 	}
/// }
/// From: https://medium.com/flutter-community/shared-preferences-how-to-save-flutter-application-settings-and-user-preferences-for-later-554d08671ae9
class SharedPreferencesBuilder<T> extends StatelessWidget {
	final String pref;
	final AsyncWidgetBuilder<T> builder;
	
	const SharedPreferencesBuilder({
		Key key,
		@required this.pref,
		@required this.builder,
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		return FutureBuilder<T>(
			future: _future(),
			builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
				return this.builder(context, snapshot);
			});
	}
	
	Future<T> _future() async {
		return (await SharedPreferences.getInstance()).get(pref);
	}
}