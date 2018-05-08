---
title: "Inception"
description: "Blogging the Blog Creation"
date: 2018-05-07T13:57:58-05:00
featured: hugo-logo.png
featuredalt: "Hugo Logo"
featuredpath: /img/inception/
type: post
---

# [Inception] (#inception)

The goal of this blog post is to blog the creation of the blog and this blog post.  Its strangeloops all the way down.  To get there, we will be using [Hugo] (https://gohugo.io/), the amazing Go based static website generator.

Hugo uses [Go templates] (https://golang.org/pkg/text/template/) to generate a static website from [Markdown] (https://en.wikipedia.org/wiki/Markdown).

Hugo is themeable, and comes with no default theme.  In this blog post we will be using the [Future Imperfect] (https://themes.gohugo.io/theme/future-imperfect/) theme.

Getting the various parts of that theme working took a while to figure out.  This blog post will walk you through, step by step, with images, through standing up *this* blog.  What you are reading here is exactly what the instructions walk you through standing up.

It is presumed that we will eventually publish this to GitHub Pages (see subsequent blog post) and so we will be using hugo.${GIT_USERNAME}.github.io in a lot of places.

Without further ado... lets get going.

# [Install Hugo] (#install-hugo)

## [Prereqs] (#hugo-prereqs)

We presume in this tutorial that you have git and Go installed.  Most of you will already have them (recent versions are always a plus).  For those of you who don't:

* Install [Git] (http://git-scm.com/)
* Install [Go] (https://golang.org/dl/)

Its always an interesting challenge writing instructions that everyone can follow easily without extensive editing.  One trick to make it easier is to use ENV variables.  You will have a much happier experience cut-and-pasting from here if you pause to set:

```
export GIT_USERNAME=${your github username}
```

## [Build Hugo] (#build-hugo)

Hugo has a [variety of install methods] (https://gohugo.io/getting-started/installing/).  We are going to [Go] (https://golang.org/) old school here and build it from source.  Building [Go] source is pretty easy:

```
go get github.com/magefile/mage
go get -d github.com/gohugoio/hugo
cd ${GOPATH:-$HOME/go}/src/github.com/gohugoio/hugo
mage vendor
mage install
export PATH=${PATH}:${GOPATH:-$HOME/go}/bin
```

## [Test Hugo] (#test-hugo)
If you succeed, you should find testing go easy with:

```
hugo version
```

# [Create a new Hugo site:] (#create-hugo-site)

Creating a new Hugo site is easy:

```
hugo new site hugo.${GIT_USERNAME}.github.io
```

which will create a new directory hugo.${GIT_USERNAME}.github.io containining an initial, effectively empty, Hugo site without a theme.

## [Initialize as a git repo] (#initialize-hugo-git-repo)

All the things are belonging to git:

```bash
cd hugo.${GIT_USERNAME}.github.io
git init
```

## [Add a .gitignore] (#add-hugo-git-ignore)

Life is always happier with a good .gitignore file:

```bash
cat << EOF > .gitignore
## OS Files
# Windows
Thumbs.db
ehthumbs.db
Desktop.ini
$RECYCLE.BIN/

# OSX
.DS_Store
EOF
```

## [Commit the initial Hugo source] (#commit-initial-hugo-source)

```bash
git add .
git commit -s -m "Initial commit of site"
```

Note: git only commits directories that have files in them. Since at this stage most of the directories are empty, they will not be part of the commit.

# [Configuring Hugo] (#configure-hugo)

## [Basic Hugo Config] (#basic-hugo-config)

Hugo's configuration file is called [config.toml] (https://gohugo.io/getting-started/configuration/).

By default it contains:
```bash
$ cat config.toml 
baseURL = "http://example.org/"
languageCode = "en-us"
title = "My New Hugo Site"
```

Lets replace it with some actual data using:

```bash
cat << EOF > config.toml
baseURL = "https://${GIT_USERNAME}.github.io"
languageCode = "en-us"
title = "Eudaimonic Tech" # Replace with your on title
EOF
```

## [Adding the Future Imperfect Theme] (#adding-future-imperfect)

[Future Imperfect] (https://themes.gohugo.io/theme/future-imperfect/) is a light and flexible Hugo theme.  We'll be using it here.

Fork the [Future Imperfect Theme] (https://github.com/jpescador/hugo-future-imperfect) so you have your own copy, in case you want to customize it later.

Add a submodule for the Future Imperfect Theme
```bash
git submodule add https://github.com/edwarnicke/hugo-future-imperfect.git
```
to pull it into the Hugo site being developed.

## [Configuring Hugo for the Future Imperfect Theme] (#configure-future-imperfect)

Hugo needs to be told which theme to use.  A simple modification to the config.toml will do the trick:

```bash
echo 'theme = "hugo-future-imperfect"' >> config.toml
```

# Serving your site

One of the many cool things Hugo can do is serve your site locally, including automatically updating (typically in 10s of ms) whenever you change your sites content.

```bash
hugo serve -D
```

Point your browser at http://localhost:1313/

It will look something like:

![site-with-theme] (/img/inception/site-with-theme.png)

Wait you cry!  That isn't the beautiful blog layout I see before me!  You are correct.  Future Imperfect requires a fair bit of additional configuration to get what you see here.  We'll walk step by step through those changes needed to make the Hugo site feel like home.


# Making the Hugo Site Feel Like Home

## [Configure the NavBar Title] (#configure-nav-bar)

```bash
cat << EOF >> config.toml
[params]
  # Sets the navbarTitle that appears in the top left of the navigation bar
  navbarTitle          = "Eudaimonic Tech"
EOF
```
![navbar-title] (/img/inception/navbar-title.png)

## [Add a Favicon] (#add-a-favicon)

```bash
mkdir -p static/favicon
```

copy your favicon png to:
```bash
static/favicon/favicon-1.png
```

Add the following to your [params] section in your config.toml:
```bash
cat << EOF >> config.toml
  # https://github.com/audreyr/favicon-cheat-sheet
  loadFavicon          = true
  faviconVersion       = "1"
EOF
```

You may need to exit and restart your browser to see the favicon.

![add-favicon] (/img/inception/add-favicon.png)

## [Adding the Socials] (#adding-the-socials)

```bash
cat << EOF >> config.toml
  socialAppearAtTop    = true # Added to the [params] section
  socialAppearAtBottom = true # Added to the [params] section

[social]
  # Coding Communities
  github           = "edwarnicke"
  linkedin         = "edwarnicke"
  facebook         = "edwarnicke"
  twitter          = "edwarnicke"
  youtube          = "channel/UCfKkzlRvD_9r8zjcMtC9uDA?view_as=subscriber"
  gitlab           = ""
  stackoverflow    = "" # User Number
  bitbucket        = ""
  jsfiddle         = ""
  codepen          = ""
  # Visual Art Communities
  deviantart       = ""
  flickr           = ""
  behance          = ""
  dribbble         = ""
  # Publishing Communities
  wordpress        = ""
  medium           = ""
  # Professional/Business Oriented Communities
  linkedin_company = ""
  foursquare       = ""
  xing             = ""
  slideshare       = ""
  # Social Networks
  googleplus       = ""
  reddit           = ""
  quora            = ""
  vimeo            = ""
  whatsapp         = "" # WhatsApp Number
    # WeChat and QQ need testing.
    wechat         = ""
    qq             = "" # User ID Number
  instagram        = ""
  tumblr           = ""
  skype            = ""
  snapchat         = ""
  pinterest        = ""
  telegram         = ""
  vine             = ""
  googlescholar    = ""
  orcid            = ""
  researchgate     = ""
  # Email
  email            = ""
EOF
```
![social-media-icons] (/img/inception/social-media-icons.png)


## [Configure the NavBar Intro] (#configure-nav-bar-intro)

```bash
cat << EOF >> config.toml
[params.intro]
  header    = "Eudaimonic Tech"
  paragraph = "Technology for Human Flourishing"
  about     = "Technology for Human Flourishing"
EOF
```

![configure-navbar-intro] (/img/inception/configure-navbar-intro.png)

## [Configure a Logo] (#configure-a-logo)

Make an image directory in static/ :
```bash
mkdir -p static/img
```

Copy your logo into static/img/.  For me that is:
```bash
static/img/eudaimonic.tech.logo.svg
```

To add a logo to your site, we will need to add some parameters to the config.toml.

```bash
cat << EOF >> config.toml
[params.intro.pic]
  src       = "img/eudaimonic.tech.logo.svg"
  width     = "150px"
  alt       = "Eudaimonic Tech"
EOF
```

![add-logo] (/img/inception/add-logo.png)

## [Add a 'Blog' section] (#add-a-blog-section)

```bash
cat << EOF >> config.toml
# Sets the menu items in the navigation bar
# Identifier prepends a Font Awesome icon to the menu item
[[menu.main]]
  name = "Blog"
  url = "/blog/"
  identifier = "fa fa-newspaper-o"
  weight = 1
EOF
```

![add-blog-section] (/img/inception/add-blog-section.png)

NOTE: Clicking the "Blog" section in the header will yield a 404, as we have no blog entries yet.

## [Create 'Inception' blog post] (#create-inception-blog-post)

```bash
hugo new blog/inception.md
```

Which will create
```
content/blog/inception.md
```

And start it out with content:
```
---
title: "Inception"
date: 2018-05-07T13:57:58-05:00
draft: true
---
```

You will need to edit the front matter to add 'type=post' so it looks like:
```
---
title: "Inception"
date: 2018-05-07T13:57:58-05:00
type: post
---
```

![add-inception-blog-post] (/img/inception/add-inception-blog-post.png)

## [Add a feature image to 'Inception' blog post] (#add-feature-image)

Create a directory for your post's images
```
mkdir -p static/img/inception
```

Copy your blog posts image to:
```
static/img/inception/hugo-logo.png
```

You will need to edit the front matter to add:
```
featured: hugo-logo.png
featuredalt: "Hugo Logo"
featuredpath: /img/inception/
```

So it looks like:
```
---
title: "Inception"
date: 2018-05-07T13:57:58-05:00
featured: hugo-logo.png
featuredalt: "Hugo Logo"
featuredpath: /img/inception/
type: post
---
```

![add-featured-image] (/img/inception/add-featured-image.png)

## [Add a description to 'Inception' blog post] (#add-description)

Add to the front matter for your blog post:
```
description: "Blogging the Blog Creation"
```

So it looks like:
```
---
title: "Inception"
description: "Blogging the Blog Creation"
date: 2018-05-07T13:57:58-05:00
featured: hugo-logo.png
featuredalt: "Hugo Logo"
featuredpath: /img/inception/
type: post
---
```
![add-blog-description] (/img/inception/add-blog-description.png)

## [Add Social Media Share Buttons to blog posts] (#add-social-media-buttons)

Add to your config.toml [params] section
```toml
  # Sets Social Share links to appear on posts
  socialShare          = true
  # Sets specific share to appear on posts (default behavior is to appear)
  socialShareTwitter   = true
  socialShareFacebook  = true
  socialShareLinkedin  = true
```

![add-social-media-share-buttons] (/img/inception/add-social-media-share-buttons.png)

## [Add content to the blog post] (#add-content)

Content in Hugo is written after the front matter (the stuff between ---) and is written in Markdown:

[Markdown Cheat Sheet] (https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

![add-blog-post-content] (/img/inception/add-blog-post-content.png)

## [Add an 'About' page] (#add-about)

```
hugo new about/_index.html
```

Add your about content to:
```
content/about/_index.html
```

Add the About menu item to your config.toml:

```bash
cat << EOF >> config.toml
[[menu.main]]
  name = "About"
  url = "/about/"
  identifier = "fa fa-id-card-o"
  weight = 2
EOF
```
![add-about-section] (/img/inception/add-about-section.png)

# Commit your changes

```bash
git add .
git commit -s -m "Add Inception Blog Post"
```

