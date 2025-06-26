import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/architect_list/architect_cubit.dart';
import '../bloc/architect_list/architect_state.dart';
import '../utils/color_constants.dart';
import 'Components/CutomAppBar.dart';

class SelectArchitecture extends StatefulWidget {
  final String industryType;
  final String location;
  const SelectArchitecture({
    Key? key,
    required this.industryType,
    required this.location,
  }) : super(key: key);
  @override
  State<SelectArchitecture> createState() => _SelectArchitectureScreenState();
}

class _SelectArchitectureScreenState extends State<SelectArchitecture> {
  @override
  void initState() {

    context.read<ArchitectCubit>().getArchitect(
      widget.industryType,
      widget.location,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Architecture', actions: [Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: IconButton(
          onPressed: () {
            context.go('/onboarding');
          },
          icon: Icon(Icons.home, color: Colors.white),
        ),
      ),]),
      body: BlocBuilder<ArchitectCubit, ArchitectState>(
        builder: (context, state) {
          if (state is ArchitectLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is ArchitectLoaded) {
            if (state.architectModel.data?.architechData == null ||
                state.architectModel.data?.architechData?.length==0) {
              return const Center(
                child: Text(
                  'No Architects available',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ListView.builder(
                itemCount: state.architectModel.data?.architechData?.length,
                itemBuilder: (context, index) {
                  final architechList=state.architectModel.data?.architechData![index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/architecture_details?id=${architechList?.id ?? 0}');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: w * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.white24, // Placeholder color
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.image,
                              size: 48,
                              color: Colors.white30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                   architechList?.companyName??"",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,fontFamily: 'Inter'
                                  ),
                                ),
                                const SizedBox(height: 4),
                                 Text(
                                   architechList?.companyEmail??"",
                                  style: TextStyle(
                                    color: Colors.white70,fontFamily: 'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            '4.9',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(width: 16),
                                    Icon(
                                      Icons.apartment,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Est. 2015',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        'Hyderabad, India',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ArchitectError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
