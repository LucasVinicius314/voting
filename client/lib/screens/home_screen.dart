import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:voting/blocs/role/role_bloc.dart';
import 'package:voting/blocs/role/role_event.dart';
import 'package:voting/blocs/role/role_state.dart';
import 'package:voting/blocs/vote/vote_bloc.dart';
import 'package:voting/blocs/vote/vote_event.dart';
import 'package:voting/blocs/vote/vote_state.dart';
import 'package:voting/models/candidate.dart';
import 'package:voting/models/party.dart';
import 'package:voting/utils/constants.dart';
import 'package:voting/utils/enums.dart';
import 'package:voting/utils/validation.dart';
import 'package:voting/widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Candidate? _president;
  Candidate? _mayor;

  Party? _presidentParty;
  Party? _mayorParty;

  Gender? _gender;

  DateTime? _birthDate;

  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _cpfFormatters = [
    MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {'#': RegExp(r'[0-9]')},
    ),
  ];

  Future<Position?> _determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Widget _getContent({required ListRolesDoneState state}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: RichText(
              text: TextSpan(
                children: const [
                  TextSpan(
                    text:
                        'Escolha seu candidato para cada cargo e informe seu ',
                  ),
                  TextSpan(
                    text: 'CPF',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '.'),
                ],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),
          _getSection(
            title: 'Presidente',
            candidate: _president,
            party: _presidentParty,
            parties: state.president,
            onChanged: (candidate, party) {
              setState(() {
                _president = candidate;
                _presidentParty = party;
              });
            },
          ),
          const Divider(),
          const SizedBox(height: 16),
          _getSection(
            title: 'Prefeito',
            candidate: _mayor,
            party: _mayorParty,
            parties: state.mayor,
            onChanged: (candidate, party) {
              setState(() {
                _mayor = candidate;
                _mayorParty = party;
              });
            },
          ),
          const Divider(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Seus dados',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: _focusNode,
                        controller: _controller,
                        inputFormatters: _cpfFormatters,
                        decoration: const InputDecoration(
                          labelText: 'CPF',
                          alignLabelWithHint: true,
                          hintText: '000.000.000-00',
                        ),
                        validator: (value) {
                          value ??= '';

                          value = value.replaceAll(RegExp(r'[\-\.]'), '');

                          if (value.length != 11 || !Validation.isCpf(value)) {
                            return 'CPF inválido.';
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<Gender?>(
                              value: _gender,
                              items: const [
                                DropdownMenuItem(
                                  value: Gender.female,
                                  child: Text('Feminino'),
                                ),
                                DropdownMenuItem(
                                  value: Gender.male,
                                  child: Text('Masculino'),
                                ),
                                DropdownMenuItem(
                                  value: Gender.other,
                                  child: Text('Outro'),
                                ),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Sexo',
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Escolha uma opção.';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 32),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: IconButton(
                              tooltip: 'Data de nascimento',
                              icon: const Icon(Icons.calendar_month_rounded),
                              onPressed: () async {
                                final now = DateTime.now();

                                final lastDate = now
                                    .subtract(const Duration(days: 365 * 16));

                                final ans = await showDatePicker(
                                  context: context,
                                  lastDate: lastDate,
                                  initialDate: lastDate,
                                  firstDate: now.subtract(
                                    const Duration(days: 365 * 100),
                                  ),
                                );

                                if (ans is DateTime) {
                                  setState(() {
                                    _birthDate = ans;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(child: Container()),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BlocBuilder<VoteBloc, VoteState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is SubmitVoteLoadingState
                                ? null
                                : _submit,
                            child: const Text('CONCLUIR'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSection({
    required String title,
    required Candidate? candidate,
    required Party? party,
    required List<Party> parties,
    required void Function(Candidate? candidate, Party? party) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(width: 16),
                  candidate == null
                      ? const Icon(Icons.close, color: Colors.red)
                      : const Icon(Icons.check, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    candidate == null ? 'Pendente' : 'Escolhido',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: candidate == null ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
              if (candidate != null && party != null)
                Container(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Escolha atual',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${candidate.getCode} - ${candidate.name ?? ''} (${party.acronym ?? ''})',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(party.name ?? ''),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...parties.map((e) {
          return ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            title: Text(e.name ?? ''),
            subtitle: Text(e.acronym ?? ''),
            children: (e.candidates ?? []).map((e2) {
              return RadioListTile<Candidate>(
                value: e2,
                groupValue: candidate,
                title: Text(e2.name ?? ''),
                subtitle: Text(e2.getCode),
                onChanged: (value) {
                  onChanged(e2, e);
                },
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Future<void> _showDialog({required String content}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                await Navigator.of(context).maybePop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    final voteBloc = BlocProvider.of<VoteBloc>(context);

    if (_formKey.currentState?.validate() != true) {
      return;
    }

    if (_president == null) {
      await _showDialog(content: 'Escolha um candidado para presidente.');

      return;
    }

    if (_mayor == null) {
      await _showDialog(content: 'Escolha um candidado para prefeito.');

      return;
    }

    if (_birthDate == null) {
      await _showDialog(content: 'Informe sua data de nascimento.');

      return;
    }

    final position = await _determinePosition();

    if (position == null) {
      await _showDialog(
        content:
            'Habilite ou permita o acesso do app ao serviço de localização do dispositivo e tente novamente.',
      );

      return;
    }

    voteBloc.add(
      SubmitVoteEvent(
        president: _president!,
        presidentParty: _presidentParty!,
        mayor: _mayor!,
        mayorParty: _mayorParty!,
        cpf: _controller.text.replaceAll(RegExp(r'[\-\.]'), ''),
        gender: _gender!,
        birthDate: _birthDate!,
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future(() {
      BlocProvider.of<RoleBloc>(context).add(ListRolesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appTitle)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: BlocBuilder<RoleBloc, RoleState>(
              builder: (context, state) {
                if (state is ListRolesErrorState) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(state.message, textAlign: TextAlign.center),
                    ),
                  );
                }

                if (state is ListRolesDoneState) {
                  return BlocListener<VoteBloc, VoteState>(
                    listener: (context, state) async {
                      if (state is SubmitVoteErrorState) {
                        await _showDialog(content: state.message);
                      } else if (state is SubmitVoteDoneState) {
                        await _showDialog(content: 'sucesso');
                      }
                    },
                    child: Form(
                      key: _formKey,
                      child: _getContent(state: state),
                    ),
                  );
                }

                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: LoadingIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
