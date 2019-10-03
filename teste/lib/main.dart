import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Aluno {
  String nome;
  String matricula;

  Aluno(String nome, String matricula) {
    this.nome = nome;
    this.matricula = matricula;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'matricula': matricula,
    };
  }
}

class Disciplina {
  String nome;
  String id;

  Disciplina(String nome, String id) {
    this.nome = nome;
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'id': id,
    };
  }
}

class Professor {
  String nome;
  String matricula;

  Professor(String nome, String matricula) {
    this.nome = nome;
    this.matricula = matricula;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'matricula': matricula,
    };
  }
}

class Curso {
  String nome;
  String id;

  Curso(String nome, String id) {
    this.nome = nome;
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'id': id,
    };
  }
} 

class BancoDeDados {
  Database database;

  void criar () async {
    database = await openDatabase(
      join (await getDatabasesPath(), 'BD.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE professores(matricula INTEGER PRIMARY KEY, nome TEXT)",
        );
        return db.execute(
          "CREATE TABLE professores(matricula INTEGER PRIMARY KEY, nome TEXT)",
        );
        return db.execute(
          "CREATE TABLE cursos(matricula INTEGER PRIMARY KEY, nome TEXT)",
        );
        return db.execute(
          "CREATE TABLE alunos(matricula INTEGER PRIMARY KEY, nome TEXT)",
        );
        return db.execute(
          "CREATE TABLE disciplinas(matricula INTEGER PRIMARY KEY, nome TEXT)",
        );
      },
      version: 1,
    );
  }

  void salvarProfessor(Professor professor) async {
    // Get a reference to the database.
    final Database db = database;

    await db.insert(
      'professores',
      professor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Professor>> pegarProfessores() async {
    // Get a reference to the database.
    final Database db = database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('professores');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Professor(
        maps[i]['nome'],
        maps[i]['matricula'].toString(),
      );
    });
  }


  void deletarProfessor(String matricula) async {
    final Database db = database;
    await db.delete (
      'professores', where: "matricula = ?",
      whereArgs: [matricula]
    );
  }

  void salvarCurso(Curso cursos)async{
    final Database db = database; 
    await db.insert(
      'cursos',
      cursos.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void deletarCurso(String id) async {
    final Database db = database;
    await db.delete (
      'cursos', where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<List<Curso>> pegarCursos() async {
    // Get a reference to the database.
    final Database db = database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('cursos');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Curso (
        maps[i]['nome'],
        maps[i]['id'].toString(),
      );
    });
  }

  void salvarAluno(Aluno alunos)async{
    final Database db = database; 
    await db.insert(
      'alunos',
      alunos.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void deletarAluno(String matricula) async {
    final Database db = database;
    await db.delete (
      'alunos', where: "matricula = ?",
      whereArgs: [matricula]
    );
  }

  Future<List<Aluno>> pegarAluno() async {
    // Get a reference to the database.
    final Database db = database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('alunos');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Aluno (
        maps[i]['nome'],
        maps[i]['matricula'].toString(),
      );
    });
  }

  void salvarDisciplina(Disciplina disciplinas)async{
    final Database db = database; 
    await db.insert(
      'disciplinas',
      disciplinas.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void deletarDisciplina(String id) async {
    final Database db = database;
    await db.delete (
      'disciplinas', where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<List<Disciplina>> pegarDisciplina() async {
    // Get a reference to the database.
    final Database db = database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('disciplinas');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Disciplina (
        maps[i]['nome'],
        maps[i]['id'].toString(),
      );
    });
  }

}


BancoDeDados bd = new BancoDeDados();
void main() async {
  bd.criar();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magister',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Magister'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class TelaCriarProfessor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child:ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text("Insira nome:"),
          TextField(
            controller: editorNomeProfessor,
          ),

          Text("Insira matrícula:"),
          TextField(
            controller: editorMatriculaProfessor,
            keyboardType: TextInputType.numberWithOptions(),
          ),

          Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              child: Text("Inserir"),
              color: Colors.blue,
              onPressed: () {
                _onPressedBotaoCriarProfessor(); 
                Navigator.pop(context);
              },
            )
          ),
        ],
      )
    );
  }
}

class TelaCriarAluno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text("Insira Nome:"),
          TextField(
            controller: editorNomeAluno,
          ),

          Text("Insira matrícula:"),
          TextField( 
            controller: editorMatriculaAluno,
            keyboardType: TextInputType.numberWithOptions(),
          ),

          Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              child: Text('Inserir'),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                _onPressedBotaoCriarAluno();
              },
            )
          ),
        ],
      ),
    );
  }
}

class TelaCriarDiciplina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text("Insira Nome:"),
          TextField(
            controller: editorNomeDisciplina,
          ),

          Text("Insira ID:"),
          TextField( 
            controller: editorIdDisciplina,
            keyboardType: TextInputType.numberWithOptions(),
          ),

          Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              child: Text('Inserir'),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                _onPressedBotaoCriarDisciplina();
              },
            )
          ),
        ],
      ),
    );
  }
}

class TelaCriarCurso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text("Insira nome:"),
          TextField(
            controller: editorNomeCurso,
          ),

          Text("Insira Id:"),
          TextField(
            controller: editorIdCurso,
            keyboardType: TextInputType.numberWithOptions(),
          ),

          Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              child: Text("Inserir"),
              color: Colors.blue,
              onPressed: () {
                _onPressedBotaoCriarCurso();
                Navigator.pop(context);
              },
            )
          ),
        ],
      )
    );
  }
}

class ListarProfessores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> lista = List<Widget>();




    return null;
  }
}

class ListarCursos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> lista = List<Widget>();




    return null;
  }
}




void _onPressedBotaoCriarProfessor() async {
  Professor p = new Professor(    
    editorNomeProfessor.text,
    editorMatriculaProfessor.text
  );

  bd.salvarProfessor(p);

  professores.add(new Professor(
    editorNomeProfessor.text,
    editorMatriculaProfessor.text
  ));
  

  List<Professor> profs = await bd.pegarProfessores();

  tabelaProfessor = [];
  for (Professor p in profs) {
    tabelaProfessor.add(
      FlatButton(
        child: Text(p.nome + ' - ' + p.matricula),
        onPressed: (){
          bd.deletarProfessor(p.matricula);
        },
      )
    );
  } 
}

void _onPressedBotaoCriarDisciplina() async {
  Disciplina d = new Disciplina(    
    editorNomeDisciplina.text,
    editorIdDisciplina.text
  );

  bd.salvarDisciplina(d);

  disciplinas.add(new Disciplina(
    editorNomeDisciplina.text,
    editorIdDisciplina.text
  ));
  

  List<Disciplina> disc = await bd.pegarDisciplina();

  tabelaDisciplina = [];
  for (Disciplina p in disc) {
    tabelaDisciplina.add(
      FlatButton(
        child: Text(d.nome + ' - ' + d.id),
        onPressed: (){
          bd.deletarDisciplina(d.id);
        },
      )
    );
  } 
}

void _onPressedBotaoCriarAluno() {
  alunos.add(new Aluno(
    editorNomeAluno.text,
    editorMatriculaAluno.text,
  ));

  for (Aluno a in alunos) {
    tabelaAlunos.add(Text(a.nome + ' - ' + a.matricula));
  }
}

void _onPressedBotaoCriarCurso() async{
  Curso c = new Curso(    
    editorNomeCurso.text,
    editorIdCurso.text
  );

  bd.salvarCurso(c);

  cursos.add(new Curso(
    editorNomeCurso.text,
    editorIdCurso.text
  ));

  List<Curso> ccursos = await bd.pegarCursos();

  tabelaCursos = [];
  for (Curso c in ccursos) {
    tabelaCursos.add(
      FlatButton(
        child: Text(c.nome + ' - ' + c.id),
        onPressed: (){
          bd.deletarCurso(c.id);
        },
      )
    );
  } 
}






TextEditingController editorNomeAluno = new TextEditingController();
TextEditingController editorMatriculaAluno = new TextEditingController();

TextEditingController editorNomeProfessor = new TextEditingController();
TextEditingController editorMatriculaProfessor = new TextEditingController();

TextEditingController editorNomeCurso = new TextEditingController();
TextEditingController editorIdCurso = new TextEditingController();

TextEditingController editorNomeDisciplina = new TextEditingController();
TextEditingController editorIdDisciplina = new TextEditingController();


List<Aluno> alunos = new List<Aluno>();
List<Widget> tabelaAlunos = new List<Widget>();

List<Professor> professores = new List<Professor>();
List<Widget> tabelaProfessor = new List<Widget>();

List<Curso> cursos = new List<Curso>();
List<Widget> tabelaCursos = new List<Widget>();

List<Disciplina> disciplinas = new List<Disciplina>();
List<Widget> tabelaDisciplina = new List<Widget>();

class _MyHomePageState extends State<MyHomePage> {







  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child:
                    Text("Criação")
                ),

                Tab(
                  child:
                    Text("Alunos")
                ),
                
                Tab(
                  child:
                    Text("Professores")
                ),

                Tab(
                  child:
                    Text("Curso")
                ),

                Tab(
                  child:
                    Text("Disciplina")
                ),
              ],     
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: <Widget>[
                  // --> Criar Aluno <--
                  FlatButton(
                    child: Text('Criar Aluno'),
                    onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => TelaCriarAluno()));
                    },
                  ),
                  
                  // --> Criar Professor <--
                  FlatButton(
                    child: Text('Criar Professor'),
                    onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => TelaCriarProfessor()));
                    },
                  ),

                  // --> Criar Curso <--
                  FlatButton(
                    child: Text('Criar Curso'),
                    onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => TelaCriarCurso()));
                    },
                  ),

                  FlatButton(
                    child: Text('Criar Disciplina'),
                    onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => TelaCriarDiciplina()));
                    },
                  ),
                ]
              ),

              ListView(
                padding: EdgeInsets.all(16.0),
                children: tabelaAlunos,
              ),

              ListView(
                padding: EdgeInsets.all(16.0),
                children: tabelaProfessor,
              ),

              ListView(
                padding: EdgeInsets.all(16.0),
                children: tabelaAlunos,
              ),

              ListView(
                padding: EdgeInsets.all(16.0),
                children: tabelaDisciplina,
              ),

            ],
          ),
        )
      )
    );
  }
}