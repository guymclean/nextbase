import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextbase/bloc/chart_cubit.dart';
import 'package:nextbase/bloc/chart_states.dart';
import 'package:nextbase/data/metadata_repo.dart';
import 'package:nextbase/presentation/journey_acceleration_chart.dart';
import 'package:nextbase/presentation/map_screen.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartCubit>(
      create: (BuildContext context) => ChartCubit(
        metadataRepo: RepositoryProvider.of<MetadataRepo>(context),
      ),
      child: _ChartScreen(),
    );
  }
}

class _ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartCubit, ChartState>(
      builder: (BuildContext context, ChartState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Chart"),
            centerTitle: true,
            actions: [
              if (state is ChartLoaded)
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ),
                  ),
                  icon: Icon(Icons.arrow_forward),
                ),
            ],
          ),
          body: Builder(
            builder: (BuildContext context) {
              if (state is ChartLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: JourneyAccelerationChart(state.data),
                );
              } else if (state is ChartError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
