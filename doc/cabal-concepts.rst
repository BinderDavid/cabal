.. highlight:: console

Fundamental Packaging Concepts
==============================

The packaging ecosystem of Haskell might look confusing,
since it consists of many interacting parts such as the package format, build tools,
package repositories, documentation generators, compilers and many more.
This section gives a high-level overview of what role cabal is playing in all this.

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

Package concepts
----------------


The point of packages
^^^^^^^^^^^^^^^^^^^^^

Packages come in two main flavours: libraries of reusable code, and
complete programs. Libraries present a code interface, an API, while
programs can be run directly. In the Haskell world, library packages
expose a set of Haskell modules as their public interface. Cabal
packages can contain a library or executables or both.

Some programming languages have packages as a builtin language concept.
For example in Java, a package provides a local namespace for types and
other definitions. In the Haskell world, packages are not a part of the
language itself. Haskell programs consist of a number of modules, and
packages just provide a way to partition the modules into sets of
related functionality. Thus the choice of module names in Haskell is
still important, even when using packages.

Package names and versions
^^^^^^^^^^^^^^^^^^^^^^^^^^

All packages have a name, e.g. "HUnit". Package names are assumed to be
unique. Cabal package names may contain letters, numbers and hyphens,
but not spaces and may also not contain a hyphened section consisting of
only numbers. The namespace for Cabal packages is flat, not
hierarchical.

Packages also have a version, e.g "1.1". This matches the typical way in
which packages are developed. Strictly speaking, each version of a
package is independent, but usually they are very similar. Cabal package
versions follow the conventional numeric style, consisting of a sequence
of digits such as "1.0.1" or "2.0". There are a range of common
conventions for "versioning" packages, that is giving some meaning to
the version number in terms of changes in the package, such as
e.g. `SemVer <http://semver.org>`__; however, for packages intended to be
distributed via Hackage Haskell's `Package Versioning Policy <https://pvp.haskell.org/>`_ applies
(see also the `PVP/SemVer FAQ section <https://pvp.haskell.org/faq/#semver>`__).

The combination of package name and version is called the *package ID*
and is written with a hyphen to separate the name and version, e.g.
"HUnit-1.1".

For Cabal packages, the combination of the package name and version
*uniquely* identifies each package. Or to put it another way: two
packages with the same name and version are considered to *be* the same.

Strictly speaking, the package ID only identifies each Cabal *source*
package; the same Cabal source package can be configured and built in
different ways. There is a separate installed package ID that uniquely
identifies each installed package instance. Most of the time however,
users need not be aware of this detail.

Kinds of package: Cabal vs GHC vs system
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It can be slightly confusing at first because there are various
different notions of package floating around. Fortunately the details
are not very complicated.

Cabal packages
    Cabal packages are really source packages. That is they contain
    Haskell (and sometimes C) source code.

    Cabal packages can be compiled to produce GHC packages. They can
    also be translated into operating system packages.

GHC packages
    This is GHC's view on packages. GHC only cares about library
    packages, not executables. Library packages have to be registered
    with GHC for them to be available in GHCi or to be used when
    compiling other programs or packages.

    The low-level tool ``ghc-pkg`` is used to register GHC packages and
    to get information on what packages are currently registered.

    You never need to make GHC packages manually. When you build and
    install a Cabal package containing a library then it gets registered
    with GHC automatically.

    Haskell implementations other than GHC have essentially the same
    concept of registered packages. For the most part, Cabal hides the
    slight differences.

Operating system packages
    On operating systems like Linux and Mac OS X, the system has a
    specific notion of a package and there are tools for installing and
    managing packages.

    The Cabal package format is designed to allow Cabal packages to be
    translated, mostly-automatically, into operating system packages.
    They are usually translated 1:1, that is a single Cabal package
    becomes a single system package.

    It is also possible to make Windows installers from Cabal packages,
    though this is typically done for a program together with all of its
    library dependencies, rather than packaging each library separately.

Unit of distribution
^^^^^^^^^^^^^^^^^^^^

The Cabal package is the unit of distribution. This means that
each Cabal package can be distributed on its own, in source or binary
form. There may be dependencies between packages, but there is
usually a degree of flexibility in which versions of packages can work
together so distributing them independently makes sense.

It is perhaps easiest to see what being "the unit of distribution"
means by contrast to an alternative approach. Many projects are made up
of several interdependent packages and during development these might
all be kept under one common directory tree and be built and tested
together. When it comes to distribution however, rather than
distributing them all together in a single tarball, it is required that
they each be distributed independently in their own tarballs.

Cabal's approach is to say that if you can specify a dependency on a
package then that package should be able to be distributed
independently. Or to put it the other way round, if you want to
distribute it as a single unit, then it should be a single package.

Explicit dependencies and automatic package management
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Cabal takes the approach that all packages dependencies are specified
explicitly and specified in a declarative way. The point is to enable
automatic package management. This means tools like ``cabal`` can
resolve dependencies and install a package plus all of its dependencies
automatically. Alternatively, it is possible to mechanically (or mostly
mechanically) translate Cabal packages into system packages and let the
system package manager install dependencies automatically.

It is important to track dependencies accurately so that packages can
reliably be moved from one system to another system and still be able to
build it there. Cabal is therefore relatively strict about specifying
dependencies. For example Cabal's default build system will not even let
code build if it tries to import a module from a package that isn't
listed in the ``.cabal`` file, even if that package is actually
installed. This helps to ensure that there are no "untracked
dependencies" that could cause the code to fail to build on some other
system.

The explicit dependency approach is in contrast to the traditional
"./configure" approach where instead of specifying dependencies
declaratively, the ``./configure`` script checks if the dependencies are
present on the system. Some manual work is required to transform a
``./configure`` based package into a Linux distribution package (or
similar). This conversion work is usually done by people other than the
package author(s). The practical effect of this is that only the most
popular packages will benefit from automatic package management.
Instead, Cabal forces the original author to specify the dependencies
but the advantage is that every package can benefit from automatic
package management.

The "./configure" approach tends to encourage packages that adapt
themselves to the environment in which they are built, for example by
disabling optional features so that they can continue to work when a
particular dependency is not available. This approach makes sense in a
world where installing additional dependencies is a tiresome manual
process and so minimising dependencies is important. The automatic
package management view is that packages should just declare what they
need and the package manager will take responsibility for ensuring that
all the dependencies are installed.

Sometimes of course optional features and optional dependencies do make
sense. Cabal packages can have optional features and varying
dependencies. These conditional dependencies are still specified in a
declarative way however and remain compatible with automatic package
management. The need to remain compatible with automatic package
management means that Cabal's conditional dependencies system is a bit
less flexible than with the "./configure" approach.

.. note::
   `GNU autoconf places restrictions on paths, including the
   path that the user builds a package from.
   <https://www.gnu.org/software/autoconf/manual/autoconf.html#File-System-Conventions>`_
   Package authors using ``build-type: configure`` should be aware of
   these restrictions; because users may be unexpectedly constrained and
   face mysterious errors, it is recommended that ``build-type: configure``
   is only used where strictly necessary.

Portability
^^^^^^^^^^^

One of the purposes of Cabal is to make it easier to build packages on
different platforms (operating systems and CPU architectures), with
different compiler versions and indeed even with different Haskell
implementations. (Yes, there are Haskell implementations other than
GHC!)

Cabal provides abstractions of features present in different Haskell
implementations and wherever possible it is best to take advantage of
these to increase portability. Where necessary however it is possible to
use specific features of specific implementations.

For example a package author can list in the package's ``.cabal`` what
language extensions the code uses. This allows Cabal to figure out if
the language extension is supported by the Haskell implementation that
the user picks. Additionally, certain language extensions such as
Template Haskell require special handling from the build system and by
listing the extension it provides the build system with enough
information to do the right thing.

Another similar example is linking with foreign libraries. Rather than
specifying GHC flags directly, the package author can list the libraries
that are needed and the build system will take care of using the right
flags for the compiler. Additionally this makes it easier for tools to
discover what system C libraries a package needs, which is useful for
tracking dependencies on system libraries (e.g. when translating into
Linux distribution packages).

In fact both of these examples fall into the category of explicitly
specifying dependencies. Not all dependencies are other Cabal packages.
Foreign libraries are clearly another kind of dependency. It's also
possible to think of language extensions as dependencies: the package
depends on a Haskell implementation that supports all those extensions.

Where compiler-specific options are needed however, there is an "escape
hatch" available. The developer can specify implementation-specific
options and more generally there is a configuration mechanism to
customise many aspects of how a package is built depending on the
Haskell implementation, the operating system, computer architecture and
user-specified configuration flags.

.. include:: references.inc
