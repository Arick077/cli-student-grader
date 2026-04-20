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
            //Add Student
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
            //Record Score
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
            //Add Bonus Points
                if (students.isEmpty) {
                    print("No students available!");
                    break;
                  }

                  for (int i = 0; i < students.length; i++) {
                    print("${i + 1}. ${students[i]["name"]}");
                  }

                  print("Select student:");
                  int index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

                  if (index < 1 || index > students.length) {
                    print("Invalid!");
                    break;
                  }

                  var student = students[index - 1];

                  int bonus = -1;
                  while (bonus < 1 || bonus > 10) {
                    print("Enter bonus (1–10):");
                    bonus = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
                  }

                  if (student["bonus"] == null) {
                    student["bonus"] ??= bonus;
                    print("Bonus added!");
                  } else {
                    print("Bonus already exists!");
                  }

                break;
            case 4:
            //Add Comment
                if (students.isEmpty) {
                  print("No students available!");
                  break;
                }

                for (int i = 0; i < students.length; i++) {
                  print("${i + 1}. ${students[i]["name"]}");
                }

                print("Select student:");
                int index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

                if (index < 1 || index > students.length) {
                  print("Invalid!");
                  break;
                }

                var student = students[index - 1];

                String? comment;

                while (comment == null || comment.trim().isEmpty) {
                  print("Enter comment:");
                  comment = stdin.readLineSync();

                  if (comment != null) {
                    comment = comment.trim();
                  }

                  if (comment == null || comment.isEmpty) {
                    print("Comment cannot be empty!");
                  }
                }

                student["comment"] = comment;
                print("Comment added successfully!");

                break;
            case 5:
              //View All Students

              if (students.isEmpty) {
                print("No students available!");
                break;
              }

              print("\n=== Student List ===");

              for (var student in students) {
                var tags = [
                  student["name"],
                  "${student["scores"].length} scores",
                  if (student["bonus"] != null) "⭐ Has Bonus",
                ];

                print(tags.join(" | "));
              }
                break;
            case 6:
              //View Report Card
              if (students.isEmpty) {
                print("No students available!");
                break;
              }

              for (int i = 0; i < students.length; i++) {
                print("${i + 1}. ${students[i]["name"]}");
              }

              print("Select student:");
              int index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

              if (index < 1 || index > students.length) {
                print("Invalid!");
                break;
              }

              var student = students[index - 1];
             List<int> scores = List<int>.from(student["scores"]);

              if (scores.isEmpty) {
                print("No scores available for this student!");
                break;
              }

             
              int sum = 0;
              for (int i = 0; i < scores.length; i++) {
                sum += scores[i];
              }

              double rawAvg = sum / scores.length;

              
              double finalAvg = rawAvg + (student["bonus"] ?? 0);

              
              if (finalAvg > 100) finalAvg = 100;

              
              String grade;
              if (finalAvg >= 90) {
                grade = "A";
              } else if (finalAvg >= 80) {
                grade = "B";
              } else if (finalAvg >= 70) {
                grade = "C";
              } else if (finalAvg >= 60) {
                grade = "D";
              } else {
                grade = "F";
              }

              
              String commentDisplay =
                  student["comment"]?.toUpperCase() ?? "No comment provided";

              
              String feedback = switch (grade) {
                "A" => "Outstanding performance!",
                "B" => "Good work, keep it up!",
                "C" => "Satisfactory. Room to improve.",
                "D" => "Needs improvement.",
                "F" => "Failing. Please seek help.",
                _ => "Unknown grade."
              };

              // 🧾 Report Card UI
              print('''
            ╔══════════════════════════════════════════╗
            ║       REPORT CARD                        ║
            ╠══════════════════════════════════════════║
            ║  Name:    ${student["name"]}             ║
            ║  Scores:  ${student["scores"]}           ║
            ║  Bonus:   ${student["bonus"] != null ? "+${student["bonus"]}" : "No bonus"}      ║
            ║  Average: ${finalAvg.toStringAsFixed(1)} ║
            ║  Grade:   $grade                         ║
            ║  Comment: $commentDisplay                ║
            ╚══════════════════════════════════════════╝
            Feedback: $feedback
            ''');
                break;
            case 7:
              //Class Summary
              
                if (students.isEmpty) {
                  print("No students available!");
                  break;
                }

                int totalStudents = students.length;

                double totalAvg = 0;
                double highest = 0;
                double lowest = double.infinity;

                int countedStudents = 0;
                int passCount = 0;

                Set<String> uniqueGrades = {};

                for (var s in students) {
                  List<int> scores = List<int>.from(s["scores"]);

                  if (scores.isEmpty) continue;

                  int sum = 0;
                  for (int i = 0; i < scores.length; i++) {
                    sum += scores[i];
                  }

                  double avg = sum / scores.length;

                  avg += (s["bonus"] ?? 0);

                  if (avg > 100) avg = 100;

                  countedStudents++;
                  totalAvg += avg;

                  if (avg > highest) highest = avg;
                  if (avg < lowest) lowest = avg;

                  String grade;
                  if (avg >= 90) {
                    grade = "A";
                  } else if (avg >= 80) {
                    grade = "B";
                  } else if (avg >= 70) {
                    grade = "C";
                  } else if (avg >= 60) {
                    grade = "D";
                  } else {
                    grade = "F";
                  }

                  if (scores.isNotEmpty && avg >= 60) {
                    passCount++;
                  }

                  uniqueGrades.add(grade);
                }

                double classAvg =
                    countedStudents > 0 ? totalAvg / countedStudents : 0;

                var summaryLines = [
                  for (var s in students)
                    "${s["name"]}: ${s["scores"].length} scores"
                ];

                print('''
              ===== CLASS SUMMARY =====
              Total Students: $totalStudents
              Students With Scores: $countedStudents
              Class Average: ${classAvg.toStringAsFixed(1)}
              Highest Average: ${countedStudents > 0 ? highest.toStringAsFixed(1) : "N/A"}
              Lowest Average: ${countedStudents > 0 ? lowest.toStringAsFixed(1) : "N/A"}
              Passing Students: $passCount

              Unique Grades: $uniqueGrades

              --- Student Overview ---
              ${summaryLines.join("\n")}
              ========================
              ''');
                break;
            case 8:
                print("Exit");
                break;
            default:
            print("Invalid choice");
        }
    }while(choices != 8);



}