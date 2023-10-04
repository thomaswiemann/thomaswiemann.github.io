---
layout: default
title: Computing
group: "navigation"
order: 3
summary: Open-source software and a collection of blog posts on computation and computational methods.
tags: [Computation, Blog, Software, Tutorial, Coding]

---

# Computing

## Software
[``ddml``: Double/Debiased Machine Learning in Stata](https://statalasso.github.io/docs/ddml/)

[``ddml``: Double/Debiased Machine Learning in R](https://thomaswiemann.com/ddml/) [![CRAN
Version](https://www.r-pkg.org/badges/version/ddml)](https://cran.r-project.org/package=ddml)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/ddml)](https://cran.r-project.org/package=ddml)

## Computational Methods in Economics Working Group (Econ 61600)
Together with [Thibaut Lamadon](https://lamadon.com/) and [Guillaume Pouliot](https://sites.google.com/site/guillaumeallairepouliot/), I co-organize the UChicago economic department's computational methods in economics working group (Econ 61600). 

We meet on a bi-weekly basis. Please reach out if you're interested in participating! 

## Blog Posts
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
