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
Coming soon.

## Blog Posts
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
