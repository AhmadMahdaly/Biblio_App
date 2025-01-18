import 'package:biblio/screens/home_page/models/categories_model.dart';
import 'package:biblio/screens/home_page/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListview extends StatefulWidget {
  const CategoryListview({super.key});

  @override
  State<CategoryListview> createState() => _CategoryListviewState();
}

class _CategoryListviewState extends State<CategoryListview> {
  final List<CategoriesModel> bookCategory = [
    CategoriesModel(
      category: 'الأدب والرواية',
      icon: 'assets/images/categories/literature.png',
    ),
    CategoriesModel(
      category: 'العلوم',
      icon: 'assets/images/categories/test-tube.png',
    ),
    CategoriesModel(
      category: 'العلوم الاجتماعية',
      icon: 'assets/images/categories/light-bulb.png',
    ),
    CategoriesModel(
      category: 'التاريخ والجغرافيا',
      icon: 'assets/images/categories/history.png',
    ),
    CategoriesModel(
      category: 'الدين',
      icon: 'assets/images/categories/mosque.png',
    ),
    CategoriesModel(
      category: 'التنمية الذاتية',
      icon: 'assets/images/categories/self-confidence.png',
    ),
    CategoriesModel(
      category: 'الفنون',
      icon: 'assets/images/categories/art-book.png',
    ),
    CategoriesModel(
      category: 'الأطفال',
      icon: 'assets/images/categories/playtime.png',
    ),
    CategoriesModel(
      category: 'الطب والصحة',
      icon: 'assets/images/categories/medicine.png',
    ),
    CategoriesModel(
      category: 'الأعمال والمال',
      icon: 'assets/images/categories/wallet.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CategoryItem(
          bookCategory: bookCategory[index],
        );
      },
      itemCount: bookCategory.length,
    );
  }
}
