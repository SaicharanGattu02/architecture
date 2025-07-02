import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/categoryType/categoryType_cubit.dart';
import '../bloc/categoryType/categoryType_states.dart';
import 'Components/CustomAppButton.dart';
import 'Components/CutomAppBar.dart';

class SelectType extends StatefulWidget {
  // final String state;
  final String city;

  const SelectType({Key? key, required this.city})
    : super(key: key);

  @override
  _SelectTypeScreenState createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectType> {
  String? _selectedCategory;
  @override
  void initState() {
    context.read<CategoryTypeCubit>().getCategoryType(
      // widget.state,
      widget.city
    );
    super.initState();
  }

  Widget _buildTypeCard(String name, IconData icon) {
    final bool isSelected = _selectedCategory == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = name;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 2)
                      : null,
                ),
                child: Center(child: Icon(icon, size: 36, color: Colors.white)),
              ),
              if (isSelected)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(name, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: 'Select Type', actions: []),
      body: BlocBuilder<CategoryTypeCubit, CategoryTypeStates>(
        builder: (context, state) {
          if (state is CategoryTypeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is CategoryTypeLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: state.categoryType.data?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemBuilder: (context, index) {
                        final category = state.categoryType.data![index];
                        return _buildTypeCard(category, Icons.business);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CategoryTypeFailure) {
            return Center(
              child: Text(state.msg, style: TextStyle(color: Colors.redAccent)),
            );
          } else {
            return const Center(
              child: Text(
                'Failed to load categories',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: _selectedCategory != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: CustomAppButton1(
                  text: 'Find Architects',
                  onPlusTap: () {
                    final type = _selectedCategory!;
                    context.push(
                      '/select_architecture?industryType=$type&location=${widget.city}',
                    );
                  },
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
