# Simple blog (using Eio)

Presentation of a very simple blog, using **YOCaml** with the plugins
`yocaml_jingoo` as template engine, `yocaml_yaml` to describe metadata,
`yocaml_omd` for parsing Markdown and `yocaml_unix` as source runtime and
`yocaml_git` as a target runtime. Metadata is described using **Archetypes**,
data models pre-bundled with YOCaml, serving as examples or tools to quickly
build a blog.

The code process is located into `examples/simple-blog` (a library that
describes the blog generator)

## Information

The project is described in the **YOCaml** source tree, so no particular OPAM set-up
is required (if the development environment is properly set up) and should be
used _only_ to understand how to build a blog.

## Launch of the blog

Generation is designed to be launched from the root of the project with the
command: `dune exec examples/simple-blog-git/bin/simple_blog_git.exe`.