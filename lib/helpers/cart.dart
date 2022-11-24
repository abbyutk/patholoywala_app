import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartProvider{

  final int salon;
  static const String SALON_TABLE = 'salon';
  static const String SERVICE_TABLE = 'service';
  static const String CREATE_SALON_TABLE = 'CREATE TABLE $SALON_TABLE ( `salon` INT NOT NULL , `staff` INT, `gender` INT , PRIMARY KEY (`salon`))';
  static const String CREATE_SERVICE_TABLE = 'CREATE TABLE $SERVICE_TABLE ( `salon` INT NOT NULL , `service` INT NOT NULL , FOREIGN KEY (salon) REFERENCES $SALON_TABLE(salon))';

  CartProvider({required this.salon});

   late Database _database ;


  Database get database{
    return _database ;
  }

  initDB() async {
    String documentDirectory = await getDatabasesPath();
    String path = join(documentDirectory,"com.spring360.salon.select");
    _database = await openDatabase(path,version: 1,onOpen: (cart){

    }, onCreate: (Database db, int version) async{
      await db.execute(CREATE_SALON_TABLE);
      await db.execute(CREATE_SERVICE_TABLE);
    });
  }

  void addSalon({required int staff, required bool gender})async{
    List<Map<String,dynamic>> maps = await _database.query(SALON_TABLE,where: 'salon = ?',whereArgs: [salon]);
    if(maps.length == 0){
      await _database.insert(SALON_TABLE, {
        'salon': salon,
        'staff' : staff,
        'gender' : gender ? 1:0
      });
    }
  }
  void addService(int service)async{
    await _database.insert(SERVICE_TABLE, {
      'salon':salon,
      'service':service
    });
  }
  void removeService(int service)async{
    await _database.delete(SERVICE_TABLE,where: 'service=? AND salon=?', whereArgs:[service,salon] );
  }
  void removeSalon(int service)async{
    await _database.delete(SALON_TABLE,where: 'salon=?', whereArgs:[salon] );
  }
  void selectStaff(int staff, bool isSelected)async{
    await _database.update(SALON_TABLE,{'staff':isSelected ? staff : null},where: 'salon = ?', whereArgs: [salon]);
  }
  void selectGender(bool isMale)async{
    await _database.update(SALON_TABLE,{'gender':isMale ? 1 : 0},where: 'salon = ?', whereArgs: [salon]);
  }
  Future<List<int>> getServices()async{
    List<Map<String,dynamic>> maps = await _database.query(SERVICE_TABLE,where: 'salon = ?',whereArgs: [salon]);
    List<int> services = [];
    maps.forEach((element) {services.add(element['service']);});
    return services ;
  }
  void clearService()async{
    await _database.delete(SERVICE_TABLE,where: 'salon = ?',whereArgs: [salon]);
  }
  Future<Map<String,dynamic>> getSalon()async{
    List<Map<String,dynamic>> maps = await _database.query(SALON_TABLE,where: 'salon = ?',whereArgs: [salon]);
    return {
      'staff' : maps[0]['staff'],
      'gender' : maps[0]['gender'] == 1 ? true : false
    };
  }
}