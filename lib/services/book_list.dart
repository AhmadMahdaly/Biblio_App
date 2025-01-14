import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await supabase
          .from('books')
          // ignore: avoid_redundant_argument_values
          .select('*')
          .order('created_at', ascending: false);

      setState(() {
        books = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      showSnackBar(context, 'يوجد خطأ في تحميل البيانات:/n$e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(Icons.arrow_back_ios_new)),
        title: const Text('Book List'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : books.isEmpty
              ? const Center(child: Text('No books available'))
              : ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: Image.network(
                          book['cover_image_url'].toString(),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(book['title'].toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Author: ${book['author']}'),
                            Text('Category: ${book['category']}'),
                            Text('Condition: ${book['condition']}'),
                          ],
                        ),
                        trailing: Text(book['offer_type'].toString()),
                        onTap: () {
                          _showBookDetails(context, book);
                        },
                      ),
                    );
                  },
                ),
    );
  }

  void _showBookDetails(BuildContext context, Map<String, dynamic> book) {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(book['title'].toString()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book['cover_image_url'].toString(),
                height: 200, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text('Author: ${book['author']}'),
            Text('Category: ${book['category']}'),
            Text('Condition: ${book['condition']}'),
            Text('Offer Type: ${book['offer_type']}'),
            const SizedBox(height: 10),
            const Text('Description:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(book['description'].toString()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
