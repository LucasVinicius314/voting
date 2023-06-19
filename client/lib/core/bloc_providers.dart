import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/role/role_bloc.dart';
import 'package:voting/blocs/vote/vote_bloc.dart';
import 'package:voting/repositories/role_repository.dart';
import 'package:voting/repositories/vote_repository.dart';

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
        BlocProvider<RoleBloc>(
          create: (context) => RoleBloc(
            roleRepository: RepositoryProvider.of<RoleRepository>(context),
          ),
        ),
        BlocProvider<VoteBloc>(
          create: (context) => VoteBloc(
            voteRepository: RepositoryProvider.of<VoteRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
