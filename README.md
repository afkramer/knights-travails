# knights-travails
My solution to the Knight's Travails project from The Odin Project

## Task
From the project specs: "Your task is to build a function knight_moves that shows the simplest possible way to get from one square to another by outputting all squares the knight will stop on along the way."

To make it possible to try out different coordinates I also wrote a short command line script that will allow the user to keep entering coordinates as long as they wish. This was just a quick bare-bones execution with no data validation or anything, so don't be surprised when the program crashes if you enter something like "a, cheeseburger".

## What I learned
This was the toughest project so far! It took me a while to figure out how to set up the data structures necessary to make it work. Then when I thought that was the difficult part it was time to implement a search function to find the shortest path. Thankfully, someone from the TOP community nudged me to sit with a pen and paper for a while to really think about which paths even make sense to travel. This is how I came up with all the rules in the Knight class that determine which paths should be further travelled and which ones should be left alone.

## What could be improved
Although I was able to make the depth-first search work by creating a lot of checks to determine if the space should be traversed, I think that these checks might make it difficult for others to understand what's going on. On the other hand, I'm fairly sure with all the possible branches that a knight could travel, it's important for performance reasons to whittle down the paths to check and not just follow any path at all.

Additionally, I could have tried to make the breadth-first search work, but the logic of it just didn't click for me. Maybe I'll have a shower moment someday in the future where it suddenly makes sense... Otherwise I think I'll leave it as is ;)

## To try it out
You can follow the link to this replit to try it out: https://replit.com/@afkramer/Knights-Travails?v=1

As mentioned above, there is no data validation so please remember to enter coordinates like so "0,7" or "0, 7". The coordinates go from 0-7.