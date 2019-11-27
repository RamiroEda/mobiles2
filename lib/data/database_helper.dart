import 'package:mobiles2/model/prepa_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../model/user_model.dart';

class InfoVal {
  static final InfoVal _instance = InfoVal.internal();
  InfoVal.internal();
  factory InfoVal() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'proyecto_final.db');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: _crearTablas,
    );
    print('[DBHelper] initDB: Success');
    return db;
  }

  void _crearTablas(Database db, int version) async {
    await db.execute(
      'CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)'
    );

    await db.execute(
      'CREATE TABLE Aspirantes(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, apellidos TEXT, edad TEXT, sexo TEXT, correo TEXT, tel TEXT, prepa TEXT, opcion1 TEXT, opcion2 TEXT, opcion3 TEXT)'
    );

    print('[DBHelper] _createTables: Success');
  }

  void guardarUsuario(String email, String password) async {
    var dbClient = await db;
    await dbClient.transaction((trans) async {
      return await trans.rawInsert(
        'INSERT INTO User(email, password) VALUES(\'$email\', \'$password\')',
      );
    });
    print('[DBHelper] saveUser: Success | $email, $password');
  }

  void guardarAspirante(List<dynamic> params) async {
    var dbClient = await db;
    await dbClient.transaction((trans) async {
      return await trans.rawInsert(
        'INSERT INTO Aspirantes(nombre, apellidos, edad, sexo, correo, tel, prepa, opcion1, opcion2, opcion3) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        params
      );
    });
    print('[DBHelper] saveUser: Success | $params');
  }

  Future<void> borrrarAspirante(dynamic id) async {
    var dbClient = await db;
    await dbClient.transaction((trans) async {
      return await trans
        .rawDelete('DELETE FROM Aspirantes WHERE id = ?', [id]);
      });
    print('[DBHelper] saveUser: Success | $id');
  }

  Future<List<Aspirante>> obtenerAspirantes() async {
    var dbClient = await db;
    List<Aspirante> aspirantesList = List();
    List<Map> queryList = await dbClient.rawQuery(
      'SELECT * FROM Aspirantes',
    );

    
    print('[DBHelper] getAspirante: ${queryList.length} aspirantes');
    if (queryList != null && queryList.length > 0) {
      for (int i = 0; i < queryList.length; i++) {
        aspirantesList.add(Aspirante(
          queryList[i]['id'],
          queryList[i]['nombre'],
          queryList[i]['apellidos'],
          queryList[i]['edad'],
          queryList[i]['sexo'],
          queryList[i]['correo'],
          queryList[i]['tel'],
          queryList[i]['prepa'],
          queryList[i]['opcion1'],
          queryList[i]['opcion2'],
          queryList[i]['opcion3'],
        ));
      }
      //print('[DBHelper] getUser: ${usersList[0].name}');
      return aspirantesList;
    } else {
      print('[DBHelper] getUser: User is null');
      return [];
    }
  }

  Future<List<User>> obtenerUsuario(String email, String password) async {
    var dbClient = await db;
    List<User> usersList = List();
    List<Map> queryList = await dbClient.rawQuery(
      'SELECT * FROM User WHERE email=\'$email\' AND password=\'$password\'',
    );

    
    print('[DBHelper] getUser: ${queryList.length} users');
    if (queryList != null && queryList.length > 0) {
      for (int i = 0; i < queryList.length; i++) {
        usersList.add(User(
          queryList[i]['id'].toString(),
          queryList[i]['email'],
          queryList[i]['password'],
        ));
      }
      //print('[DBHelper] getUser: ${usersList[0].name}');
      return usersList;
    } else {
      print('[DBHelper] getUser: User is null');
      return [];
    }
  }
void getEmail(){
  
}


String sqlPrepasInsterar = "INSERT INTO Escuelas (id, nombre, clave) VALUES"+ 
"  (1, ' Preparatoria Independencia de Río Grande', ' 32PBH0002I'),"+ 
"  (2, ' Juana de Arco', ' 32PBH0003H'),"+ 
"  (3, ' Colegio del Centro', ' 32PBH0005F'),"+ 
"  (4, ' Escuela Prep Instituto Zacatecas', ' 32PBH0018J'),"+ 
"  (5, ' Instituto Tecnológico y de Estudios Superiores de Monterrey Campus Zacatecas', ' 32PBH0036Z'),"+ 
"  (6, ' Preparatoria UAF', ' 32PBH0042J'),"+ 
"  (7, ' Preparatoria Vetagrande', ' 32PBH0050S'),"+ 
"  (8, ' Instituto Pedagógico J. Peaget', ' 32PBH0051R'),"+ 
"  (9, ' Instituto Educativo de Zacatecas', ' 32PBH0052Q'),"+ 
"  (10, ' Colegio Federico Froebel', ' 32PBH0053P'),"+ 
"  (11, ' Centro Escolar Lancaster de Zacatecas', ' 32PBH0056M'),"+ 
"  (12, ' Universidad Autónoma de Durango Campus Zacatecas', ' 32PBH0060Z'),"+ 
"  (13, ' Lic. José Minero Roque', ' 32PBH0065U'),"+ 
"  (14, ' Preparatoria Comercial Sor Juana Inés de La Cruz', ' 32PBH0069Q'),"+ 
"  (15, ' Academia Comercial Remington', ' 32PBH0070F'),"+ 
"  (16, ' Preparatoria San Matías', ' 32PBH0071E'),"+ 
"  (17, ' Instituto Maxwell', ' 32PBH0077Z'),"+ 
"  (18, ' Colegio Juan Pablo Ii', ' 32PBH0078Y'),"+ 
"  (19, ' Colegio Daniel Márquez Medina A.C.', ' 32PBH0079X'),"+ 
"  (20, ' Colegio Santa Elena', ' 32PBH0080M'),"+ 
"  (21, ' Instituto de Formación Integral de Zacatecas', ' 32PBH0082K'),"+ 
"  (22, ' Escuela Preparatoria Particular Ramón  López Velarde', ' 32PBH0085H'),"+ 
"  (23, ' Instituto Ausubel', ' 32PBH0086G'),"+ 
"  (24, ' Instituto Educativo Nochistlan', ' 32PBH0088E'),"+ 
"  (25, ' Liceo E.S.L. Guadalupe', ' 32PBH0092R'),"+ 
"  (26, ' Liceo Universitario Guadalupe', ' 32PBH0093Q'),"+ 
"  (27, ' Instituto del Carmen de Guadalupe', ' 32PBH0094P'),"+ 
"  (28, ' Instituto de Educación MONREAL Sandoval', ' 32PBH0096N'),"+ 
"  (29, ' CONSEJO Educativo de Zacatecas', ' 32PBH0097M'),"+ 
"  (30, ' Colegio Juan Pablo Ii El Grande', ' 32PBH0098L'),"+ 
"  (31, ' Superior Teaching Preparatoria', ' 32PBH0102H'),"+ 
"  (32, ' Bachillerato General Sierra Madre', ' 32PBH0105E'),"+ 
"  (33, ' Instituto Educativo de Calera', ' 32PBH0106D'),"+ 
"  (34, ' Instituto Asis de Guadalupe', ' 32PBH0107C'),"+ 
"  (35, ' Colegio Río Grande', ' 32PBH0108B'),"+ 
"  (36, ' Instituto Edison Ac', ' 32PCB0021B'),"+ 
"  (37, ' Cultura  Educación de Fresnillo Asociación Civil', ' 32PCB0022A'),"+ 
"  (38, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32DMS0001Q'),"+ 
"  (39, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32DMS0002P'),"+ 
"  (40, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32DMS0003O'),"+ 
"  (41, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0001P'),"+ 
"  (42, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0002O'),"+ 
"  (43, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0003N'),"+ 
"  (44, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0004M'),"+ 
"  (45, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0005L'),"+ 
"  (46, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0006K'),"+ 
"  (47, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0007J'),"+ 
"  (48, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0010X'),"+ 
"  (49, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0012V'),"+ 
"  (50, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0013U'),"+ 
"  (51, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0014T'),"+ 
"  (52, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0015S'),"+ 
"  (53, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0016R'),"+ 
"  (54, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0017Q'),"+ 
"  (55, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0018P'),"+ 
"  (56, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0019O'),"+ 
"  (57, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0021C'),"+ 
"  (58, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0022B'),"+ 
"  (59, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0023A'),"+ 
"  (60, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0024Z'),"+ 
"  (61, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0025Z'),"+ 
"  (62, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0026Y'),"+ 
"  (63, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0027X'),"+ 
"  (64, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0028W'),"+ 
"  (65, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0029V'),"+ 
"  (66, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0030K'),"+ 
"  (67, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0031J'),"+ 
"  (68, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0032I'),"+ 
"  (69, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0033H'),"+ 
"  (70, ' El Cazadero', ' 32EMS0035F'),"+ 
"  (71, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0036E'),"+ 
"  (72, ' Educación Media Superior A Distancia', ' 32EMS0037D'),"+ 
"  (73, ' Educación Media Superior A Distancia', ' 32EMS0038C'),"+ 
"  (74, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0039B'),"+ 
"  (75, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0040R'),"+ 
"  (76, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0041Q'),"+ 
"  (77, ' Centro de Servicios de Educación Media Superior A Distancia', ' 32EMS0042P'),"+ 
"  (78, ' Profr. José Santos Valdez', ' 32DBP0002M'),"+ 
"  (79, ' Lic. Mauricio Magdaleno', ' 32EBH0001D'),"+ 
"  (80, ' José G Montes', ' 32EBH0002C'),"+ 
"  (81, ' Profa. Ma de La O Marín Mota', ' 32EBH0003B'),"+ 
"  (82, ' Francisco García Salinas', ' 32EBH0006Z'),"+ 
"  (83, ' Escuela Preparatoria José Rodríguez Elías', ' 32EBH0007Y'),"+ 
"  (84, ' Valentín Gómez Farías', ' 32EBH0008X'),"+ 
"  (85, ' Prof. Salvador Vidal G', ' 32EBH0009W'),"+ 
"  (86, ' González Ortega', ' 32EBH0011K'),"+ 
"  (87, ' Ing.  Gral. Felipe B. Berriozabal', ' 32EBH0019C'),"+ 
"  (88, ' Gral Lazaro Cardenas', ' 32EBH0020S'),"+ 
"  (89, ' Victor Rosales', ' 32EBH0027L'),"+ 
"  (90, ' Preparatoria Villanueva', ' 32EBH0028K'),"+ 
"  (91, ' Candelario Huizar', ' 32EBH0030Z'),"+ 
"  (92, ' Panfilo Natera', ' 32EBH0031Y'),"+ 
"  (93, ' Lazaro Cardenas del Río', ' 32EBH0032X'),"+ 
"  (94, ' José Vasconcelos', ' 32EBH0033W'),"+ 
"  (95, ' Beatriz Márquez Acosta', ' 32EBH0034V'),"+ 
"  (96, ' Ramón  López Velarde', ' 32EBH0035U'),"+ 
"  (97, ' Adolfo López Mateos', ' 32EBH0036T'),"+ 
"  (98, ' Jaime Torres Bodet', ' 32EBH0037S'),"+ 
"  (99, ' Tayahua', ' 32EBH0038R'),"+ 
"  (100, ' Genaro Codina', ' 32EBH0039Q'),"+ 
"  (101, ' Lic. Agustín Yañez', ' 32EBH0040F'),"+ 
"  (102, ' Felix U Gómez', ' 32EBH0041E'),"+ 
"  (103, ' Francisco Goitia', ' 32EBH0042D'),"+ 
"  (104, ' Jesús Reyes Heroles', ' 32EBH0043C'),"+ 
"  (105, ' Daniel Camarena', ' 32EBH0044B'),"+ 
"  (106, ' Genaro Codina', ' 32EBH0045A'),"+ 
"  (107, ' Eulalio Gutiérrez', ' 32EBH0046Z'),"+ 
"  (108, ' Salvador Varela Resendiz', ' 32EBH0048Y'),"+ 
"  (109, ' Colegio de Bachilleres ZACATECAS', ' 32ECB0001I'),"+ 
"  (110, ' Colegio de Bachilleres', ' 32ECB0002H'),"+ 
"  (111, ' Colegio de Bachilleres', ' 32ECB0003G'),"+ 
"  (112, ' Colegio de Bachilleres', ' 32ECB0005E'),"+ 
"  (113, ' Colegio de Bachilleres', ' 32ECB0006D'),"+ 
"  (114, ' Colegio de Bachilleres Ojocaliente', ' 32ECB0007C'),"+ 
"  (115, ' Colegio de Bachilleres Pinos', ' 32ECB0008B'),"+ 
"  (116, ' Colegio de Bachilleres Sain Alto', ' 32ECB0009A'),"+ 
"  (117, ' Colegio de Bachilleres', ' 32ECB0010Q'),"+ 
"  (118, ' Colegio de Bachilleres', ' 32ECB0011P'),"+ 
"  (119, ' Colegio de Bachilleres', ' 32ECB0012O'),"+ 
"  (120, ' Colegio de Bachilleres', ' 32ECB0013N'),"+ 
"  (121, ' Colegio de Bachilleres', ' 32ECB0014M'),"+ 
"  (122, ' Colegio de Bachilleres Plantel Cañitas de Felipe Pescador', ' 32ECB0015L'),"+ 
"  (123, ' Colegio de Bachilleres', ' 32ECB0016K'),"+ 
"  (124, ' Colegio de Bachilleres', ' 32ECB0017J'),"+ 
"  (125, ' Colegio de Bachilleres', ' 32ECB0018I'),"+ 
"  (126, ' Colegio de Bachilleres', ' 32ECB0019H'),"+ 
"  (127, ' Colegio de Bachilleres', ' 32ECB0020X'),"+ 
"  (128, ' Luis de La Rosa Oteiza', ' 32ECB0022V'),"+ 
"  (129, ' Colegio de Bachilleres', ' 32ECB0023U'),"+ 
"  (130, ' Colegio de Bachilleres', ' 32ECB0024T'),"+ 
"  (131, ' Colegio de Bachilleres', ' 32ECB0025S'),"+ 
"  (132, ' Colegio de Bachilleres', ' 32ECB0026R'),"+ 
"  (133, ' Colegio de Bachilleres', ' 32ECB0027Q'),"+ 
"  (134, ' Colegio de Bachilleres', ' 32ECB0028P'),"+ 
"  (135, ' Colegio de Bachilleres Plantel Sombrerete', ' 32ECB0029O'),"+ 
"  (136, ' Colegio de Bachilleres', ' 32ECB0030D'),"+ 
"  (137, ' Colegio de Bachilleres', ' 32ECB0031C'),"+ 
"  (138, ' Colegio de Bachilleres', ' 32ECB0032B'),"+ 
"  (139, ' Colegio de Bachilleres Victor Rosales', ' 32ECB0033A'),"+ 
"  (140, ' Colegio de Bachilleres', ' 32ECB0034Z'),"+ 
"  (141, ' Colegio de Bachilleres', ' 32ECB0035Z'),"+ 
"  (142, ' Colegio de Bachilleres Roberto Cabral del Hoyo', ' 32ECB0036Y'),"+ 
"  (143, ' Colegio de Bachilleres', ' 32ECB0037X'),"+ 
"  (144, ' Colegio de Bachilleres Plantel EL Fuerte', ' 32ECB0038W'),"+ 
"  (145, ' Colegio de Bachilleres Plantel Trancoso', ' 32ECB0039V'),"+ 
"  (146, ' Colegio de Bachilleres Plantel Chaparrosa', ' 32ECB0040K'),"+ 
"  (147, ' Colegio de Bachilleres Plantel Los Campos', ' 32ECB0041J'),"+ 
"  (148, ' Preparatoria Núm. 1', ' 32UBH0001V'),"+ 
"  (149, ' Preparatoria Núm. 1', ' 32UBH0001V'),"+ 
"  (150, ' Preparatoria Núm. 2', ' 32UBH0002U'),"+ 
"  (151, ' Preparatoria Núm. 2', ' 32UBH0002U'),"+ 
"  (152, ' Preparatoria Núm. 3', ' 32UBH0003T'),"+ 
"  (153, ' Preparatoria Núm. 3', ' 32UBH0003T'),"+ 
"  (154, ' Preparatoria Núm. 4', ' 32UBH0004S'),"+ 
"  (155, ' Preparatoria Núm. 4', ' 32UBH0004S'),"+ 
"  (156, ' Preparatoria Núm. 5', ' 32UBH0005R'),"+ 
"  (157, ' Preparatoria Núm. 6', ' 32UBH0006Q'),"+ 
"  (158, ' Preparatoria Núm. 7', ' 32UBH0007P'),"+ 
"  (159, ' Preparatoria Núm. 8', ' 32UBH0008O'),"+ 
"  (160, ' Preparatoria Núm. 9', ' 32UBH0009N'),"+ 
"  (161, ' Preparatoria Núm. 10', ' 32UBH0010C'),"+ 
"  (162, ' Preparatoria Núm. 10', ' 32UBH0010C'),"+ 
"  (163, ' Preparatoria Núm. 11', ' 32UBH0011B'),"+ 
"  (164, ' Preparatoria Núm. 12', ' 32UBH0012A'),"+ 
"  (165, ' Preparatoria Núm. 13', ' 32UBH0013Z'),"+ 
"  (166, ' Preparatoria Núm. 13', ' 32UBH0013Z'),"+ 
"  (167, ' Colegio de Estudios Científicos y Tecnológicos del Estado Plantel  Victor Rosales', ' 32ETC0001Y'),"+ 
"  (168, ' Colegio de Estudios Científicos y Tecnológicos del Estado  Plantel Tlaltenango', ' 32ETC0002X'),"+ 
"  (169, ' Colegio de Estudios Científicos y Tecnológicos del Estado  Plantel Río Grande', ' 32ETC0003W'),"+ 
"  (170, ' Cecyte Plantel San José de Lourdes', ' 32ETC0004V'),"+ 
"  (171, ' Colegio de Estudios Científicos y Tecnológicos del Edo.', ' 32ETC0005U'),"+ 
"  (172, ' Colegio de Estudios Científicos y Tecnológicos del Estado', ' 32ETC0006T'),"+ 
"  (173, ' Centro de Estudios Científicos y Tecnológicos del Estado', ' 32ETC0007S'),"+ 
"  (174, ' Colegio de Estudios Científicos y Tecnológicos del Estado', ' 32ETC0009Q'),"+ 
"  (175, ' Centro de Estudios Tecnológicos Industriales y de Servicios Num.147', ' 32DCT0001Z'),"+ 
"  (176, ' Centro de Bachillerato Tecnológicos Industrial y de Servicios Núm. 23', ' 32DCT0085X'),"+ 
"  (177, ' Centro de Bachillerato Tecnológicos Industrial y de Servicios Núm. 1', ' 32DCT0138L'),"+ 
"  (178, ' Centro de Bachillerato Tecnológicos Industrial y de Servicios Núm. 1', ' 32DCT0138L'),"+ 
"  (179, ' Centro de Bachillerato Tecnológicos Industrial y de Servicios Núm. 104', ' 32DCT0348Q'),"+ 
"  (180, ' Centro de Bachillerato Tecnológicos Industrial y de Servicios Núm. 141', ' 32DCT0349P'),"+ 
"  (181, ' Centro de Bachillerato Tecnológicos Industrial y de Servicios Núm. 215', ' 32DCT0350E'),"+ 
"  (182, ' Centro de Bachillerato Tecnológicos Industrial y de Servicios Núm. 221', ' 32DCT0351D'),"+ 
"  (183, ' Centro de Estudios Tecnológicos Industriales y de Servicios Núm. 113', ' 32DCT0352C'),"+ 
"  (184, ' Centro de Estudios Tecnológicos Industrales y de Servicios Núm. 114', ' 32DCT0353B'),"+ 
"  (185, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 166', ' 32DTA0001A'),"+ 
"  (186, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 137', ' 32DTA0002Z'),"+ 
"  (187, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 167', ' 32DTA0003Z'),"+ 
"  (188, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 138', ' 32DTA0004Y'),"+ 
"  (189, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 188', ' 32DTA0005X'),"+ 
"  (190, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 189', ' 32DTA0006W'),"+ 
"  (191, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 20', ' 32DTA0020P'),"+ 
"  (192, ' Centro de Bachillerato Tecnológico Agropecuario Núm. 88', ' 32DTA0088W'),"+ 
"  (193, ' Centro de Bachillerato Tecnológico Agropecuario Num.285', ' 32DTA0285X'),"+ 
"  (194, ' Centro de Bachillerato Tecnológico Agropecuario Num.286', ' 32DTA0286W'),"+ 
"  (195, ' Centro de Estudios Científicos y Tecnológicos del Estado', ' 32ETC0008R'),"+ 
"  (196, ' Centro de Estudios Científicos y Tecnológicos del Estado', ' 32ETC0008R'),"+ 
"  (197, ' Instituto Universitario Metropolitano', ' 32PET0001B'),"+ 
"  (198, ' Escuela de Enfermería  Beatriz González Ortega', ' 32EET0003U'),"+ 
"  (199, ' Colegio de Educación Profesional Técnica del Estado de Zacatecas', ' 32DPT0001C'),"+ 
"  (200, ' Colegio de Educación Profesional Técnica del Estado de Zacatecas', ' 32DPT0002B'),"+ 
"  (201, ' Colegio de Educación Profesional Técnica del Estado de Zacatecas', ' 32DPT0003A'),"+ 
"  (202, ' Centro de Estudios Científicos y Tecnológicos 18 “Zacatecas”', ' 32DPN0001S'),"+ 
"  (203, 'COBAEE', 'Desconocida'),"+ 
"  (204, 'CECYT 18', 'Desconocida'),"+ 
"  (205, '', 'Desconocida'),"+ 
"  (206, '', 'Desconocida'),"+ 
"  (207, '', 'Desconocida'),"+ 
"  (208, '', 'Desconocida'),"+ 
"  (209, '', 'Desconocida'),"+ 
"  (210, 'CECyT 18', 'Desconocida'),"+ 
"  (211, 'Salvador Varela Resendiz', 'Desconocida'),"+ 
"  (212, 'INSTITUTO UNIVERSITARIO DEL CENTRO DE MÉXICO', 'Desconocida'),"+ 
"  (213, 'Colegio de bachilleres plantel villa de cos', 'Desconocida'),"+ 
"  (214, 'Colegio de Bachilleres del estado de Zacatecas plantel 07 ojocali', 'Desconocida'),"+ 
"  (215, 'Instituto Politécnico Nacional', 'Desconocida'),"+ 
"  (216, 'CECyTEZ Tlaltenango', 'Desconocida'),"+ 
"  (217, 'Universidad autónoma de zacatecas preparatoria #4', 'Desconocida'),"+ 
"  (218, 'Universidad Autónoma de Zacatecas Plantel IV', 'Desconocida'),"+ 
"  (219, 'Instituto Miguel Agustín Pro', 'Desconocida'),"+ 
"  (220, 'Unidad Académica Preparatoria Programa IV', 'Desconocida'),"+ 
"  (221, 'Universidad Autonoma de Zacatecas Unidad Academica Preparatora 4', 'Desconocida'),"+ 
"  (222, 'emsad ramon lopez velarde', 'Desconocida'),"+ 
"  (223, 'EMSaD Ramon López Velarde', 'Desconocida'),"+ 
"  (224, 'Educación Media Superior a Distancia \"Ramon Lopez Velarde\"', 'Desconocida'),"+ 
"  (225, 'EMSaD El Rucio', 'Desconocida'),"+ 
"  (226, 'EMSaD El Rucio', 'Desconocida'),"+ 
"  (227, 'EMSaD CECYTEZ EL RUCIO VILLA DE COS ZACATECAS', 'Desconocida'),"+ 
"  (228, 'Escuela preparatoria estatal “ Victor Rosales “', 'Desconocida'),"+ 
"  (229, 'Preparatoria Estatal Víctor Rosales', 'Desconocida'),"+ 
"  (230, 'Preparatoria #1 UAZ', 'Desconocida'),"+ 
"  (231, 'Universidad Autónoma de Zacatecas Programa 1', 'Desconocida'),"+ 
"  (232, 'Roberto Cabral del Hoyo Cobaez', 'Desconocida'),"+ 
"  (233, 'univeraidas autonoma de zacatecas programa lV', 'Desconocida'),"+ 
"  (234, 'Cbta 138', 'Desconocida'),"+ 
"  (235, 'Cbta 138', 'Desconocida'),"+ 
"  (236, 'Cbta 138', 'Desconocida'),"+ 
"  (237, 'Cbta 138', 'Desconocida'),"+ 
"  (238, 'Universidad Autónoma de Zacatecas programa IV', 'Desconocida'),"+ 
"  (239, 'Colegio de bachilleres del estado de Zacatecas', 'Desconocida'),"+ 
"  (240, 'Liceo E.S.L. Guadalupe', 'Desconocida');";


}
