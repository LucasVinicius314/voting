import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/repositories/results_repository.dart';
import 'package:voting/repositories/role_repository.dart';
import 'package:voting/repositories/vote_repository.dart';
import 'package:voting/utils/api.dart';

class RepositoryProviders extends StatelessWidget {
  RepositoryProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  final _api = Api(authority: 'localhost:8000');

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ResultsRepository>(
          create: (context) => ApiResultsRepository(api: _api),
        ),
        RepositoryProvider<RoleRepository>(
          create: (context) => ApiRoleRepository(api: _api),
        ),
        RepositoryProvider<VoteRepository>(
          create: (context) => ApiVoteRepository(api: _api),
        ),
      ],
      child: child,
    );
  }
}
