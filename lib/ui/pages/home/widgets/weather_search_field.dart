import 'package:flutter/material.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:provider/provider.dart';

class WeatherSearchField extends StatelessWidget {
  const WeatherSearchField({
    Key key,
  }) : super(key: key);

  static const _hintText = 'Gothenburg';

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = Provider.of<BaseWeatherBloc>(context, listen: false);
    return Container(
      constraints: BoxConstraints(minWidth: 150, maxWidth: 700),
      child: Material(
        borderRadius: BorderRadius.circular(4),
        elevation: 8.0,
        shadowColor: Colors.black,
        child: TextField(
          onChanged: (word) => _weatherBloc.onSearch(word),
          style: customTextStyle(context),
          decoration: InputDecoration(
            hintStyle: customTextStyle(context),
            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 32),
            hintText: _hintText,
            fillColor: Colors.white,
            isDense: true,
            enabledBorder: customBorder(),
            focusedBorder: customBorder(),
            suffixIcon: StreamBuilder<bool>(
              stream: _weatherBloc.isLoadingObservable,
              builder: (context, snapshot) {
                final isLoading = snapshot.data;
                if (isLoading == true) {
                  return CircularProgressIndicator();
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder customBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
  }

  TextStyle customTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.title.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        );
  }
}
