import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_overview/domain/usecase/location_search/param/index.dart';
import 'package:weather_overview/generated/l10n.dart';
import 'package:weather_overview/injection_container.dart' as di;
import 'package:weather_overview/presentation/index.dart';

@RoutePage<LocationPM>()
class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  late final RootStackRouter _router;
  late final CountriesFetchBloc _countriesFetchBloc;
  late final StatesFetchBloc _stateFetchBloc;
  late final CitiesFetchBloc _citiesFetchBloc;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _countriesFetchBloc = di.sl<CountriesFetchBloc>();
    _stateFetchBloc = di.sl<StatesFetchBloc>();
    _citiesFetchBloc = di.sl<CitiesFetchBloc>();
    _countriesFetchBloc.fetchData(VoidParam());
    _router = di.sl<RootStackRouter>();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocConsumer<CountriesFetchBloc, FetchState<String>>(
              listener: _errorListener,
              bloc: _countriesFetchBloc,
              builder: (BuildContext _, FetchState<String> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedCountry,
                      iconSize: 32,
                      icon: _getDropdownIcon(state),
                      hint: Text(strings.countryTitle),
                      items: (state.items ?? <String>[])
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (String? item) {
                        if (item != null) {
                          setState(() {
                            _selectedCountry = item;
                            _selectedState = null;
                            _selectedCity = null;
                            _stateFetchBloc.fetchData(StateSearchParam(item));
                          });
                        }
                      },
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                );
              },
            ),
            BlocConsumer<StatesFetchBloc, FetchState<String>>(
              listener: _errorListener,
              bloc: _stateFetchBloc,
              builder: (BuildContext _, FetchState<String> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButton<String>(
                      value: _selectedState,
                      isExpanded: true,
                      iconSize: 32,
                      icon: _getDropdownIcon(state),
                      hint: Text(strings.stateTitle),
                      items: (state.items ?? <String>[])
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (String? item) {
                        final countryCopy = _selectedCountry;
                        if (item != null && countryCopy != null) {
                          setState(() {
                            _selectedState = item;
                            _selectedCity = null;
                            _citiesFetchBloc.fetchData(
                              CitySearchParam(
                                country: countryCopy,
                                state: item,
                              ),
                            );
                          });
                        }
                      },
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                );
              },
            ),
            BlocConsumer<CitiesFetchBloc, FetchState<String>>(
              listener: _errorListener,
              bloc: _citiesFetchBloc,
              builder: (BuildContext _, FetchState<String> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButton<String>(
                      value: _selectedCity,
                      icon: _getDropdownIcon(state),
                      isExpanded: true,
                      iconSize: 32,
                      hint: Text(strings.cityTitle),
                      items: (state.items ?? <String>[])
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (String? item) {
                        setState(() {
                          _selectedCity = item;
                        });
                      },
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                );
              },
            ),
            CupertinoButton(
              onPressed:!buttonIgnoringPredicate? () => _router.pop(
                LocationPM(
                  city: _selectedCity,
                  state: _selectedState,
                  country: _selectedCountry,
                ),
              ):null,
              child: Text(strings.addLocationButton),
            )
          ],
        ),
      ),
    );
  }

  SizedBox? _getDropdownIcon(FetchState<String> state) {
    return state.isLoading
        ? SizedBox(
            child: CircularProgressIndicator(),
            height: 26,
            width: 26,
          )
        : null;
  }

  void _errorListener(BuildContext context, FetchState<String> state) {
    final errorCopy = state.error;
    if (errorCopy != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorCopy),
        ),
      );
    }
  }

  bool get buttonIgnoringPredicate =>
      _selectedCountry == null ||
      _selectedState == null ||
      _selectedCity == null;
}
