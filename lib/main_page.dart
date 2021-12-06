import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  double devicePixelRatio;
  bool isFullScreen = false;

  @override
  didChangeMetrics() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("devicePixelRatio meter"),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final devicePixelRatio = mediaQuery.devicePixelRatio;
    final size = mediaQuery.size;

    final theme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("devicePixelRatio:", style: theme.headline6.copyWith(fontSize: 24)),
              Text("${devicePixelRatio.toStringAsFixed(3)}", style: theme.headline2),

              SizedBox(height: 16),

              Text("logical scaffold size:", style: theme.headline6),
              Text("${size.width.toStringAsFixed(1)} x ${size.height.toStringAsFixed(1)}", style: theme.headline5),

              SizedBox(height: 16),

              Text("real scaffold size:", style: theme.headline6),
              Text("${(size.width * devicePixelRatio).toStringAsFixed(1)} x ${(size.height * devicePixelRatio).toStringAsFixed(1)}", style: theme.headline5),

              SizedBox(height: 16),

              Text("logical 100 px:", style: theme.headline6),
              SizedBox(height: 4),
              Container(
                width: 100,
                height: 8,
                color: Colors.red,
              ),

              SizedBox(height: 16),

              Text("real 100 px:", style: theme.headline6),
              SizedBox(height: 4),
              Container(
                width: 100 / devicePixelRatio,
                height: 8,
                color: Colors.red,
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  isFullScreen = !isFullScreen;
                  if (isFullScreen)
                    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                  else
                    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
                  setState((){});
                },
                child: Text("Toggle full screen")
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}