import 'package:flutter/widgets.dart';
import 'package:sketchnotes_flutter/user_preferences_bloc.dart';

/// This is an InheritedWidget that wraps around [UserPreferencesBloc]. Think about this
/// as Scoped Model for that specific class.
///
/// This merely solves the "passing reference down the tree" problem for us.
/// You can solve this in other ways, like through dependency injection.
///
/// Also note that this does not call [UserPreferencesBloc.dispose]. If your app
/// ever doesn't need to access the cart, you should make sure it's
/// disposed of properly.
/// 
/// ref: https://github.com/filiph/state_experiments/blob/master/shared/lib/src/bloc_complex/cart/cart_provider.dart
/// 
class UserPreferencesProvider extends InheritedWidget {
  final UserPreferencesBloc prefsBloc;

  UserPreferencesProvider({
    Key key,
    UserPreferencesBloc prefsBloc,
    Widget child,
  })  : prefsBloc = prefsBloc ?? UserPreferencesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserPreferencesBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(UserPreferencesProvider) as UserPreferencesProvider)
          .prefsBloc;
}