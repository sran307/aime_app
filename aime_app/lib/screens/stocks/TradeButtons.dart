import 'package:dailyme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/urls.dart';
import 'package:get/get.dart';
import 'package:dailyme/screens/stocks/TrendySector.dart';
import 'package:dailyme/screens/stocks/PennyStocks.dart';
import 'package:dailyme/screens/stocks/ScreenStocks.dart';
import 'package:dailyme/screens/stocks/SwingStocks.dart';
import 'package:dailyme/screens/stocks/LongStocks.dart';


class TradeButtons extends StatefulWidget {
  const TradeButtons({super.key});

  @override
  _TradeButtonsState createState() => _TradeButtonsState();
}

class _TradeButtonsState extends State<TradeButtons> with TickerProviderStateMixin {
  late AnimationController controller;
  
  final Map<String, bool> _isLoading = {};
  final Map<String, double> _progress = {};

  Future<void> _handleButtonPress(String buttonKey, Future<void> Function() apiCall) async {
    setState(() {
      _isLoading[buttonKey] = true;
       _progress[buttonKey] = 0.0;
    });

     
    // Simulate a download by updating the progress in a loop
    // for (int i = 1; i <= 100; i++) {
    //   await Future.delayed(const Duration(milliseconds: 50));
    //   setState(() {
    //     _progress[buttonKey] = i.abs() / 100;
    //   });
    //   if(i==100){
    //     i=(-100);
    //   }
    //   if(i==0){
    //     i=1;
    //   }
    // }
    await apiCall();
    setState(() {
      _isLoading[buttonKey] = false;
      _progress[buttonKey] = 1.0; // Complete
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: kPrimaryGradientColor,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('getHolidays', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(getHolidays);
                          }),
                          child: _isLoading['getHolidays'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['getHolidays'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              : const Text('Get Holidays'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('getSlug', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(getSlug);
                          }),
                          child: _isLoading['getSlug'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['getSlug'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              : const Text('Get Ticker Slug'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('getNewStock', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(getNewStock);
                          }),
                          child: _isLoading['getNewStock'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['getNewStock'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              :const Text('Get New Stock'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('getStockName', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(getStockName);
                          }),
                          child: _isLoading['getStockName'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['getStockName'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              :const Text('Get Stock Name'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('getQuotes', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(getQuotes);
                          }),
                          child: _isLoading['getQuotes'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['getQuotes'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              :const Text('Get Trading Stocks'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('getSector', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(getSector);
                          }),
                          child: _isLoading['getSector'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['getSector'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              :const Text('Get Sector'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('getFunda', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(getFunda);
                          }),
                          child: _isLoading['getFunda'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['getFunda'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              :const Text('Get Stock Fundamentals'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress('updateDaily', () async {
                            TokenHandler tokenHandler = TokenHandler(context);
                            await tokenHandler.getCommonData(updateDaily);
                          }),
                          child: _isLoading['updateDaily'] ?? false
                              ? Column(
                                  children: [
                                    const Text('Importing...'),
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              kSuccessColor),
                                      // value: _progress['updateDaily'],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                )
                              :const Text('Update Daily Data'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                           onPressed: () {
                            Get.to(TrendySector(),
                                transition: Transition.circularReveal);
                          },
                          child: const Text('Get Trending Sector'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                           onPressed: () {
                            Get.to(PennyStocks(),
                                transition: Transition.circularReveal);
                          },
                          child: const Text('Get Penny Stocks'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                           onPressed: () {
                            Get.to(ScreenStocks(),
                                transition: Transition.circularReveal);
                          },
                          child: const Text('Get Screened Stocks'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                           onPressed: () {
                            Get.to(SwingStocks(),
                                transition: Transition.circularReveal);
                          },
                          child: const Text('Get Swing Stocks'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                           onPressed: () {
                            Get.to(LongStocks(),
                                transition: Transition.circularReveal);
                          },
                          child: const Text('Get Long Position Stocks'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
