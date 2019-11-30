# How to run tests:

Under the build directory, run the commands:

```cmake .. && make```

Now that all the executables are ready, you can execute them by running:

```mpiexec --oversubscribe -n 5 ./EXECUTABLE < INPUT```

EXECUTABLES:

- ex_enum
- loc_sea

INPUTS:
- ../inputs/in10
- ../inputs/in11

- ...

