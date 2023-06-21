import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/results/results_bloc.dart';
import 'package:voting/blocs/results/results_event.dart';
import 'package:voting/blocs/results/results_state.dart';
import 'package:voting/models/result.dart';
import 'package:voting/models/vote_results.dart';
import 'package:voting/widgets/loading_indicator.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  static const route = '/results';

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  Widget _getBarChart({
    required int voteCount,
    required double columnCount,
    required List<Result> votesByCandidate,
    required Map<String, Color> partyColors,
  }) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(
          clampDouble(
            votesByCandidate.length.toDouble(),
            0,
            columnCount,
          ).toInt(),
          (index) {
            final vote = votesByCandidate[index];

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: vote.value,
                  color: partyColors[vote.secondaryLabel],
                  width: 20,
                ),
              ],
            );
          },
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        borderData: FlBorderData(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        gridData: const FlGridData(drawVerticalLine: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 64,
              getTitlesWidget: (value, meta) {
                final vote = votesByCandidate[value.toInt()];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      vote.primaryLabel,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      vote.secondaryLabel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${(100 * vote.value / voteCount).toStringAsFixed(2)} %',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getContent({required GetResultsDoneState state}) {
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
                    text: 'Resultados',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' da votação até o momento.'),
                ],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getSection(
                title: 'Presidente',
                voteResults: state.presidentVoteResults,
              ),
              _getSection(
                title: 'Prefeito',
                voteResults: state.mayorVoteResults,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getSection({
    required String title,
    required VoteResults voteResults,
  }) {
    final votesByCandidate = voteResults.votesByCandidate ?? [];

    final partyColors = <String, Color>{};

    final random = Random();

    for (var vote in votesByCandidate) {
      if (!partyColors.containsKey(vote.secondaryLabel)) {
        partyColors[vote.secondaryLabel] =
            Color(0xff888888 + random.nextInt(0x555555));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Quantidade de votos por candidato',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 300,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return _getBarChart(
                partyColors: partyColors,
                voteCount: voteResults.voteCount,
                votesByCandidate: votesByCandidate,
                columnCount: constraints.maxWidth / 160,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    Future(() {
      BlocProvider.of<ResultsBloc>(context).add(GetResultsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: BlocBuilder<ResultsBloc, ResultsState>(
              builder: (context, state) {
                if (state is GetResultsErrorState) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(state.message, textAlign: TextAlign.center),
                    ),
                  );
                }

                if (state is GetResultsDoneState) {
                  return _getContent(state: state);
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
