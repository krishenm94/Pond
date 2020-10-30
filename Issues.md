# Issues

1. Use a GenomeFactory and GeneFactory paradigm to control Organism attributes

2. Javafy files: 
    a. Remove Painter as a global variable 
        . HIDDEN DEPENDENCY!!!
        . Will be required once the code base grow large enough
    b. Make top level classes static
    c. Organise files into folders

3. Store a list of Overlaps in Organism
    a. may not be required because handling collisions of two bodies at a time seems enough

4. Implement shape accurate collision detection
    a. Currently all overlap detection is based on a bounding rect
    b. Reference: http://jeffreythompson.org/collision-detection/circle-rect.php

5. Mutation: Blocked by 1

6. Sexual reproduction: Blocked by 1

7. Movement modes for each species: Blocked by 1

8. Speciation: Blocked by 5

