import 'package:architect/utils/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/ArchitechProfileDetails/architech_profile_details_cubit.dart';
import '../bloc/ArchitechProfileDetails/architech_profile_details_state.dart';
import '../utils/AppLauncher.dart';
import 'Components/CutomAppBar.dart';
import 'Components/debugPrint.dart';

class ArchitectureDetails extends StatefulWidget {
  final int id;
  final String type;
  const ArchitectureDetails({Key? key, required this.id, required this.type})
    : super(key: key);

  @override
  State<ArchitectureDetails> createState() => _ArchitectureDetailsState();
}

class _ArchitectureDetailsState extends State<ArchitectureDetails> {
  Widget _buildInfoTile(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.white70),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    debugPrint("cbvxbtype:${widget.type}");
    if (widget.type == "Architech") {
      context.read<ArchitechProfileDetailsCubit>().getArchitechProfileDetails(
        widget.id,
      );
    } else {
      context
          .read<ArchitechProfileDetailsCubit>()
          .getUserArchitechProfileDetails(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Architecture Details', actions: []),
      body: BlocBuilder<ArchitechProfileDetailsCubit, ArchitechProfileDetailsState>(
        builder: (context, state) {
          if (state is ArchitechProfileDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is ArchitechProfileDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              state.architechProfileModel.data?.coverPhoto ??
                                  "",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              state.architechProfileModel.data?.coverPhoto ??
                              "",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
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
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/architecturebc.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        left: 16,
                        bottom: -50,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                state.architechProfileModel.data?.logo ?? "",
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 140,
                              height: 140,
                              color: Colors.grey.shade200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: primarycolor,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/profile.png",
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 60,
                        bottom: 0,
                        child: Row(
                          children: [
                            IconButton.outlined(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                                shape: WidgetStateProperty.all(CircleBorder()),
                              ),
                              visualDensity: VisualDensity.compact,
                              icon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.call, color: Colors.blue),
                              ),
                              onPressed: () {
                                final phone =
                                    state
                                        .architechProfileModel
                                        .data
                                        ?.contactNumber ??
                                    '';
                                AppLauncher.call(phone);
                              },
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: Row(
                          children: [
                            IconButton.outlined(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                                shape: WidgetStateProperty.all(CircleBorder()),
                              ),
                              visualDensity: VisualDensity.compact,
                              icon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Bootstrap.whatsapp,
                                  color: Colors.green,
                                ),
                              ),
                              onPressed: () {
                                print('Tapped on Whatapp');
                                final phone =
                                    state
                                        .architechProfileModel
                                        .data
                                        ?.contactNumber ??
                                    '';
                                AppLauncher.openWhatsApp(phone);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 56),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capitalize(
                                  "${state.architechProfileModel.data?.contactPersonName ?? ""}",
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                capitalize(
                                  "${state.architechProfileModel.data?.companyName ?? ""}",
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              // SizedBox(height: 8),
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.star,
                              //       size: 16,
                              //       color: Colors.yellow,
                              //     ),
                              //     SizedBox(width: 4),
                              //     Text(
                              //       '4.0',
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     SizedBox(width: 4),
                              //     Text(
                              //       '(5 reviews)',
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.white70,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${state.architechProfileModel.data?.state ?? ""}, ${state.architechProfileModel.data?.location ?? ""}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (state.architechProfileModel.data?.emailVerified ==
                            true) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Verified',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _buildStatBox(
                          '${state.architechProfileModel.data?.yearsOfExperience ?? "0"}',
                          'Year Exp.',
                        ),
                        const SizedBox(width: 12),
                        _buildStatBox(
                          '${state.architechProfileModel.data?.numberOfProjects ?? "0"}',
                          'Projects',
                        ),
                        // const SizedBox(width: 12),
                        // _buildStatBox('98%', 'Response'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // About
                  _buildSectionTitle('About'),
                  _buildSectionContent(
                    state.architechProfileModel.data?.aboutCompany ?? "",
                  ),

                  // Specializations
                  _buildSectionTitle('Specializations'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          (state.architechProfileModel.data?.specializations ??
                                  [])
                              .map<Widget>((s) {
                                return Chip(
                                  label: Text(
                                    s,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Colors.white,
                                  labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                );
                              })
                              .toList(),
                    ),
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Portfolio'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: List.generate(
                        state.architechProfileModel.data?.portfolio?.length ??
                            0,
                        (index) {
                          final imageUrl = state
                              .architechProfileModel
                              .data!
                              .portfolio![index];

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 140,
                                    height: 140,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        'assets/portfolio.png',
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // const SizedBox(height: 24),
                  // _buildSectionTitle('Reviews'),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(
                  //     horizontal: 16,
                  //     vertical: 8,
                  //   ),
                  //   padding: const EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[850],
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 20,
                  //         backgroundColor: Colors.grey[700],
                  //         child: const Text(
                  //           'S',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //       const SizedBox(width: 12),
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             const Text(
                  //               'Sarah Johnson',
                  //               style: TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             const SizedBox(height: 4),
                  //             Row(
                  //               children: List.generate(5, (i) {
                  //                 return Icon(
                  //                   i < 4 ? Icons.star : Icons.star_border,
                  //                   size: 16,
                  //                   color: Colors.yellow,
                  //                 );
                  //               }),
                  //             ),
                  //             const SizedBox(height: 8),
                  //             const Text(
                  //               'When giving permission to use their work, some copyright holders ask that you do this. In some cases, you may also need to credit the copyright holder if you plan to use their work in a way that you consider appropriate.',
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //                 height: 1.4,
                  //                 color: Colors.white70,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 24),

                  // Contact Info
                  _buildSectionTitle('Contact Info'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          Icons.phone,
                          '${state.architechProfileModel.data?.contactNumber ?? ""}',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoTile(
                          Icons.email,
                          '${state.architechProfileModel.data?.companyEmail ?? ""}',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoTile(
                          Icons.location_on,
                          '${state.architechProfileModel.data?.state ?? ""}, ${state.architechProfileModel.data?.location ?? ""}',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          } else if (state is ArchitechProfileDetailsError) {
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

  Widget _buildStatBox(String number, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          fontFamily: 'Inter',
          color: Colors.white70,
        ),
      ),
    );
  }
}
