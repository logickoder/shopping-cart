// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      price: (json['price'] as num).toDouble(),
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating.toJson(),
    };

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };
