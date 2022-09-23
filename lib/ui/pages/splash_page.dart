import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/remote_config_bloc.dart';
import 'package:healthy_eating/blocs/remote_config_state.dart';
import 'package:healthy_eating/ui/pages/day/day_page.dart';
import 'package:healthy_eating/ui/pages/webview_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    final remConfigBloc = context.read<RemoteConfigBloc>();
    remConfigBloc.getConfig();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
      builder: (context, state) {
        return state.map(
          loading: (loading) => Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                height: width,
                width: width,
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: Image.asset(
                  'assets/images/splash_image.png',
                ),
              ),
            ),
          ),
          data: (data) => WebViewPage(url: data.url),
          condition: (condition) => const DayPage(),
        );
      },
    );
  }
}
