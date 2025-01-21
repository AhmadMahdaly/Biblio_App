import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> favoriteBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        print('User not logged in');
        return;
      }

      final response = await supabase
          .from('favorites')
          .select('book_id')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      if (response != null) {
        setState(() {
          favoriteBooks = List<Map<String, dynamic>>.from(response);
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteBooks.isEmpty
              ? Center(child: Text('No favorites added yet!'))
              : ListView.builder(
                  itemCount: favoriteBooks.length,
                  itemBuilder: (context, index) {
                    final favorite = favoriteBooks[index];
                    return ListTile(
                      title: Text(favorite['book_id'].toString()),
                    );
                  },
                ),
    );
  }
}
