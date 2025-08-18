# Bot-Saves-Princess
Repository for SESAC/Harry Fox Agency developer code challenge, written by candidate Chris Hewitt. 

## Iteration 1: 'Bot Saves Princess 1' 

My intention with this take-home assignment is to demonstrate how I leverage the strengths of the Ruby language as well as OOP fundamentals, as well as add error handling, documentation, and safe/readable methods that I would expect to see in a production Ruby codebase. There are more comments than I would generally write in production, but since you are evaluating my coding ability in a professional enviornment I wanted to be as clear as possible in my thought process. 

A full breakdown of each class's function and responsibility is below. 

## Position  
The Position class models a coordinate on a 2D grid with a row and column. It is used to represent the locations of characters: the Bot and the Princess. The method, #same_position?, compares two Position objects to check if they represent the same location. This is where I started, and knew that it would contain the crux method of completing the game: #same_position?
is true, the bot and the princess are on the same square. Position has a clear, single responsibility: represent a grid position and provide comparison logic.

## Grid 
The Grid class models an n x n square game board and provides utility methods for validating it's shape, locating key positions (like the center or corners), and finding specific characters (e.g., the bot 'm' or the princess 'p'). Gridfocuses only on managing and validating the structure and data of the grid—no gameplay logic is included. I also included custom 
errors - 'GridError' - for easier debugging. If this were in production, I find this pattern makes it easier to sort through logs rather than a sea of StandardError. 

## Bot 
The Bot class is our relentless, fearless automaton with one goal in mind: navigating our 2D grid towards the princess. 
It holds a Position object representing the bot's current location and provides the logic to move toward the position of the princess in a logical manner. 
The method step_toward(target) evaluates whether the bot needs to move vertically or horizontally to get closer to the target. Movement always happens one step at a time, and @position is updated accordingly. 


#step_toward(target) evaluates whether the bot needs to move vertically or horizontally to get closer to the target.
 Movement always happens one step at a time, and @position is updated accordingly.

def step_toward(target)
  if position.row > target.row
    @position = Position.new(position.row - 1, position.column)
    'UP'
  elsif position.row < target.row
    @position = Position.new(position.row + 1, position.column)
    'DOWN'
  elsif position.column > target.column
    @position = Position.new(position.row, position.column - 1)
    'LEFT'
  elsif position.column < target.column
    @position = Position.new(position.row, position.column + 1)
    'RIGHT'
  end
end

This prioritizes vertical movement - rows - over horizontal movement - columns. 
Each elsif block modifies @position to a new Position instance and returns the corresponding direction as a string. The bot steps through the grid one move at a time.

The #path_to(target) method repeatedly calls step_toward until the bot's @position matches the target:

def path_to(target)
  moves = []
  moves << step_toward(target) until position.same_position?(target)
  moves
end

Remember same_position?, the crux method I mentioned earlier in the Position class? 
We see it in action here. The method accumulates the string return values from step_toward into an array (moves) that ultimately forms the entire path from start to goal.
Once we get a true same_position?, we've made it and can deliver our collection of tracked moves. 

## GridBuilder 

The GridBuilder class is a factory-style utility responsible for constructing a valid Grid instance used in the game. It does not contain any game logic or grid manipulation logic beyond the initial setup. Its only role is to create a playable grid with the parameters defined in the challenge: A specified size n, the bot placed at the center, the princess placed in one of the four corners. 

## GameFormatter 
The GameFormatter class is a stateless utility class designed to centralize all input/output responsibilities. I built this beacuse classes in Ruby are free, and I am weary of long methods containing output strings/gets.chomp/etc 
that dominated my game files in my Turing days. 

## GamePlay 
Here's where everything comes together. GamePlay is responsible for orchestrating everything set up by the previously described classes. It drives the game loop and state transitions, coordinates user input and output, delegates tasks to their specific helper classes, and 
abstracts away logic to focus on it's main goal: making the game go. 

## Runner 

A very tiny Ruby script serves as the entry point for running evverything on the command line. It ensures that the game only runs when the file is executed directly, and sets up everything by initializing GamePlay and calling #play.

## Testing 
The spec directory includes a thorough test suite covering both unit and integration behavior using RSpec. 
The tests are designed to validate core functionality of all classes in isolation as well as end-to-end orchestration (GamePlay) through controlled simulation of game scenarios - by using controlled doubles and mocks, the tests avoid reliance on real user interaction, random grid generation/princess placement, or real-time delay methods that make the game more 'realistic'(e.g., sleep). You will notice that there isn't a complete 'rundown' of the gameplay showing all the results of gets/STDOUT. I chose to tightly couple each test file to it's related class. I can see how this might be a somewhat controversial, but by isolating everything in great detail we can avoid giant, slow and hard to understand RSpec tests that fail steagely and are difficult to maintain and refactor. 

I also included the gem SimpleCov to ensure complete coverage. 

## Gems/Tools/Resources 
ruby '2.7.2' - I'm a little out of date here, but with the time crunch of a take home I decided not to mess with my Ruby version and related config. 

gem 'rake' - Added rake and a rake file to save myself from typing 'bundle exec.' 

gem 'rspec' - The test suite. 

gem 'rubocop' - Enforcing formatting, industry standard. 

gem 'simplecov' - Ensure complete test coverage. 

I used my experience in production Ruby enviornments, but went back to some documentation to remember specific practices and make sure I was adhering to Ruby best practices. 
https://refactoring.guru/design-patterns/factory-method/ruby/example 
https://developer.onepagecrm.com/blog/design-patterns-in-ruby-builder-and-factory-patterns/

I also used ChatGPT-40 to help refactor and check for edge cases, as well as using it to 'rubber duck' my design decisions. I am well aware of the limitations, hallucinations and security risks of using LLMS as more than just a rubber duck, but I do find it very useful in specific cases. It's another tool that - 'super google' - that has turned me on to a lot of Ruby concepts and helps check my work.


