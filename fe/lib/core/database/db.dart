// Import drift
import 'package:drift/drift.dart';
import 'dart:io'; // Cần cho File


class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100).unique()();
  // Thêm các trường khác nếu cần, ví dụ: 'server_id' để đồng bộ
}


class Units extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50).unique()();
  // Thêm các trường khác nếu cần
}

class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200).unique()();
  TextColumn get imageUrl => text().nullable()(); // Đường dẫn ảnh local hoặc URL

  // Tạo khóa ngoại (Foreign Key) tới bảng Categories và Units
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  IntColumn get unitId => integer().nullable().references(Units, #id)();
  
  // Thêm 'server_id' nếu cần đồng bộ với API
}

class FridgeItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Khóa ngoại tới bảng Foods
  IntColumn get foodId => integer().references(Foods, #id)();
  
  RealColumn get quantity => real()(); 
  DateTimeColumn get expiryDate => dateTime().nullable()();
  DateTimeColumn get addedDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get note => text().nullable()();
  TextColumn get location => text().nullable()();
  

}

class ShoppingLists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get assignedToUsername => text().nullable()(); 
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  
  // 'server_id' (listId từ API) rất quan trọng để đồng bộ
  IntColumn get serverId => integer().nullable().unique()();
}

class ShoppingTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Khóa ngoại tới ShoppingLists và Foods
  IntColumn get listId => integer().references(ShoppingLists, #id)();
  IntColumn get foodId => integer().references(Foods, #id)();
  
  TextColumn get foodName => text()(); 
  TextColumn get quantity => text()(); 
  BoolColumn get isBought => boolean().withDefault(const Constant(false))();
  
  // 'server_id' (taskId từ API) để đồng bộ
  IntColumn get serverId => integer().nullable().unique()();
}

class MealPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  IntColumn get foodId => integer().references(Foods, #id)();
  
  DateTimeColumn get date => dateTime()(); 
  TextColumn get mealType => text()(); 
  
  // 'server_id' (planId từ API) để đồng bộ
  IntColumn get serverId => integer().nullable().unique()();
}

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Khóa ngoại tới Foods (món ăn chính của công thức)
  IntColumn get foodId => integer().references(Foods, #id)();

  TextColumn get name => text().withLength(min: 1)();
  TextColumn get description => text().nullable()();
  TextColumn get htmlContent => text()(); 
  
  // 'server_id' (recipeId từ API) để đồng bộ
  IntColumn get serverId => integer().nullable().unique()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  TextColumn get username => text().unique()(); 
  TextColumn get email => text().unique()(); 
  TextColumn get name => text()(); 
  TextColumn get currentGroupId => text().nullable()(); 
}