import 'package:architect/utils/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/ArchitechProfile/architech_profile_cubit.dart';
import '../bloc/ArchitechProfile/architech_profile_state.dart';
import '../services/AuthService.dart';
import 'Components/CutomAppBar.dart';

class ArchitechProfile extends StatefulWidget {
  const ArchitechProfile({super.key});

  @override
  State<ArchitechProfile> createState() => _ArchitechProfileState();
}

class _ArchitechProfileState extends State<ArchitechProfile> {
  @override
  void initState() {
    super.initState();
    context.read<ArchitechProfileCubit>().getArchitechProfile();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Profile', actions: []),
      body: BlocBuilder<ArchitechProfileCubit, ArchitechProfileState>(
        builder: (context, state) {
          if (state is ArchitechProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is ArchitechProfileLoaded) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      spacing: 16,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: w * 0.25,
                              decoration: BoxDecoration(
                                color: Color(0xff010101),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    state.architechProfileModel.data?.logo ??
                                    "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: primarycolor,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      "assets/profile.png",
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state
                                            .architechProfileModel
                                            .data
                                            ?.contactPersonName ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    state
                                            .architechProfileModel
                                            .data
                                            ?.companyName ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      // Container(
                                      //   padding: EdgeInsets.symmetric(
                                      //     horizontal: 4,
                                      //     vertical: 2,
                                      //   ),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(
                                      //       12,
                                      //     ),
                                      //   ),
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(
                                      //         Icons.star,
                                      //         color: Colors.yellow,
                                      //         size: 16,
                                      //       ),
                                      //       SizedBox(width: 2),
                                      //       Text(
                                      //         '4.9',
                                      //         style: TextStyle(
                                      //           fontWeight: FontWeight.w600,
                                      //           color: Colors.black,
                                      //           fontSize: 12,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      // SizedBox(width: 16),
                                      Icon(
                                        Icons.apartment,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Est. ${state.architechProfileModel.data?.establishedYear ?? ""}',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          '${state.architechProfileModel.data?.state ?? ""}, ${state.architechProfileModel.data?.location ?? ""}',
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  context.push(
                                    '/architecture_details?id=${state.architechProfileModel.data?.id ?? 0}&type=${"Architech"}',
                                  );
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: Text(
                                  'View Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Spacer(),
                              TextButton.icon(
                                onPressed: () {
                                  context.push(
                                    '/company_details?id=${state.architechProfileModel.data?.id ?? 0}',
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.push(
                              '/subscription?id=${state.architechProfileModel.data?.id ?? 0}&type=${"Renew"}',
                            );
                          },
                          child: Column(
                            spacing: 12,
                            children: [
                              Container(
                                padding: EdgeInsets.all(26),
                                decoration: BoxDecoration(
                                  color: Color(0xff363636),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Image.asset(
                                  'assets/subscription.png',
                                  scale: 5,
                                ),
                              ),
                              Text(
                                'Renew the plan',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffCCCCCC),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push('/payments_history');
                          },
                          child: Column(
                            spacing: 12,
                            children: [
                              Container(
                                padding: EdgeInsets.all(26),
                                decoration: BoxDecoration(
                                  color: Color(0xff363636),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Image.asset(
                                  'assets/refresh.png',
                                  scale: 5,
                                ),
                              ),
                              Text(
                                'History',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffCCCCCC),
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            showLogoutDialog(context);
                          },
                          child: Column(
                            spacing: 12,
                            children: [
                              Container(
                                padding: EdgeInsets.all(26),
                                decoration: BoxDecoration(
                                  color: Color(0xff363636),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Image.asset(
                                  'assets/logout.png',
                                  scale: 5,
                                ),
                              ),
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffCCCCCC),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ArchitechProfileError) {
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

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 4.0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Power Icon Positioned Above Dialog
                Positioned(
                  top: -35.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 6.0, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.red.shade100, // Light red background
                    ),
                    child: const Icon(
                      Icons.power_settings_new,
                      size: 40.0,
                      color: Colors.red, // Power icon color
                    ),
                  ),
                ),

                // Dialog Content
                Positioned.fill(
                  top: 30.0, // Moves content down
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15.0),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: primarycolor,
                            fontFamily: "Inter",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                            fontFamily: "Inter",
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // No Button (Filled)
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      primarycolor, // Filled button color
                                  foregroundColor: Colors.white, // Text color
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                            ),

                            // Yes Button (Outlined)
                            SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                onPressed: () async {
                                  await AuthService.logout();
                                  context.go("/onboarding");
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: primarycolor, // Text color
                                  side: BorderSide(
                                    color: primarycolor,
                                  ), // Border color
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
