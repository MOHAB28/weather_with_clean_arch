// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// import '../../bloc/forcast_bloc.dart';

// class ForcastView extends StatelessWidget {
//   const ForcastView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ForcastBloc, ForcastState>(builder: (context, state) {
//       if (state is ForcastEmpty || state is ForcastLoading) {
//         return const Center(
//           child: CircularProgressIndicator(
//             color: Color(0xffF8A057),
//           ),
//         );
//       } else if (state is ForcastLoaded) {
//         return ListView.separated(
//           itemCount: state.forcast.forcastData.length,
//           itemBuilder: (context, index) {
//             return Text(
//               'Time: ${DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(state.forcast.forcastData[index].dataTime * 1000))}',
//               style: const TextStyle(fontSize: 20.0),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return const SizedBox(height: 10.0);
//           },
//         );
//       }
//       return const SizedBox();
//     });
//   }
// }
