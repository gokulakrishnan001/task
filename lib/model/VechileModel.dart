import 'package:hive/hive.dart';
 part 'VechileModel.g.dart';

@HiveType(typeId: 0)
class VechileModel{
  @HiveField(0)
  final String vechileName;
  @HiveField(1)
  final String vechileMileage;
  @HiveField(2)
  final String vechileImage;
  @HiveField(3)
  final String vechileAge;

  const VechileModel(this.vechileName,this.vechileMileage,this.vechileImage,this.vechileAge);
}