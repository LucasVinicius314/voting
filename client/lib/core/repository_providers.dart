import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/repositories/results_repository.dart';
import 'package:voting/repositories/role_repository.dart';
import 'package:voting/repositories/vote_repository.dart';
import 'package:voting/utils/api.dart';

/// Stategy: [ResultsRepository], [ApiResultsRepository], [MockResultsRepository], [RepositoryProviders],
/// Stategy: [RoleRepository], [ApiRoleRepository], [MockRoleRepository], [RepositoryProviders],
/// Stategy: [VoteRepository], [ApiVoteRepository], [MockVoteRepository], [RepositoryProviders],
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
        /// Stategy: [ResultsRepository], [ApiResultsRepository], [MockResultsRepository], [RepositoryProviders],
        RepositoryProvider<ResultsRepository>(
          create: (context) => ApiResultsRepository(api: _api),
        ),

        /// Stategy: [RoleRepository], [ApiRoleRepository], [MockRoleRepository], [RepositoryProviders],
        RepositoryProvider<RoleRepository>(
          create: (context) => ApiRoleRepository(api: _api),
        ),

        /// Stategy: [VoteRepository], [ApiVoteRepository], [MockVoteRepository], [RepositoryProviders],
        RepositoryProvider<VoteRepository>(
          create: (context) => ApiVoteRepository(api: _api),
        ),
      ],
      child: child,
    );
  }
}
