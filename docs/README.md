## Assignment 3 - Terminal App - SUPERNOTES

## Link to Repository


# Software Development Plan

- My application, SuperNotes, is a terminal application designed to do three things: take notes, read those note, and delete those notes if necessary. SuperNote takes input from a user in the form of a note title and note content, then opens a text file and saves the user's input (the note heading and content) to the text file along with the date which the note was created. The user can also use SuperNotes to look through a list of their created notes, or search for them by name, and either edit the note or delete the note. Basically, SuperNote is super basic. But it works, and it's super. 
- It will solve all the client's note taking needs; even though there are hundreds of other note-taking apps on the market, you can rest assured that none of them take a note as SUPERbly as SuperNote!
- The target audience is anyone who wants to jump in on the fast-paced and always-expanding world of note-taking. From office workers to soccer-mums, if you need to take a note, we got the app for you!
- I could explain how to use it here, under the Requirement 5 heading as asked, but I feel like that's a bit silly as Requirement 10 asks for the same thing, and I don't want to repeat myself. I got things to do. 

# FEATURES OF SUPERNOTES

## Feature 1 - TTY PROMPT arrow key Menus

Using the ruby gem tty-prompt, Supernote will have a simply UI, utilizing the gem's code in order to add an options menu as a front-page, where the user will be able to choose to read notes, create a new note, delete a note, append an existing note, or else exit the program. the code is as follows:
```ruby
choose = %w(𝐑ead 𝐍ew 𝐃𝐞𝐥𝐞𝐭𝐞 𝐀𝐩𝐩𝐞𝐧𝐝 𝐄𝐱𝐢𝐭)
choice = prompt.select("What would you like to do?", choose).to_s
```
followed by a case statement encompassing the control flow of the program and its input and output. 


## Feature 2 - Create New Note

The first and most essential feature of SuperNote is it's ability to create a new note. The program asks for the title and stores it in the variable *filename*. The title can be multiple words and does not need a file extension added as the program does all of this automatically using `filename = gets.chomp.gsub(" ", "_").to_s.downcase + ".txt"`. It alos automatically adds the date of the note's creation to the note using the class/method `Date.today`, then lastly prompts for note content, which can be multilined, as input stored in the variable *content* i.e. `content = gets(\n\n\n).chomp`. A text file is then created in a local directory using the following method/class:
```ruby
def create(filename, content) # Creates a new note, saves the note in .txt format to local directory.
   File.open(filename, "w") do |file|     
   file.write(content)
   end
end
```
**Error-handling:** If the note title is already in use or left blank (which uses an if/else statement and the logical operator `File.exists?(filename) == false && filename != ".txt"`) to search the directory), the app will tell the user that the title is either already in-use or invalid, respectively. This is the first instance of error handling in SuperNotes. 


## Feature 2 - Read Your Notes

The second feature is the ability to list and read your notes. Again, the user chooses the option 'Read' from the menu, which lists all available notes with `puts Dir.glob("*.txt")`. The user can then input the name of the note they wish to read - using the same method stated above - which retrieves the note, along with its title and creation date, and prints it all back to the screen. This is accomplished using the method/class/iterator:
```ruby
def read(filename)   # Reads each line of the .txt file back to the terminal screen.
   File.open(filename).each do |text|
   puts text
   end
end
```
**Error-handling:** When inputting the note title, the program uses an if/else statement to determine if the note title exists (using `if File.exists?(filename) == true` #code to read). If the user input does not match an existing note title, the user will recieve an error message stating that the note does not exist (i.e `else` #error message)


## Feature 3  - Append Your Notes

The third feature was originally supposed to allow the user to fully edit existing notes in-app. But I couldn't figure out how to accomplish this and instead went with the option to simply add to exisiting notes. Supernote allows the user to append notes under the 'Append' option on the main page. Using the same list and input-to-open methods mention previously, the user is given a list of existing notes and can input the title to 'open' its contents, which can then be appened. The program does this using the following code:
```ruby
   if File.exists?(filename) == true
   #I've removed the UI sprinkles for simplicity's sake
   add_text = gets("\n\n\n").to_s
   File.write(filename, add_text, File.size(filename), mode: 'a')
```
 Note that there is note functional way in SuperNotes to edit or change an exisiting text in a note without first deleting the note and then recreating it. 
 **Error-handling:** Same as above.


### Feature 4 - Delete Unwanted Notes

The final feature of SuperNote is the ability to list all existing notes, search by name and delete them from the list. This permanantly deletes the notes (as in, the note is removed from the SuperNotes app *and* its associated text file is deleted from the local directory). Again, the user is given a list of existing notes and is prompted for the title of the note they wish to delete (using the same `filename =` method as outlined previously). If the note exists (using the `File.exists?(filename)` class/method as stated previously), the user is promted one last time using a tty-prompt and another case statement to ask: "Are you sure you want to delete this note?". This is an added safety measure to ensure the user won't accidentally delete the wrong note. When the user chooses "Yes", the note is deleted using the class/method `File.delete(filename)` and the message "Note Deleted" is printed in red text to the screen. Here is the functional code, sans fancy UI stuff:
```ruby
if File.exists?(filename) == true
   choose3 = %w(Yes Cancel)
   choice3 = prompt.select("Are you sure you want to delete this note?", choose3).to_s
   case choice3
      when "Yes"
         File.delete(filename)
         puts pastel.red.bold("\nNote deleted!")
      else "No"
         puts pastel.bright_green.bold("\nCancelled.")
      end
```

# Implementation Plan

As this is a small, one-person terminal app, I designed my implementation plan around a simple to-do list, as follows:
(Note: tasks are marked as done using `X`)

#### Design:
- ASCII art heading for title page (possible name: 'SuperNotes' ?) `X`
- Gem for colourizing terminal text (maybe 'colorize', 'tty-pastel' ?) `X`
- Gem for arrow key navigation/menus (maybe 'tty-prompt' ?) `X`
- font styles for menu text `X`

#### App Functions:
1. **New Note:** *Creates new notes, with a title, from user input*
   -creating a text file and storing the file in a local SuperNote directory `X`
   - adding a 'date created' function to each note `X`
   - enable multiple word note titles (whitespace included) `X`
   - automate adding the .txt file extension `X`
   - enable multi-line notes `X`
2. **Read Note:** *Enable user to read existing notes*
   - list exisiting notes `X`
   - choose note to read from the list by typing note title `X`
   - print note contents to screen `X`
3. **Delete:**  *Deletes existing notes*
   - list exisiting notes `X`
   - choose note to delete from the list by typing note title `X`
   - add safety feature i.e. a second prompt for certainty before note is deleted `X`
4. **Append:** *Append to existing note* 
   - list exisiting notes `X`
   - choose note to append from a list by typing note title `X`
   - print existing note contents to screen, then prompt the user for additional input to add to said note `X`
5. **Exit** *Close the app gracefully*
   - Keep the app running via control flow (loops?) until such time as the user wishes to exit the app manually `X`

#### Error Handling
Ensure the app throws no errors or crashes by using 'if/else' statements and 'case' statements to control if the program can perfom a specific action, else the user receives a custom error message. These scenarios are outline below:

1. **New Note**
- The user cannot create a note without a title, else they recieve a custom error message `X`
- The user cannot create a note with the same title as an existing note - custom error message `X`
- The user can *only* create text (.txt) files within the program - coded to be the only possibility `X`
- The user cannot give the note an invalid title (e.g. a filename which includes whitespace) - coded to be impossible `X` 
2. **Read Note**
- The user cannot read files that don't exactly match the user input when prompted for it - custom error message `X`
- The user cannot read a file that does not exist - custom error message  `X`
- The user cannot read source code or other important files within the program - coded to be impossible`X`
3. **Delete**
- The user cannot delete files that don't exactly match the user input when prompted for it - custom error message  `X`
- The user cannot delete source code or other important files within the program - coded to be impossible`X`
- The user cannot delete files that do not exist  - custom error message `X`
4. **Append**
- The user cannot append to files that don't exactly match the user input when prompted for it  - custom error message `X`
- The user cannot append to source code or other important files within the program - coded to be impossible`X`
- The user cannot append to files that do not exist  - custom error message `X`
- The append function will not overwrite the existing note, only add to it - coded to be impossible `X`
5. **Exit**
- The program will exit gracefully, without error - coded to be the only option `X`
6. **Menu**
- The user cannot select an invalid option from the main menu. There will be *no* invalid options to choose from `X`
- In the extremely unlikely event of user choice not matching the `case` statement that the tty-prompt menu is built upon, the user will recieve a custom error message `X`
