---
title: "Publish to Github Pages"
description: Blogging the Publishing of the Blog to Github
date: 2018-05-08T08:53:40-05:00
featured: github_pages.png
featuredalt: "Github Pages"
featuredpath: img/publish-to-github/
type: post
---

# Intro

In this blog post we will be taking the [Hugo website we created] (/blog/inception/) and publishing it via GitHub Pages.

To accomplish this we will be creating two GitHub repos:

* hugo.${GIT_USERNAME}.github.io - to contain the hugo source for the blog
* ${GIT_USERNAME}.github.io - to container the served static html for the blog

${GIT_USERNAME}.github.io will be mounted a submodule in hugo.${GIT_USERNAME}.github.io 's public/ subdirectory.

# [Publish Hugo Site via Github] (#public-via-github)

## [Prereqs] (#publish-via-github-prereqs)

* [Sign up for a Github account if you don't have one already](https://github.com/join)

## [Save  Hugo Source to Github] (#save-source-to-github)

### [Create a repo for Hugo source] (#create-hugo-source-repo)

Note: Do not use ${GIT_USERNAME}.github.io for this, we will need it for the output of Hugo later.

Use hugo.${GIT_USERNAME}.github.io

[Create Github Repo](https://github.com/new)

![Github New Repo](/img/publish-to-github/create-new-github-repo.png)

### [Add Github Repo as a remote] (#add-hugo-source-remote)

Note: hugo.${GIT_USERNAME}.github.io was created in the [Inception] (/blog/inception/) blog post, see there for details as to how to set it up.

```bash
cd hugo.${GIT_USERNAME}.github.io
git remote add origin git@github.com:${GIT_USERNAME}/hugo.${GIT_USERNAME}.github.io.git
```

### [Push Hugo Source to Github] (#commit-hugo-source-to-github)

```bash
git push -u origin master
```

## [Save Hugo Generated Site to Github] (#save-hugo-generated-site-to-github)

### [Create a repo for Hugo Generated Site] (#create-generated-site-repo)

You will need to name this repo ${GIT_USERNAME}.github.io

[Create Github Repo](https://github.com/new)
![Github New Repo](/img/publish-to-github/create-new-github-repo-2.png)

### [Add ${GIT_USERNAME}.github.io as submodule in public/] (#add-public-submodule)

Now you can add, and push the submodule for the public/ directory.

```bash
git submodule add git@github.com:${GIT_USERNAME}/${GIT_USERNAME}.github.io.git public
git add .
git commit -s -m "Added edwarnicke.github.io submodule to subdir public/"
git push
```
### [Hugo generate site] (#hugo-generate-site)

```bash
$ hugo
                   | EN  
+------------------+----+
  Pages            | 10  
  Paginator pages  |  0  
  Non-page files   |  0  
  Static files     | 13  
  Processed images |  0  
  Aliases          |  1  
  Sitemaps         |  1  
  Cleaned          |  0 
```

Hugo write the static html it generates into the public/ subdirectory.

# Pushing public/

```bash
cd public/
git add .
git commit -s -m "Hugo site generation from git@github.com:${GIT_USERNAME}/hugo.${GIT_USERNAME}.github.io.git@$(cd ../;git rev-parse --short HEAD)"
git push
```

# Updating reference in hugo.${GIT_USERNAME}.github.io

To finish up we need to make sure that hugo.${GIT_USERNAME}.github.io has the proper reference to the generated public/ site:

```bash
git add .
git commit -s -m "Add post on publishing to Github"
```

# [Dangerous Bends: A Warning about git clone and submodules] (https://en.wikipedia.org/wiki/Bourbaki_dangerous_bend_symbol)

Because we are using submodules, you need to make sure that you use

```bash
git clone --recurse-submodules hugo.${GIT_USERNAME}.github.io
```

when cloning.  Failure to do so will *not* clone your submodules (including your theme) which will lead to no end of troubles.



