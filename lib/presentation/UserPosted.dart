import 'package:architect/bloc/user_posts/user_posts_state.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/user_posts/user_posts_cubit.dart';

class UserPosted extends StatefulWidget {
  const UserPosted({super.key});

  @override
  State<UserPosted> createState() => _UserPostedState();
}

class _UserPostedState extends State<UserPosted> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserPostsCubit>().getUserPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'User Posted',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                context.push('/architech_profile');
              },
              icon: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserPostsCubit, UserPostsState>(
        builder: (context, state) {
          if (state is UserPostsStateLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is UserPostsStateLoaded) {
            if (state.userPostedModel.data == null ||
                state.userPostedModel.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No posts available',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Posted Requirements',
                    style: TextStyle(
                      color: Color(0xff808080),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.userPostedModel.data!.length,
                      itemBuilder: (context, index) {
                        final userPosts = state.userPostedModel.data![index];
                        return GestureDetector(
                          onTap: () {
                            context.push(
                              '/user_posted_details?id=${userPosts.id}',
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xff191919),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userPosts.name ?? "N/A",
                                      style: const TextStyle(
                                        color: Color(0xffFAFAFA),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Text(
                                      'In ${userPosts.timeFrame ?? "N/A"}',
                                      style: TextStyle(
                                        color: const Color(
                                          0xffFAFAFA,
                                        ).withOpacity(0.8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  userPosts.landDetails ?? "No details",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xffA3A2A2),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          size: 16,
                                          color: Color(0xff888787),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          userPosts.email ?? "N/A",
                                          style: const TextStyle(
                                            color: Color(0xff888787),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: Color(0xff888787),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          userPosts.phone ?? "N/A",
                                          style: const TextStyle(
                                            color: Color(0xff888787),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_pin,
                                      size: 16,
                                      color: Color(0xff888787),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      userPosts.location ?? "N/A",
                                      style: const TextStyle(
                                        color: Color(0xff888787),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserPostsStateError) {
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
