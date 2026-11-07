import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 5;
  final _reviewController = TextEditingController();

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      // TODO: Submit review to API
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Review submitted!')));
      // Reset form
      setState(() {
        _rating = 5;
        _reviewController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tulis ulasan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  _rating > index ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          TextFormField(
            controller: _reviewController,
            decoration: InputDecoration(
              labelText: 'Tulis komentar',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          ElevatedButton(onPressed: _submitReview, child: Text('Kirim')),
        ],
      ),
    );
  }
}
