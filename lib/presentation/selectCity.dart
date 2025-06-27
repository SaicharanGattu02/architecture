import 'package:architect/bloc/city/city_cubit.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/city/city_states.dart';
import 'Components/CutomAppBar.dart';


class SelectCity extends StatefulWidget {
  final String state;
  SelectCity({required this.state});
  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  void initState() {
    context.read<CityCubit>().getArchitectCity(widget.state);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Select City', actions: []),
      body: BlocBuilder<CityCubit, CityStates>(
        builder: (context, state) {
          if (state is CityArchitectLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is CityArchitectLoaded) {
            return ListView.builder(
              itemCount: state.cityList.data?.length,
              itemBuilder: (context, index) {
                final city = state.cityList.data![index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    title: Text(
                      city,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onTap: () {
                      final selectedCity = city;
                      print('selectedCity: $selectedCity');
                      context.push("/select_type?state=${widget.state}&city=${selectedCity}");
                    },
                  ),
                );
              },
            );
          } else if (state is CityFailure) {
            return Center(
              child: Text(state.msg, style: TextStyle(color: Colors.redAccent)),
            );
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}

