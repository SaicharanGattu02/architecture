import 'package:architect/bloc/user_posts_delete/user_post_deatails_cubit.dart';
import 'package:architect/bloc/user_posts_delete/user_post_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/color_constants.dart';
import 'Components/CutomAppBar.dart';

class UserPostedDetails extends StatefulWidget {
  final int id;
  const UserPostedDetails({super.key, required this.id});

  @override
  State<UserPostedDetails> createState() => _UserPostedDetailsState();
}

class _UserPostedDetailsState extends State<UserPostedDetails> {
  @override
  void initState() {
    context.read<UserPostDetailsCubit>().getUserPostDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Post Detail', actions: []),
      body: BlocBuilder<UserPostDetailsCubit, UserPostDetailsState>(
        builder: (context, state) {
          if (state is UserPostDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is UserPostDetailsLoaded) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xff191919),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userPosteDetailsModel.data?.name ?? "",
                        style: TextStyle(
                          color: Color(0xffDDDDDD),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 16,
                            color: Color(0xff888787),
                          ),
                          SizedBox(width: 4),
                          Text(
                            state.userPosteDetailsModel.data?.location ?? "",
                            style: TextStyle(
                              color: Color(0xff888787),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      Row(
                        children: [
                          Icon(Icons.email, size: 16, color: Color(0xff888787)),
                          SizedBox(width: 4),
                          Text(
                            state.userPosteDetailsModel.data?.email ?? "",
                            style: TextStyle(
                              color: Color(0xff888787),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.phone, size: 16, color: Color(0xff888787)),
                          SizedBox(width: 4),
                          Text(
                            state.userPosteDetailsModel.data?.phone ?? "",
                            style: TextStyle(
                              color: Color(0xff888787),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Land details',
                        style: TextStyle(
                          color: Color(0xffDDDDDD),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        state.userPosteDetailsModel.data?.landDetails ?? "",
                        style: TextStyle(
                          color: Color(0xffA3A2A2),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Time Frame',
                        style: TextStyle(
                          color: Color(0xffDDDDDD),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'In ${state.userPosteDetailsModel.data?.timeFrame ?? ""}',
                        style: TextStyle(
                          color: Color(0xffFAFAFA).withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '~ 2day’s ago',
                          style: TextStyle(
                            color: Color(0xff808080),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is UserPostDetailsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
