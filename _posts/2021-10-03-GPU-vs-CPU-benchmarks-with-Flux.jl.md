---
layout: blog
title: GPU vs CPU benchmarks with Flux.jl
usemathjax: true
published: true
summary: A convolutional neural network training time comparison between GPU and CPU with Flux.jl.
tags: [Julia, Flux.jl, Deep Learning, Coding]
---

# {{ page.title }}

This post compares the training time of a simple convolutional neural network on a GPU and CPU. The data, network architecture, and training loops are based on those provided in the fluxml.ai [tutorial](https://fluxml.ai/tutorials/2020/09/15/deep-learning-flux.html) on deep learning.

I am using a Dell XPS 13 laptop with an Intel i7-7500U CPU, connected to an Nvidia GTX 1080 using the Razer Core X external GPU dock. Neither the CPU nor the GPU are particularly fast compared to 2021 hardware, so you can expect to see much faster results on modern machines.

You can download the notebook containing all the code [here](/assets/blog/2021-10-03-GPU-vs-CPU-benchmarks-with-Flux.jl/GPU-vs-CPU-benchmarks-with-Flux.jl.ipynb).

### Preliminaries

As usual, the necessary packages are loaded. Unless you already have it stored locally, the image data, which we will train the neural networks on, also needs to be downloaded.


```julia
# Load necessary packages
using Statistics
using Flux, Flux.Optimise
using Flux: onehotbatch, onecold
using Flux: crossentropy, Momentum
using Base.Iterators: partition
using CUDA
using Metalhead, Images
using Metalhead: trainimgs
using Images.ImageCore
using BenchmarkTools: @btime

# Download image data (unless stored locally)
Metalhead.download(CIFAR10);
```

### Data preparation

Prior to training, the downloaded image data needs to be prepared and loaded onto the GPU. I don't specify a validation sample here as the focus is entirely on benchmarking training time. (Note that explicit transfer to the cpu via ``|> cpu`` is not necessary. I do this here solely for emphasis.)


```julia
# Prepare data
X = trainimgs(CIFAR10)
labels = onehotbatch([X[i].ground_truth.class for i in 1:50000],1:10)
getarray(X) = float.(permutedims(channelview(X), (2, 3, 1)))
imgs = [getarray(X[i].img) for i in 1:50000]

# Load data to gpu and cpu
train_gpu = ([(cat(imgs[i]..., dims = 4),
            labels[:,i]) for i in partition(1:50000, 1000)]) |> gpu
train_cpu = ([(cat(imgs[i]..., dims = 4),
            labels[:,i]) for i in partition(1:50000, 1000)]) |> cpu
```

### Neural network construction

The constructed convolutional neural network has a total of 39,558 trainable parameters. We need to define one for both the GPU and CPU separately.

```julia
# Define neural networks for both gpu and cpu
m_gpu = Chain(
  Conv((5,5), 3=>16, relu),
  MaxPool((2,2)),
  Conv((5,5), 16=>8, relu),
  MaxPool((2,2)),
  x -> reshape(x, :, size(x, 4)),
  Dense(200, 120),
  Dense(120, 84),
  Dense(84, 10),
  softmax) |> gpu

m_cpu = Chain(
  Conv((5,5), 3=>16, relu),
  MaxPool((2,2)),
  Conv((5,5), 16=>8, relu),
  MaxPool((2,2)),
  x -> reshape(x, :, size(x, 4)),
  Dense(200, 120),
  Dense(120, 84),
  Dense(84, 10),
  softmax) |> cpu
```

Finally, the loss and optimizers need to be defined. I again define these for the GPU and CPU separately to avoid any contamination.

```julia
# Define loss and optimizer
loss_gpu(x, y) = sum(crossentropy(m_gpu(x), y))
opt_gpu = Momentum(0.01)

loss_cpu(x, y) = sum(crossentropy(m_cpu(x), y))
opt_cpu = Momentum(0.01)
```

### Benchmark Results

The training loops defined below are set to a single epoch to avoid overly long runtimes (on the CPU). Of course, feel free to increase the ``epochs`` for more extensive benchmarking.

```julia
# Set number of training iterations
epochs = 1

# GPU benchmark
@btime for epoch = 1:epochs
  for d in train_gpu
    gs = gradient(params(m_gpu)) do
      l = loss_gpu(d...)
    end
    update!(opt_gpu, params(m_gpu), gs)
  end
end

julia> 828.756 ms (1407620 allocations: 56.20 MiB)

# CPU benchmark
@btime for epoch = 1:epochs
  for d in train_cpu
    gs = gradient(Flux.params(m_cpu)) do
      l = loss_cpu(d...)
    end
    update!(opt_cpu, Flux.params(m_cpu), gs)
  end
end

julia> 82.470 s (107104 allocations: 14.45 GiB)
```

On my machine, a single training epoch takes about 0.83 seconds on the GPU but a whooping 82.47 seconds on the CPU. **That's a 98.99% speedup!**
