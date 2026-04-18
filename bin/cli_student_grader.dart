import 'dart:io';
void main () {
    const appTitle = "Student Grader v1.0";
    final subjects = {"Math","English","Science","ICT"};
     var students = <Map<String, dynamic>> [
        {
            "name":     "Fatima",
            "scores":   [85, 92, 78],        // List<int> — one per subject
            "subjects": {"Math", "English", "Science"},  // Set<String>
            "bonus":    null,              // int? — optional bonus points
            "comment":  null   
        }
        
    ];
    int choices ;
    do{
        print ('''
        ===== $appTitle =====

                1. Add Student
                2. Record Score
                3. Add Bonus Points
                4. Add Comment
                5. View All Students
                6. View Report Card
                7. Class Summary
                8. Exit

            ''');
        print("Choose an option: ");

        choices = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        
        
        switch(choices)
        {
            case 1:
                String? name;

                while (name == null || name.trim().isEmpty) {
                  print("Enter student name:");
                  name = stdin.readLineSync();

                  if (name == null || name.trim().isEmpty) {
                    print("Name cannot be empty!");
                  }
                }

                var student = {
                  "name": name,
                  "scores": [],
                  "subjects": {...subjects},
                  "bonus": null,
                  "comment": null
                };

                students.add(student);
                print("Student '$name' added successfully!");

                break;
            case 2:
                if (students.isEmpty) {
                  print("No students available!");
                  break;
                }

                for (int i = 0; i < students.length; i++) {
                  print("${i + 1}. ${students[i]["name"]}");
                }

                print("Select student number:");
                int index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

                if (index < 1 || index > students.length) {
                  print("Invalid selection!");
                  break;
                }

                var student = students[index - 1];

                int score = -1;

                while (score < 0 || score > 100) {
                  print("Enter score (0–100):");
                  score = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

                  if (score < 0 || score > 100) {
                    print("Invalid score! Must be between 0 and 100.");
                  }
                }

                student["scores"].add(score);
                print("Score added successfully!");
                break;
            case 3:
                print("Add Bonus Points");
                break;
            case 4:
                print("Add Comment");
                break;
            case 5:
                print("View All Students");
                break;
            case 6:
                print("View Report Card");
                break;
            case 7:
                print("Class Summary");
                break;
            case 8:
                print("Exit");
                break;
            default:
            print("Invalid choice");
        }
    }while(choices != 8);



}