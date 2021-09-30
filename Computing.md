---
layout: default
title: Computing
group: "navigation"
order: 3
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
