import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/search_tile.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/refrigerator/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchViewModel searchViewModel = context.watch<SearchViewModel>();
    return CustomScaffold(
      appBar: CustomAppBar(
        underLine: false,
        titleWidget: TextField(
          controller: searchViewModel.controller,
          autofocus: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          style: Palette.body1,
          cursorColor: Palette.gray900,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            hintText: '추가할 식재료를 검색해 보세요.',
            hintStyle: Palette.body1.copyWith(color: Palette.gray400),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Palette.green500, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Palette.green500, width: 2),
            ),
            suffixIcon: GestureDetector(
              onTap: searchViewModel.search,
              child: const Icon(Icons.search_rounded),
            ),
          ),
          onSubmitted: (_) => searchViewModel.search(),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 24),
        itemCount: searchViewModel.searchedFoods.length,
        itemBuilder: (context, index) => SearchTile(
          title: searchViewModel.searchedFoods[index]['class2'],
          onTap: () => searchViewModel.onTapFood(index),
        ),
        separatorBuilder: (context, index) => const Divider(
          color: Palette.gray100,
          height: 1,
        ),
      ),
    );
  }
}
