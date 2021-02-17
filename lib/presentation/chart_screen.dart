import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextbase/bloc/metadata_cubit.dart';
import 'package:nextbase/bloc/metadata_states.dart';
import 'package:nextbase/presentation/journey_acceleration_chart.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart"),
        centerTitle: true,
      ),
      body: BlocBuilder<MetadataCubit, MetadataState>(
          builder: (BuildContext context, MetadataState state) {
        if (state is MetadataLoaded) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: JourneyAccelerationChart(state.snapshots),
          );
        } else if (state is MetadataError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
