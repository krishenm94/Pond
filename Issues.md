# Issues

1. Use a genome factory and gene factory paradigm to control Organism attributes (closed)

2. Javafy files: 
    a. Remove Painter as a global variable 
        . HIDDEN DEPENDENCY!!!
        . Will be required once the code base grows large enough
    b. Make top level classes static
    c. Organise files into folders

3. Store a list of Overlaps in Organism
    a. may not be required because handling collisions of two bodies at a time seems enough

4. Implement shape accurate overlap detection (closed)
    a. Currently all overlap detection is based on a bounding rect
    b. Reference: http://jeffreythompson.org/collision-detection/circle-rect.php
    c. Move out of overlap along vector between center of mass of both bodies

5. Mutation: Blocked by 1

6. Sexual reproduction: Blocked by 1

7. Movement modes for each species: Blocked by 1 (closed)

8. Speciation: Blocked by 5

9. Write a macro to get current function signature for better logging

10. Control initial population distribution

11. Prefix all member variables with `m_` and remove local variables prefixed with `_`


12. Add photosynthesis mechanism (closed)

13. Block all commits to `release_*` branches

Example code:
```
# START: Block pushing to release branches 
if [[ $refname == "refs/heads/release_v1" ]]
then
    echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    echo "You cannot push to branch: release_v1! It's locked"
    echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    exit 1
fi
exit 0
# END : Block pushing to release branches
```
14. Should collision in a motor only change its own states?