### Traveling Salesman Implementation in Ruby

## Description

Implementation of the Traveling Salesmen Problem in ruby.

# File Input

Locations are passed to the program by file. The format of the file should be
as follows:

```
0 x y
1 x y
3 x y
...
n-1 x y
n x y
```

# Heuristics Used

Allows the use of two heuristics for optimizing Tours: 
1) Genetic Algorithm
2) Two-Opt

The Genetic Algorithm will *evolve* a population of the specified number of
generations. This is done by a process called crossover, as well as, random
mutation in a Tour. Crossover takes two of the fittest Tours of a sample of the 
population and crosses them to create an offspring. Mutation will randomly swap
locations in a tour at a specified rate (default 1.5%)

I wrote the genetic algorithm because I thought it would be fun, but it is not
very deterministic. I also implemented a Two-Opt approach. Two-Opt seeks to
untangle places where the tour crosses over itself, as in the following image:

[2-opt-wiki]: https://en.wikipedia.org/wiki/2-opt#/media/File:2-opt_wiki.svg  "2-Opt image from wikipedia"

The algorithm works by finding the two indices (i, j) where a crossover exits and:
1) Copying the indices from 0 to i - 1 forwards into another Tour
2) Copying the indices from i to j in reverse into the new Tour
3) Copying the indices from j+1 to the end forwards into the new Tour

Imagine you are taking a loop of string that has been twisted and twisting it
back. 

Two-Opt Search is basically a trial and error approach where you test every
combination of i and j and keep the resultant Tour if it is better than the
previous.

# Seed Algorithms

Two seed algorithms have been included for testing the capabilities of the two
algorithms. 
1) Nearest Neighbor
2) Random Tour

The Nearest Neighbor starts at a random point and builds a path by finding its
nearest neighbor. It repeats this process from each subsequent nearest neighbor
until the Tour is complete

The Random Tour algorithm just creats a random ordering of locations.

## Usage

``` bash
Usage: ruby tsp_main.rb [options]

Mandatory options:
    -f, --infile=FILE                Specify the Input File
    -p, --population-size=SIZE       Set the population size
    -g, --generations=NUMBER         Set the number of generations

Special Options:
        --algo=[TYPE]                Select algorithm type (genetic (default), two_opt)
        --seed-algo=[TYPE]           Select seed algorithm type (nearest_neighbor (default), random_tour)
    -c, --crossover=SIZE             Set the size of crossover sample
population (default: 20)
    -r, --mutation-rate=FLOAT        Set the mutation rate ( range: 0.0-0.25,
default: 0.015)

Informational options:
    -h, --help                       Display Help Message
        --version                    Show version
```



