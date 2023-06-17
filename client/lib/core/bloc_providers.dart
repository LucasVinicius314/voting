import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/role/role_bloc.dart';
import 'package:voting/blocs/vote/vote_bloc.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RoleBloc()),
        BlocProvider(create: (context) => VoteBloc()),
      ],
      child: child,
    );
  }
}
