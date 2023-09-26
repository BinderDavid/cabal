.. highlight:: console

Introduction and Overview
=========================

Welcome to the documentation of the cabal system for writing, using
and distributing packages for Haskell.
The packaging ecosystem of Haskell might look confusing,
since it consists of many interacting parts such as the package format, build tools,
package repositories, documentation generators, compilers and many more.
This section gives a high-level overview of what role cabal is playing in all this.

If you prefer to get started directly, consider jumping to the getting started with Haskell and Cabal section.

Writing plain Haskell without packages
--------------------------------------

When you start writing Haskell you probably use the interactive REPL ghci, an online playground
or you work with single-file Haskell projects that you compile using the GHC compiler.
At this point you don't have to concern yourself with the packaging ecosystem yet, since you
are mostly interacting directly with the Haskell compiler GHC.
Here is how GHC compares to other compilers for other languages:

.. list-table:: Compilers for various programming languages
    :widths: 50 50
    :header-rows: 1

    * - Programming Language
      - Compiler
    * - Haskell
      - GHC, GHCJS
    * - Rust
      - rustc
    * - C, C++
      - gcc, clang
    * - Scala
      - scalac

But once you are familiar with the basic syntax of Haskell programs, you probably want
to write a more exciting program. In that case you have to depend on libraries that
other people have written before you.
These libraries are distributed as cabal packages, which are not part of the
official Haskell language specification.
Rather they are a feature provided by the combination of Cabal and GHC.

Cabal Packages: A source based distribution model
-------------------------------------------------

Packaging systems deal with packages and with Cabal we call them *Cabal
packages*. The Cabal package is the unit of distribution. Every Cabal
package has a name and a version number which are used to identify the
package, e.g. ``filepath-1.0``.

Cabal packages can depend on other Cabal packages. There are tools to
enable automated package management. This means it is possible for
developers and users to install a package plus all of the other Cabal
packages that it depends on. It also means that it is practical to make
very modular systems using lots of packages that reuse code written by
many developers.

Cabal packages are source based and are typically (but not necessarily)
portable to many platforms and Haskell implementations. The Cabal
package format is designed to make it possible to translate into other
formats, including binary packages for various systems.

When distributed, Cabal packages use the standard compressed tarball
format, with the file extension ``.tar.gz``, e.g.
``filepath-1.0.tar.gz``.

Package descriptions: The cabal file
------------------------------------

If you inspect the source code repository of any Haskell project, you are almost guaranteed to find
a file which ends in .cabal.
Haskell programmers usually call it the "cabal file", but officially it is called the package description.
Here is an example of how these package descriptions look like:

::

    cabal-version:  3.0
    name:           HUnit
    version:        1.1.1
    synopsis:       A unit testing framework for Haskell
    homepage:       http://hunit.sourceforge.net/
    category:       Testing
    author:         Dean Herington
    license:        BSD-3-Clause
    license-file:   LICENSE

    library
      build-depends:      base >= 2 && < 4
      exposed-modules:    Test.HUnit.Base, Test.HUnit.Lang,
                          Test.HUnit.Terminal, Test.HUnit.Text, Test.HUnit
      default-extensions: CPP
      default-language:   Haskell2010

Package descriptions contain general metadata such as the name of the author of the package, the license under
which it is published, its version and the link to a website where you usually find an issue tracker.
This is an example of a package which provides a library, so there is a library section which specifies a list
of other packages the library depends on (in the build-depends field), and a list of modules this library provides
to users of the library (in the exposed-modules field).
Other packages may also contain information about testsuites and executables it provides.
Here are some similar package description formats for other programming languages:

.. list-table:: Package description formats for other programming languages
    :widths: 50 50
    :header-rows: 1

    * - Programming Language
      - Package Description Format
    * - Haskell
      - example.cabal
    * - Rust
      - cargo.toml
    * - Javascript
      - package.yaml
    * - Ruby
      - .gemspec

.. TIP::

  The cabal file format is described in the section on :doc:`package descriptions <cabal-package>`.


Cabal-install: The CLI tool
---------------------------

There are several build tools which can use the information contained in cabal files.
One of the most important ones is invoked with "cabal", and 
If we want talk explicitly about the command line application and not the package format, we use the word "cabal-install".
Here are some of the other

.. list-table:: Tools similar to cabal-install for other programming languages
    :widths: 50 50
    :header-rows: 1

    * - Programming Language
      - Build Tool
    * - Haskell
      - cabal-install
    * - Haskell
      - stack
    * - Rust
      - cargo

As you can see, we have listed another Haskell tool in this list: stack.
Users of `stack` also use the package description format described above, but they use another way to find compatible sets of cabal packages.
Some programmers also use a general purpose build system such as nix or bazel instead of the Haskell specific cabal-install.

.. TIP::

  The various subcommands that cabal-install provides are documented in the section on :doc:`cabal commands <cabal-commands>`.

Hackage: The package repository
-------------------------------------

Once you have developed a cabal package and consider it polished, you probably want to share it with other users.
This is where the package repository Hackage_ comes into play.
Hackage is an online repository where thousands of open source libraries and executables are available for you to use in your own projects.
Here are some package repositories that you might know from other programming languages:

.. list-table:: Package repositories for various programming languages
    :widths: 50 50
    :header-rows: 1
    
    * - Programming Language
      - Package Repository
    * - Haskell
      - Hackage_
    * - Rust
      - `crates.io <https://crates.io/>`_
    * - Ruby
      - `rubygems <https://rubygems.org/>`_
    * - Perl
      - `CPAN <https://www.cpan.org/>`_
    * - Javascript
      - `npm <https://www.npmjs.com/>`_

Most open source developers use the official Hackage_ instance, but it is also possible to host
a Hackage instance yourself.
You can also depend directly on packages which are available in a source code repository, but not
hosted on a package repository.
This is useful in cases where you want to depend on a library that is still experimental and hasn't been published yet.

Contributing to Cabal
---------------------

If you found a bug in cabal, have a feature request or want to contribute yourself to the development of cabal, then you
should start in the official github repository.


.. include:: references.inc
