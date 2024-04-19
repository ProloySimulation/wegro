import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wegro/providers/signup_provider.dart';
import 'package:wegro/util/colors.dart';
import 'package:wegro/widgets/sign_in.dart';
import 'package:wegro/widgets/sign_up.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            MediaQuery.of(context).padding.top) /
                        3,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: kToolbarHeight, // Fixed height for TabBar
                            child: Center(
                              child: TabBar(
                                indicator: BoxDecoration(color: tabBarColor),
                                labelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'Sign Up',),
                                  Tab(text: 'Login'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                SignUp(),
                                SignIn(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// SignIn
