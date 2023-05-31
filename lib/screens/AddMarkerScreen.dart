import 'package:briefshot/blocs/location/location_bloc.dart';
import 'package:briefshot/blocs/shot/shot_bloc.dart';
import 'package:briefshot/widgets/AddShotStepOne.dart';
import 'package:briefshot/widgets/AddShotStepTwo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddMarkerScreen extends StatefulWidget {
  const AddMarkerScreen({Key? key}) : super(key: key);

  @override
  _AddMarkerScreenState createState() => _AddMarkerScreenState();
}

class _AddMarkerScreenState extends State<AddMarkerScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void _goToPage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShotBloc(),
        ),
        BlocProvider(
          create: (context) => LocationBloc(),
        ),
      ],
      child: BlocConsumer<ShotBloc, ShotState>(
        listener: (context, state) {
          if (state.isMapDisplayed) {
            _goToPage(1);
          } else {
            _goToPage(0);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF0B1012),
            appBar: AppBar(
              backgroundColor: const Color(0xFF0B1012),
              toolbarHeight: 84,
              centerTitle: false,
              titleSpacing: 0,
              title: const Text(
                "Ajouter un shot",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "DrukWideWeb",
                  fontSize: 24,
                ),
              ),
              leading: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/arrow.svg",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: AddShotStepOne(),
                      ),
                      AddShotStepTwo(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(11, 16, 18, 0),
                          Color(0xFF0B1012),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  left: 0,
                  bottom: 30,
                  child: Column(
                    children: [
                      if (!state.isMapDisplayed)
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: ElevatedButton(
                              onPressed: (state.shotImage != null &&
                                      (state.shotName != null &&
                                          state.shotName!.isNotEmpty))
                                  ? () {
                                      BlocProvider.of<ShotBloc>(context)
                                          .add(ShotPlaceAsked());
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                backgroundColor: const Color(0xFFE88954),
                                disabledBackgroundColor:
                                    const Color(0xFF9E9E9E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              child: const Text("Continuer"),
                            ),
                          ),
                        ),
                      if (state.isMapDisplayed)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ShotBloc>(context)
                                      .add(ShotPlaceBackAsked());
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1F2E34),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/icons/arrow.svg",
                                      color: Colors.white,
                                    )),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    print(
                                        "INFO : \n ${state.shotName} \n ${state.shotImage!.path} \n ${BlocProvider.of<LocationBloc>(context).state.location!.lat} \n ${BlocProvider.of<LocationBloc>(context).state.location!.lng}");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    backgroundColor: const Color(0xFFE88954),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  child: const Text("Poster"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentPageIndex == 0 ? 30 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: state.shotImage != null &&
                                      (state.shotName != null &&
                                          state.shotName!.isNotEmpty) &&
                                      _currentPageIndex == 0
                                  ? const Color(0xFFE88954)
                                  : const Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentPageIndex == 0 ? 10 : 30,
                            height: 10,
                            decoration: BoxDecoration(
                              color: state.shotImage != null &&
                                      (state.shotName != null &&
                                          state.shotName!.isNotEmpty) &&
                                      _currentPageIndex == 1
                                  ? const Color(0xFFE88954)
                                  : const Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
