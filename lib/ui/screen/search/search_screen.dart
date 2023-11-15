import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pollingstation/provider/search_provider.dart';
import 'package:provider/provider.dart';

import '../../../model/center_model.dart';
import '../../../route.dart';
import '../../widget/custom_text.dart';

class SearchScreen extends StatefulWidget{
  const  SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();

}
class _SearchScreenState extends State<SearchScreen> {
 late SearchProvider searchProvider;
  @override
  void didChangeDependencies() {
    searchProvider = Provider.of<SearchProvider>(context,listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchProvider.disposeController();
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<SearchProvider>(context,listen: false).pagingController.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Center',
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.green),
              child: Container(
                height: 38,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  autofocus: true,
                  controller: provider.searchTextController,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, // This is not so important
                  ),
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        provider.pagingController.refresh();
                      },
                    ),
                    hintText: 'Search...',
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    provider.pagingController.refresh();
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => provider.pagingController.refresh(),
                  ),
                  child: PagedListView<int, Datum>.separated(
                      pagingController: provider.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Datum>(
                          animateTransitions: true,
                          itemBuilder: (context, data, index) {
                            // Translate the index into Bangla.
                            final banglaIndex = NumberFormat.compact(locale: 'bn-BD').format(index + 1);
                            return InkWell(
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomSimpleText(text: '${banglaIndex}.'),
                                      Expanded(
                                        child: CustomSimpleText(
                                          text: data.name!,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.stationDetailsScree,
                                    arguments: data);
                              },
                            );
                          }),
                      separatorBuilder: (context, index) => const SizedBox()),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
