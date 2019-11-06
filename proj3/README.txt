How to execute the tests:

-Open a terminal under the build/ directory
-Run the commands:
rm CMakeCache.txt && cmake ..
make
./random-sol < ../inputs/INPUTFILE
./cpu-locsea < ../inputs/INPUTFILE
INPUTFILE = in100, in200, in300, in400, in500