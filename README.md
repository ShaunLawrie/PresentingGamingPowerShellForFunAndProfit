# CodeCampTalk2024

## Prep

- ✅ Google-ThatShit
- ✅ Neovim is available
- ✅ ZoomIt is installed
- Terminal font size default is set
- Sound is working
- Scoring is running
- Open simple browser
- Open readme

## Content

- **Who am I**  
  I'm Shaun, I work at PartsTrader.
  What's PartsTrader? Cars go vroom, have a little smash and then the repair shops use our platform to procure parts. The GMV of our NZ and US markets is around $2B last I checked, so a lot of parts.
  I'm Platform Engineering lead and cover things like application stability and software delivery with my team.

- **Intro to terminals**  
  Hi and welcome to my talk on CodeCamp 2024. Today we are going to talk about shell scripting and terminals. Who here loves using the terminal?  
  Hopefully we can change that a little. I've talked a few times on how terminals can be quite intimidating and I'm going to try teach a bit of terminal tech in a slightly more fun way. So today we're going to be trying to write a game in the terminal using powershell.

  - **Demo of ANSI escape codes**  
    We're going to start by digging a little bit into what the terminal is and how we can drive it. We need to get familiar with escape codes and how we can use them to control the terminal output.  
    *Show `0-escape-codes.ps1`*
  
  - **What's the game?**  
    We're going to write a simple snake game in the terminal. In preparing this my partner pointed out I'm older than I feel and some people might not be aware of the game. So here's a quick demo of what it looked like when I was playing on my Nokia at high school.  
    *Show `complete/Snake.ps1`*

- **Intro to powershell**
  - **Intro to the ps1 script**  
    I've done this already a couple of times without explaining it. What I've been running here in the terminal have been PowerShell scripts, which are suffixed with `.ps1`, but what do they look like?
  - Intro to the simple data types...
- Game time
  - Now we know the basics of the script. How do we represent a game in a terminal?
    - Board
    - Basic food and snake
  - Modules
    - How to write modular shell scripts
    - Move out of main script
    - Test collisions
  - Movement
    - Set a direction
    - Stretchy snake
  - Inputs
    - Ways to collect input in powershell
  - Food
    - Detect food collision
    - Rework moving snake
  - Gameover
    - How to interact with the interwebs
    - http://localhost:5187/scores
