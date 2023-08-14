import 'package:flutter/material.dart';

import '../../../core/constants/app_images.dart';
import '../components/day_weather.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              AppImages.backgroundImage,
            ),
          )),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width * .05,
                    vertical: height * .02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        width * 0.05,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Search for a city',
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * .023,
                        horizontal: width * 0.025,
                      ),
                      suffixIconColor: Colors.black45,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(.3),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            width * 0.05,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(.3),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            width * 0.05,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            width * 0.05,
                          ),
                        ),
                      ),
                      fillColor: Colors.white.withOpacity(.3),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) => const DayWeather(),
                  itemCount: 5,
                ))
              ],
            ),
          )),
    );
  }
}
