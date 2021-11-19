---
layout: blog
title: Interactive Development on a Computing Cluster with VS Code
usemathjax: true
published: false
summary: An guide on using VS Code for interactive development on the computing node of a computing cluster.
tags: [Tutorial, Coding, Computing cluster, Mercury, Acropolis]
---

# {{ page.title }}

This post outlines how to set up Visual Studio Code (VS Code) for interactive development on a compute node (i.e., not the head node) of a computing cluster. As an illustrative example, I will outline how to leverage a GPU computing node of the [Mercury](https://hpc-docs.chicagobooth.edu/) computing cluster of the UChicago Booth School of Business. The tutorial should be broadly applicable to most university computing servers, including the [Acropolis](https://sscs.uchicago.edu/category/faq/cluster/) computing cluster. 

Four key steps are required:
1. Installation of VS Code and the necessary extensions
2. Setting up SSH keys on the computing cluster
3. Initalizing a compute node with desired resources
4. Connecting to the compute node with VS Code

The following covers each in turn.

## 1. VS Code Setup

To get started, download and install the approriate version of VS Code for your system. You can find the download links [here](https://code.visualstudio.com/download).

Next, install the VS Code extension [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh). You can do so directly within VS Code: Use the top-menu bar and navigate to File->Preferences->Extensions (or use ``Ctrl+Shift+X``). Then search for ``Remote - SSH`` and press the install-button.

The Remote - SSH extension allows you to connect to a computing server directly from your local machine. This is incredibly useful for many reasons. Most importantly, it lets you develop using the convinience of your local machine but leveraging the superior computation resources of the computing cluster (i.e., far more memory, CPU cores, and/or a GPU). 

The best part about it? It's _super_ easy! Once the extension is installed, the bottom-left of your VS Code application will show a green box ("Open a Remote Window"). Clicking on it opens a dropdown menu (see picture), where you should select "Open SSH Configuration File...". This will open a ``config`` file where you can specify the address of the computing cluster (``HostName``) as well as your username (``User``) and store them under a convinient name (``Host``). See the below snipped for the entries in my file.

Insert vscode 1 picture here right float with text.

```bash
Host mercury
  HostName mercury.chicagobooth.edu
  User wiemann

Host acropolis
  HostName acropolis.uchicago.edu
  User wiemann
```

As an alternative, you can also directly connect to a computing server using the terminal line above the drop-down menu. In particular, I could type ``ssh wiemann@mercury.chicagobooth.edu`` each time I want to connect to Mercury. But if coders are good at one thing, it's being lazy -- so I'd much rather set up the ``config`` file once and then select "mercury" from a dropdown menu instead.

Insert pictures VScode 3 and VScode 3.2 (where select mercury from dropdown) here.

At this point, VS Code is likely asking for a password to admit you to the cluster. The next section will illustrate how we can avoid this for future connections. For now, enter your password and wait for VS Code to establish it's remote connection. 

## 2. Setting up SSH Keys

When your connecting to the computing cluster in the above manner, you are using the Secure Shell (SSH) protocol. It is a widely used  tool that provides users with a secure channel to a remote host. A key feature is its use of cryptogrphic keys to authenticate users for access to the remote server. We've not yet made explicit use of these keys and instead used password-based authentication. To connect to a compute node, however, setting up our SSH keys appropriately is a necessary step.

If you don't yet have a public SSH key for your local machine (you may already be using one for publishing code on GitHub, for example), you need to intialize it. The process of doing so differes across operating systems. If you are using Windows, install the SSH client [PuTTY](https://www.ssh.com/academy/ssh/putty/windows/install) and follow  [these instructions](https://www.ssh.com/academy/ssh/putty/windows/puttygen). Linux and Mac systems typically come with an SSH client preinstalled. Simply run the command ``ssh-keygen``, which will store the keys in the ``~/.ssh`` folder. 

Once you have a public SSH key (on Linux/Mac: ``~/.ssh/id_rsa.pub``), copy it to the set of _authorized keys_ on the computing cluster. Since you've already connected to the cluster in the previous step, simply navigate to the ``/.ssh`` folder on the computing cluster from within VS Code and paste the content of your public key (from your local machine) to a new line of the file ``~/.ssh/authorized_keys`` (on the computing cluster). Double-check that the key you pasted begins with ``ssh-rsa``.

To test whether the SSH keys have correctly been set up, close the remote connection in VS Code (e.g., by simply close the application), then restart VS Code and attempt to reconnect to the cluster. If the remote connection is established without password-authentication, you're set!

## 3. Requesting Interactive Sessions on Compute Nodes

So far, your connection to the computing server has been to the _head node_. The head node may in some cases be suitable for running tasks that require little resources (as is the case with Acropolis, for example). Since the resources of the head node are shared across all users who are simulateneously connectd to it, however, it is not good practice (and indeed not very nice) to use it for any coding sessions that require more computing power. To use the cluster for active development in settings where we want to leverage hardware exceeding that of our own machine, we need to request allocation of a computing node to our account on the server. Resources allocated to us are not shared across users and hence can be utilized in good conscience. 

Requesting an interactive session on a computing node is done via the terminal. The specific commands depend on the scheduler of the computing cluster. For example, the Mercury computing cluster uses ``slurm``. The below code snippit requests a session with four CPU cores, 32 GB of memory, and one GPU. See the Mercury documentation for additional options on how to request an interactive session ([link](https://hpc-docs.chicagobooth.edu/running.html)). 
```bash
# Start an interactive session with a GPU on Mercury
srun --account=phd --cpus-per-task=4 --mem-per-cpu=8G --partition=gpu --gres=gpu:1 --pty bash -l
```

The Acropolis computing cluster uses the ``qsub`` scheduler instead. The below snippit request a session with 28 computing threads, and 60 GB of memory. The important bit here is the ``-I`` option. Requests of resources are the same as you would usually specify in your ``qsub``-submission files.
```bash
# Start an interactive session with 16 threads on Acropolis
qsub -I -l nodes=1:ppn=28,mem=60gb -j oe
```

Submit whichever command is suitable for the computing cluster you're using via the terminal in your remotely connected VS Code and wait until the resources have been allocated. You should notice a change in the name of the node that you are connected to. For example, while the terminal read ``wiemann@acropolis ~$`` after initially connecting to the Acropolis cluster, it changed to ``wiemann@acropolis-0-6 ~$`` after requesting an interactive session via the above command. 

Next, you can start loading modules onto the session as you would when submitting jobs non-interactively. To see the list of available modules, run the command ``module avail`` in the terminal. For example, to load Python 3.6 on the Acropolis cluster, I submit the following command: ``module load python/3.6.1``. 

At this point, you could already utilize the compute node by simply running commands from your terminal (or parsing them to the terminal). This would not be an enjoyable experience, however. Among its many downsides is the inability for your VS Code session to access the environment variables. The reason for this is that while your terminal is now connected to the compute node, your VS Code session still rests on the head node of the cluster (so that variables are not shared). 

To fix this issue, we need VS Code to directly connect to the compute node. The next section illustrates how this can be achieved.

## 4. Connection to a Compute Node with VS Code

Unlike the head node of the computing cluster, to which you can connect directly via SSH, the compute nodes of the cluster (generally) don't have a direct connection to the internet. For VS Code to connect to a computing node, it's therefore necessary to "go through" the head node. This is done via a proxy connection.

First, check the exact name of the compute node that you have requested. In the previous example on Acropolis, the name of the compute node is ``acropolis-0-6 ~$`` (which I have read of the terminal which reads ``wiemann@acropolis-0-6 ~$`` in my case).

Second, add a new host to the ``config`` file that you've set-up in Section 1. Here, ``HostName`` is the name of the compute node (which may change across sessions) and ``ProxyJump`` specifies the address of the head node. Notice that I have set up a host called ``acropolis`` in Section 1.

```bash
Host acropolis-compute
  HostName acropolis-0-6
  ProxyJump acropolis
  User $USER
```

Third, start a new VS Code session and connect to a remote host via the Remote - SSH extension as before. Select the address of the newly specified host (in my case `acropolis-compute`) and wait for the connection to establish.

You're almost done! As a last step, install any VS Code extensions that you may want to utilize. For example, install the [R](https://marketplace.visualstudio.com/items?itemName=Ikuyadeu.r), [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python), and/or [Julia](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia) extensions on your remote machine.  

You can now use VS Code to code interactively on a compute node. Of course, next time around, you won't have to jump through all these hoops again. You only have to repeat Section 3 (request resources on the cluster) and ensure that the name of the compute node that is allocated to your account matches the ``HostName`` in your ``config`` file from Section 4.

_Last but not least: A special thanks to [Ed Jee](https://edjeeongithub.github.io/) for first putting ``Remote - SSH`` on my radar!_


In some cases, these keys are automatically generated after your first connection to the computing cluster (as is the case for Mercury), but you also need 


Start and interactive session with GPUs.

Connect to mercury via SSH 

```bash
ssh wiemann@mercury.chicagobooth.edu
```
login with password. (Note on how to set up keys so you don't need to reenter the pasword further below.)


```bash
# start an interactive session
srun --account=<ACCOUNT> --cpus-per-task=4 --mem-per-cpu=8G --partition=gpu --gres=gpu:1 --pty bash -l
```

```bash
nvidia-smi
```



Can now load your favorite langunage and start coding. To see which modules are available, run ``module avai``







As example an speed comparison, VAE in pytorch.

```bash
module load python/booth/3.6/3.6.12
jupyter notebook
```

Copy url to your device. Done!

VAE example.


If you don't want to use jupyter notebook, VS code also provides option.

Copy ssh key from yours ``id_rsa.pub`` to a new line in ``authorized_keys``


If unsure which accounts you have access to, run
```bash
sacctmgr show association where user=$USER format=cluster,account%24,user%24,qos
```
More on accounts on the [Mercury documentation](https://hpc-docs.chicagobooth.edu/architecture.html).

```bash
Host mercury
  HostName mercury.chicagobooth.edu
  User wiemann

Host mgpu01
  HostName mgpu01
  ProxyJump mercury
  User $USER
```

Connect, then start python script from withing VS code with python extension.


_Last but not least: A special thanks to [Ed Jee](https://edjeeongithub.github.io/) for first putting ``Remote - SSH`` on my radar!_


