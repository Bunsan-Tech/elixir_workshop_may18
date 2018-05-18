## Problem 1 - Tic-Tac-Toe GenSever

Based on the previous homework, implement Tic-Tac-Toe with a GenServer,
such that a single server handles a single game.

## Problem 2 - Game Server

Based on Problem 1, create an application and the corresponding supervision tree,
such that you can create new games, and each game is handled by a new process.
The game processes must be supervised, every game should have an unique ID, which
must be provided from the start, and if the server crashes, the replacement should
be addressed by the same ID. 