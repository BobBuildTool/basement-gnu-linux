# Basement GNU/Linux Layer

This layer builds upon the [Basement
layer](https://github.com/BobBuildTool/basement) and provides recipes to build
GNU/Linux systems from it. It is intended to be used by other projects.

# How to build

Actually there isn't much to build directly in this repository. Head over
to one of the examples to see how this repository is used:

 * [Embedded systems](https://github.com/BobBuildTool/bob-example-embedded)
 * [Linux containers](https://github.com/BobBuildTool/bob-example-containers)

# How to use

First you need to add the `basement` and `basement-gnu-linux` layers to your
project. To do so add a `layers` entry to `config.yaml`:

    bobMinimumVersion: "0.25"
    layers:
        - name: basement-gnu-linux
          scm: git
          url: https://github.com/BobBuildTool/basement-gnu-linux.git
          commit: <git commit id> # optional but highly recommended
        - name: basement
          scm: git
          url: https://github.com/BobBuildTool/basement.git
          commit: <git commit id> # optional but highly recommended

and then fetch the layers:

    $ bob layers update

To use the standard facilities of the basement project you need to inherit the
`basement::rootrecipe` class in your root recipe:

    inherit: [ "basement::rootrecipe" ]

This will make your recipe a root recipe and already setup the sandbox with a
proper host toolchain. A number of [pre defined tools and
toolchains](https://github.com/BobBuildTool/basement#provided-tools-and-toolchains)
are available from the basement project.
