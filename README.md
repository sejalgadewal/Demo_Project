**Project Title** :- " E-learning platform "

**Technologies used** :-
Programming Languages: Ruby ( version - 3.0.0 )
Framework: Ruby on Rails
Frontend: HTML, CSS, Js
Backend: ruby on rails ( version - 7.0.6 )
Database: SQLite3 ( version - 1.4 )

**Description** :-
This is a E-learning platform for learning purpose.
Where a user wlll have 2 roles ( "Instructor", "Student" ).

- If a user is Instructor. 

1) They can sign up to this platform as a role.

2) Instructor can edit his/her profile.

3) Instructor can add course and see all courses.

4) Instructor can attach pdf in course.

5) Instructor can add lectures for particular course and upload video for many lectures for a course.

6) Instructor can update, delete their course and see enrolled student for a particular course.

7) Instructor can create one quiz for a particular lecture

8) Instructor can chat with students



- If User is a Student.

1) Student can sign up to the site

2) After login student can see all courses of each instructor.

3) Student can enroll in the courses .

4) After enroll, can see all lectures and documents of course.

5) Student can attempt quiz one time for each lectures .

6) Student can chat with instructor.

**Gem Used**

1) Letter Opener,letter_opener_web - to see all the mails.
2) Devise - to handel authentication.
3) wil_paginate - to divide the content in multiple pages.
4) redis - for chat functionality.
5) byebug - to resolve bugs.
6) cancancan - for authorization.
7) activestorage - for uploading videos.
8) gravatar_image_tag - for random image upload.
9) simple_form - for creating form.
10) rubocop-rails - for ruby code style checker.
11) rspec-rails - for testing
12) factory_bot_rails - for providing rails integration for factory_bot. 
13) shoulda-matchers -  for functionality of testing
    

**- Before running project do this necessary commands.**

1) bundle install - to install all the gems.

2) rails db:migrate  - to make the schema.

3) rails db:seed to create admin user and testing data.

