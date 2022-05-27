import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/features/forcast/presentation/bloc/forcast_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String _inputStr = '';
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                _inputStr = value;
              },
              onSubmitted: (_) {
                BlocProvider.of<ForcastBloc>(context)
                    .add(GetForcastByCityNameEvent(_inputStr.trim()));
                _controller.clear();
                Navigator.pop(context);
              },
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                fillColor: const Color(0xff313740),
                filled: true,
                hintText: 'Enter Location',
                hintStyle: const TextStyle(
                  color: Color(0xff55585D),
                ),
                
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                disabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
