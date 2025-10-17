# The Delta

**The Delta** is a modern static blog powered by [zvc](https://github.com/zvc-project/zvc), a Python-based static site generator.

## 📦 Setup

This project is managed with [uv](https://github.com/astral-sh/uv), a fast Python package manager.

```bash
# Virtual environment is automatically created
.venv/
```

## 🚀 Usage

### Start Local Server (Build + Serve)

```bash
make serve
```

This command automatically builds the site and starts a local server at `http://localhost:8002`.

### Build Only

```bash
make build
# or
uv run zvc build
```

Generated static files are saved in the `docs/` directory.

### Clean Generated Files

```bash
make clean
# or
uv run zvc clean
```

### Create a New Post

Create a folder in the `contents/` directory and add a Markdown file:

```bash
# Create folder
mkdir contents/my-post

# Create post
nano contents/my-post/my-post.md
```

```markdown
---
title: My Post Title
pub_date: 2025-10-17
description: Post description for SEO
tags: tag1, tag2, tag3
---

# Content

Write your post in Markdown.
```

**Important**: Post files must be inside a folder. Follow the `contents/{slug}/{slug}.md` structure.

## 📁 Project Structure

```
thedelta/
├── config.yaml                    # Blog configuration (English)
├── contents/                      # Markdown content
│   ├── welcome/
│   │   └── welcome.md
│   └── modern-web-architecture/
│       └── modern-web-architecture.md
├── themes/                        # Theme files
│   └── default/
│       ├── index.html            # SEO optimized
│       └── post.html             # SEO optimized
├── docs/                          # Generated static site
│   ├── index.html
│   └── 2025/10/{15,17}/{slug}/
├── Makefile                       # Build automation
├── pyproject.toml                 # Python project config
└── README.md
```

## ⚙️ Configuration

Modify blog settings in the `config.yaml` file:

```yaml
blog:
  title: "Blog Title"
  description: "Blog Description"

theme:
  name: "default"

publication:
  path: "docs"
```

## 🎨 Theme

Themes are managed in the `themes/` directory. The default theme provides a modern, responsive design with Montserrat typography.

### Theme Templates

- `index.html`: Blog homepage
- `post.html`: Individual post page

## 📚 Tech Stack

- **zvc**: Python static site generator
- **uv**: Fast Python package manager
- **Jinja2**: Template engine
- **Markdown**: Content authoring
- **Montserrat**: Modern geometric sans-serif font

## 🔍 SEO Optimization

This blog includes comprehensive SEO features:

- **Meta Tags**: Complete description, keywords, and author tags
- **Open Graph**: Facebook and social media sharing optimization
- **Twitter Cards**: Twitter sharing metadata
- **Semantic HTML**: Proper HTML5 semantic tags
- **Responsive Design**: Mobile-friendly responsive layout
- **Fast Loading**: Static HTML for instant page loads
- **Article Tags**: Tag metadata for each post

## 🌐 Deployment

Deploy the `docs/` directory to GitHub Pages, Netlify, Vercel, or any static hosting service.

### GitHub Pages Example

1. Go to repository Settings → Pages
2. Set source to `main` branch and `/docs` folder
3. Push changes to deploy automatically

## 🎯 Features

- ✅ Modern, minimalist design
- ✅ Fully responsive layout
- ✅ SEO optimized (meta tags, Open Graph, Twitter Cards)
- ✅ Fast static HTML generation
- ✅ Markdown-based content
- ✅ Tag support
- ✅ Date-based URL structure
- ✅ Code syntax highlighting ready
- ✅ Google Fonts (Montserrat)
- ✅ Clean typography

## 📝 Writing Tips

### Frontmatter Options

```yaml
---
title: "Post Title"                    # Required
pub_date: "YYYY-MM-DD"                 # Required (affects URL)
description: "SEO description"         # Recommended for SEO
tags: tag1, tag2, tag3                 # Optional
featured_image: "/path/to/image.jpg"   # Optional (for social sharing)
---
```

### Markdown Features

- Headings (H1-H6)
- Lists (ordered/unordered)
- Code blocks with syntax highlighting
- Tables
- Blockquotes
- Images
- Links
- Bold/Italic text

## 🚀 Commands Reference

| Command | Description |
|---------|-------------|
| `make serve` | Build + start local server on port 8002 |
| `make build` | Build static site to `docs/` |
| `make clean` | Remove generated files |
| `uv run zvc build` | Direct build command |
| `uv run zvc clean` | Direct clean command |

---

**Built with ❤️ using zvc**
