import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/custom_elevated_button.dart';
import 'connectivity_controller.dart';

class ConnectivityView extends StatefulWidget {
  const ConnectivityView({super.key});
  @override
  State<ConnectivityView> createState() => _ConnectivityViewState();
}

class _ConnectivityViewState extends State<ConnectivityView> {
  ConnectivityController connectivityController = ConnectivityController();
  @override
  void initState() {
    connectivityController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: connectivityController.isConnected,
        builder: (context, value, child) {
          if (value) {
            return const SizedBox();
          } else {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 100.h,
                  width: 100.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off,
                        size: 30.sp,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const Center(
                        child: Text('No Internet Connection'),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          connectivityController.init();
                        },
                        text: 'Retry',
                        width: 20.w,
                        height: 6.h,
                        borderRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
