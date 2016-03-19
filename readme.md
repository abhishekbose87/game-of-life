Implement Conway's Game of Life as a command line solution in Ruby.

Contract for your solution

1. It should reads from a file to obtain the seed, the filename should be passed via command
line arguments

    Like -> `~$ ./gameoflife.rb seed.txt`

2. It should run 50 iterations, printing the final iteration to STDOUT.

3. It should implement an infinite grid as per the problem statement. Limited grids will be
rejected.

4. Sample seed and output format can be found below - 1 represents live cell and 0 represents
dead cell

5. More examples can be found on the Wikipedia article linked to above

Tried to implement it without using a single conditional.

Sample Input Format (made available as a file)

```
0 0 0 0
0 1 1 0
0 1 1 0
0 0 0 0
```

Expected Output Format

```
0 0 0 0
0 1 1 0
0 1 1 0
0 0 0 0
```
