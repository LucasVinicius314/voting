import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/repositories/role_repository.dart';
import 'package:voting/repositories/vote_repository.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RoleRepository>(
          create: (context) => MockRoleRepository(),
        ),
        RepositoryProvider<VoteRepository>(
          create: (context) => MockVoteRepository(),
        ),
      ],
      child: child,
    );
  }
}
