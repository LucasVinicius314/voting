import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/repositories/role_repository.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TODO: fix
    // final api = Api(authority: '');

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RoleRepository>(
          create: (context) => MockRoleRepository(),
        ),
      ],
      child: child,
    );
  }
}
