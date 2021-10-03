non-breaking---
layout: blog
title: Getting Started with Julia Modules
usemathjax: true
published: true
---

# {{ page.title }}

Julia Modules allow you to collect sets of objects, methods, and functions. The benefit is that modules can easily be loaded and shared, which makes the research workflow a lot more efficient if code is relevant for multiple projects.

This post is a tutorial on how to create a personal Julia module. As an illustration, I use my applied econometrics module ``MyMethods.jl``. You can find the most recent version of the package on [github.com/thomaswiemann/MyMethods.jl](https://www.github.com/thomaswiemann/MyMethods.jl).

Three key aspects will be covered:
1. Creating a blank module
2. Setting up Git and GitHub
3. Development workflow

Before you get started, make sure you've completed the preliminaries:
1) [Julia](https://julialang.org/downloads/) is installed together with your favorite IDE (e.g., [Atom](https://atom.io/)); 2) [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) is installed and configured; 3) You have a [GitHub](https://github.com/) account.

## Creating a blank module

In theory, we could create all the files of the module from scratch, but starting at zero is a pain. Luckily, ``PkgTemplates.jl`` provides the kick start we need: the basic structure of our Julia module to which we can then add the interesting bits.

Open your favorite IDE and make sure that ``PkgTemplates.jl`` is installed. (If not ``using Pkg; Pkg.add("PkgTemplates")`` will do the trick.) For my module, I then simply run the following code:
```julia
using PkgTemplates

# Create a template
t = Template(user = "thomaswiemann",
             authors = "Thomas Wiemann <wiemann@uchicago.edu>",
             dir = "/home/thomas/GitHub",
             julia = v"1.4",
             plugins = [
                 License(name = "MIT"),
                 !Git,
                 !CompatHelper,
                 !TagBot
             ])

# Create the package
t("MyMethods")
```

The function ``Template()`` allows us to specify a handful of options. I typically suppress Git here and instead configure it manually (see the next section). Make sure to edit the name, email, and working directory of your module before running the code yourself. The last line of the code specifies the module name. It is convention in Julia that module names start with a capital letter, but otherwise you can be creative.

Once you've initialized your package, navigate to the module folder. In my case this is ``/home/thomas/GitHub/MyMethods``. You should see a few files and two folders there. Lets go over each:
- ``Project.toml`` contains package info such as dependencies and authors.
- ``Manifest.toml`` is a machine generated file &ndash; best to leave it be.
- ``README.md``, like any other readme file, can contain useful descriptions or comments on your package.
- ``LICENSE`` specifies how others may use and share your code.
- The ``src`` folder contains the content (or: source code) of your package. At the moment, it contains a single ``.jl`` file with your project name.
- The test folder contains a single file ``runtests.jl``, which we will use later to ensure the module is working as intended.

Notice that there is no a version control file in the project folder. This will change in the next section.

## Setting up Git and GitHub

Git and GitHub are excellent utilities for keeping track of your project and sharing it with others. This section illustrates how your newly created (still empty) module can be hosted on GitHub.

To get started, login at [GitHub.com](https://github.com) and create a new repository. Make sure to give the repository the same name as your module but append a ``.jl`` at the end of the repository name. Do not create a license or README file.

<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/github.png" alt="drawing" width="500" class="center"/>

Once the repository is created, Git needs to be initialized in the local module directory. This is easily done with the terminal. Simply open a terminal and navigate to the folder where your module is stored (in my case, this is ``/home/thomas/GitHub/MyMethods``). Then execute the following commands:
```Git
git init # this initializes git for the module
git add . # this adds all current files
git commit -m “initial commit” # our first commit
git branch -M main
git remote add origin git@github.com:thomaswiemann/MyMethods.jl.git
git push -u origin main # this uploads the code to GitHub
```

You should now be able to see your module on GitHub. If you're repository is public, users can install your module directly from GitHub. In my case, it looks like this:
```julia
using Pkg;
Pkg.add(url="https://github.com/thomaswiemann/MyMethods.jl")
```
But of course it's still empty and of little use in it's current form. We'll change this in the next section.

## Development workflow

This section illustrates the development workflow. As an example, we will walk through adding a simple linear regression object to the ``MyMethods.jl`` module.

When working on a new feature of a module, it's useful to work with both the REPL and your favorite IDE. The REPL allows for convenient package operations such as adding dependencies. The IDE is best suited for developing code.

Once you've opened the REPL, navigate to the module directory (in my case, this is ``/home/thomas/GitHub/MyMethods``). It's useful to set Julia into development mode. This will continuously update your environment with changes you've made to your module. (Otherwise, you'd have to restart your Julia kernel _very often_.) To do so, install the ``Revise.jl`` and enter the package mode (via ``]``). Then execute the command ``dev .``.

While you're still in the package mode, run the command ``activate .``. The terminal should now start with your package name rather than specify the version number of Julia. Leave the Julia REPL running. We'll need it for adding dependencies.

<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/terminal1.png" alt="drawing" class="center"/>

Once the REPL is set up, open your favorite IDE and select the module folder. I like to create an additional folder in the ``src`` directory called ``FUN`` (short for functions) where the module features will be stored. Creating a separate folder is not required but may help with organization.

<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/atom.png" alt="drawing" class="wrapped_right" width="30%"/>

Let's now start with the least squares implementation. For this purpose, I create a new file called ``myLS.jl``, stored inside the ``FUN`` folder. You can download the file here: [myLS.jl](/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/myLS.jl).

The file contains two main parts. First, I define an object (in Julia: ``struct``) that takes a vector ``y`` of outcomes and a matrix ``X`` of features and calculates the least squared coefficient (i.e., $\hat{\beta}=(X^\top X)^{-1}X^\top y$). The coefficient and the inputs are then are combined into a new object of type ``myLS``. Second, I create set of complementary methods that can be called on an object of type ``myLS``. This includes a method called ``inference`` which calculates (heteroskedasticity robust) standard errors.

As one expects, calculation of the least squares coefficient required some linear algebra functions. A good collection is contained in the package ``LinearAlgebra.jl``, which needs to added to the package dependencies. To do so, select the REPL. It should be set to active &ndash; if not, repeat the commands from the beginning of the section. Then, simply type ``add LinearAlgebra``. This will automatically amend your ``Project.toml`` and ``Manifest.toml`` files with the necessary details. The other dependencies &ndash; ``Distributions``, ``Random``, and ``DataFrames`` &ndash; can be added in the same fashion.

[comment]: <> (
  possibly restructure, where the active development mode is introduced only with the addition of dependencies.

  To add dependencies: 1. Start the Julia REPL. 2. enter package mode. 3. activate. add command.
  )

We're now ready to include the newly defined object in our project. This is done by editing the ``MyMethods.jl`` file in the ``src`` folder. In addition to the dependencies, we need to specify which objects and methods should be available to users who load the module, as well as specify the location of our source code. In my case, the edited file reads:
```julia
module MyMethods

using LinearAlgebra, Distributions, Random, DataFrames

export myLS
export coef, predict, inference

include("FUN/myLS.jl")

end
```

This looks good already! As a final step, we should make sure the added features have the desired functionality. You will inevitably test your functions when developing your code, but chances are, you're not (yet) doing it in a particularly reproducible manner. Since it's zero added effort, I recommend writing a little test in the ``runtest.jl`` file. You can download the tests I specified for the ``myLS`` object here: [runtests.jl](/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/runtests.jl).

<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/terminal2.png" alt="drawing" class="wrapped_right" width="40%"/>

Once you've written your test, you can run it in the REPL. If your project is already active, simply executing the command ``test`` suffices. If you're as lucky as me, good news awaits! Otherwise, revise your implementation and retry your tests.

Once all your tests are successful, your newly created functions are ready for
use. I recommend committing your changes in git and uploading the new version of
your package to GitHub. You can do this via the terminal. Once navigated to the module directory,
run the following commands:
```git
git status # this shows you which files you have edited
git add . # this adds all files to the new commit
git commit -m "adds myLS.jl" # commit your changes
git push # this uploads your code to GitHub
```

[comment]: <> (
  Semantic versioning https://semver.org/. <major>.<minor>.<patch>

  major: when changed means that a major change has been introduced in the release that is incompatible with the previous release.

  minor: when changes means that there are non-breaking enhancements introduced in the release.

  patch: when changed means that there are nonbreaking bug fixes in the release
  )

This concludes the basic workflow of 1) adding features to the module, 2) testing
the module, and finally 3) committing the changes to Git and uploading the new improvements to GitHub.
