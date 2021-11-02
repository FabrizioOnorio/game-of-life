<h1>Game of life:</h1>

This is a Rails web app based on Conway's Game of Life

<h2>How it works:</h2>

You can check out the app on https://game-of-life-fab.herokuapp.com/


<h2>Rules of the game:</h2>

Given a input generation (a .txt file) the app calculates the next generation. The world consists of a two dimensional matrix of cells, where each cell is either dead or alive.

The Matrix is finite and no life can exist off the edges.

Given a cell we define its eight neighbours as the cells that are horizontally, vertically, or diagonally adjacent.

When calculating the next generation the game follows these rules:

Any live cell with fewer than two live neighbours dies.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies.
Any dead cell with exactly three live neighbours becomes a live cell.


Have fun! 😊
