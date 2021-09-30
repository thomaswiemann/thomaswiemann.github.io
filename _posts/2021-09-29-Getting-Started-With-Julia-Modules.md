---
layout: default
title: Getting Started with Julia Modules
usemathjax: true
published: true
---

# {{ page.title }}

Modules in Julia allow you to collect sets of objects, methods, and functions. The benefit is that modules can easily be loaded and shared, which makes the research workflow a lot more efficient, especially if code is relevant for multiple projects.

This post is a tutorial on how to create a personal Julia module. As an illustration, I use my applied econometrics module ``MyMethods.jl``. You can find the most recent version of the package on [github.com/thomaswiemann/MyMethods.jl](https://www.github.com/thomaswiemann/MyMethods.jl).

Three key aspects will be covered:
1. Creating a blank module
2. Setting up Git and GitHub
3. Developing features for module

Before you get started, make sure you've completed the preliminaries:
1) [Julia](https://julialang.org/downloads/) is installed together with your favorite IDE (e.g., [Atom](https://atom.io/)); 2) [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) is installed and configured; 3) You have a [GitHub](https://github.com/) account.

## 1. Creating a blank module

In theory, we could create all the files of our module from scratch, but starting at zero is a pain. Luckily, ``PkgTemplates.jl`` provides the kick start we need: the basic structure of our Julia module to which we can then add the interesting bits.

Open your favorite IDE and make sure that ``PkgTemplates.jl`` is installed. (If not: ``using Pkg; Pkg.add("PkgTemplates")``). For my module, I then simply ran the following bits of code:
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

The function ``Template()`` allows us to specify a handful of options for the module. I typically surpress Git here and instead configure it manually (see the next section). Make sure to edit the name, email and working directory of your module before running the code yourself.

Once you've initialized the package, navigate to the module folder. In my case this is ``/homas/thomas/GitHub/MyMethods``. You should see a few files and two folders there, lets go over each:
- ``Project.toml`` contains package info such as dependencies and authors.
- ``Manifest.toml`` is a machine generated file -- best to leave it be.
- ``README.md``, like any other readme file, can contain useful descriptions or comments on your package.
- ``LICENSE`` specifies how others may use and share your code.
- The ``src`` folder contains the content (or: source code) of your package. At the moment, it contains a single ``.jl`` file with your project name.
- The test folder contains a single file ``runtests.jl``, which we will use later to ensure our module is working as intended.

Notice that there is no a version control file in the project folder. This will change in the next section.

## 2. Setting up Git and GitHub

Git and GitHub are excellent utilities for keeping track of your project and sharing it with others. This section illustrates how your newly created (still empty) module can be hosted on GitHub.

To get started, we need a GitHub repository. Once you're logged in, you can create one on [GitHub.com](https://github.com). Make sure to give the repository the same name as your module _but_ append a ``.jl`` at the end. Do not create a license or README file.

<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/github.png" alt="drawing" width="500" class="center"/>

Once the repository is created, we will need to initialize Git in the local module directory and sync it with the GitHub repository. This is easily done with the terminal. Simply open a terminal and navigate to the folder where your module is stored (in my case, this is ``/homas/thomas/GitHub/MyMethods``). Then execute the following commands:
```Git
git init # this initializes git for the module
git add . # this adds all current files
git commit -m “initial commit” # our first commit
git branch -M main
git remote add origin git@github.com:thomaswiemann/MyMethods.jl.git
git push -u origin main # this uploads the code to GitHub
```

You should now be able to see your module on GitHub. But of course it's still empty and of little use in it's current form. We'll change this in the next section.

## 3. Develop your Package


To give an example of how you can add to your code, we will now create a least squares object with a set of corresponding methods.

To start development, it's useful to set julia into development mode. For this, install the Revise.jl package. This will continuously update the module without having to restart the julia kernel each time you update a function. This is extremely useful for debugging purposes.

After we have installed Revise.jl, open a julia REPL, enter the package mode by running ``]`` and then execute the command ``dev .``

Still in the package mode, enter ``activate .`` The terminal should now start with ``(MyMethods) pkg>``rather than specify the version number of julia! Leave the Julia REPL running. We'll need it for adding dependencies.

Now, open your favorite IDE and select the MyMethods project folder. I like to keep my content seperate from the MyMethods.jl file, so I create an additional folder in the src directory called FUN (short for functions).

Let's now start with the least squares implementation. For this, I create a new file called myLS.jl, stored inside the FUN folder.

The file contains two main parts. First, I define an object (in julia: ``struct``) that takes a vector ``y`` of outcomes and a matrix ``X`` of features and calculates the least squared coefficient. The coefficient, together with the inputs, are combined into a new object of type ``myLS``. Second, I create set of methods that can be called on an object of type ``myLS``. This includes a method called ``inference`` which calculates (heteroskedasticity robust) standard errors.

You can download the file here for the details:

As one expects, calculation of the least squares coefficient required some linear algebra functions. A good collection is contained in the package ``LinearAlgebra.jl`` that we need to add to our package dependencies. To do so, open your julia REPL and simply type ``add LinearAlgebra``. Since your in development mode, this will amend your project.toml and manifest.toml files with the necessary infos.

To include the newly defined object in our project, we need to edit the MyMethods.jl file in the src folder.

```julia
module MyMethods

using LinearAlgebra, Distributions, Random, DataFrames

export myLS
export coef, predict, inference

include("FUN/myLS.jl")

end
```

Ok this should be good!

To test the functions, I recomed writing a little test in the runtest.jl file in
the test folder.

You are going to test your function in any case. Then why not make that test
reproducable? It's 0 added effort! You can download my test file here: .

Once you've written your test, you can run it in the Julia REPL. If your projects
is already active, simply writing ``test`` suffices. If you're as lucky as me,
good news awaits! Otherwise, revise your implementation and retry your test.

Once all your tests are successful, your newly created functions are ready for
use. I reccomend comitting your changes in git and uploading the new version of
your package to GitHub.

You can do this easily via the terminal. Once navigated to the MyMethods folder,
run the following commands:
```git
git status # this shows you which files you have edited
git add . # this adds all files to the new commit
git commit -m "adds myLS.jl" # commit your changes
git push # this uploads your code to GitHub
```





[myLS.jl](/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/myLS.jl)

[runtests.jl](/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/runtests.jl)




<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/atom.png" alt="drawing" width="300"/>



<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/terminal1.png" alt="drawing" width="300"/>
<img src="/assets/blog/2021-09-29-Getting-Started-With-Julia-Modules/terminal2.png" alt="drawing" width="300"/>


Last but not least, there should be some nice options for displaying math in-text -- like $\beta$ -- as well as via proper equations:
\begin{equation}
\beta \sim \mathcal{N}(0,1)
\end{equation}

$$\beta$$
