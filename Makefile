.PHONY: serve build clean new sitemap robots ads

serve: build
	@echo "🚀 Starting local server at http://localhost:8002"
	@cd docs && python -m http.server 8002

build:
	@echo "🔨 Building static site..."
	@uv run zvc build
	@echo "📝 Creating CNAME file..."
	@echo "thedelta.news" > docs/CNAME
	@echo "🖼️ Copying assets directory..."
	@cp -r themes/default/assets docs/assets
	@echo "📄 Copying static pages..."
	@cp themes/default/about.html docs/about.html
	@cp themes/default/editorial-policy.html docs/editorial-policy.html
	@cp themes/default/contact.html docs/contact.html
	@cp themes/default/advertise.html docs/advertise.html
	@echo "🗺️ Generating sitemap..."
	@make sitemap
	@echo "🤖 Creating robots.txt..."
	@make robots
	@echo "📢 Creating ads.txt..."
	@make ads
	@echo "✅ Build complete!"

clean:
	@echo "🧹 Cleaning generated files..."
	@uv run zvc clean
	@echo "✅ Clean complete!"

sitemap:
	@echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > docs/sitemap.xml
	@echo "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">" >> docs/sitemap.xml
	@echo "  <url>" >> docs/sitemap.xml
	@echo "    <loc>https://thedelta.news/</loc>" >> docs/sitemap.xml
	@echo "    <lastmod>$$(date -u +%Y-%m-%d)</lastmod>" >> docs/sitemap.xml
	@echo "    <changefreq>weekly</changefreq>" >> docs/sitemap.xml
	@echo "    <priority>1.0</priority>" >> docs/sitemap.xml
	@echo "  </url>" >> docs/sitemap.xml
	@echo "  <url>" >> docs/sitemap.xml
	@echo "    <loc>https://thedelta.news/about.html</loc>" >> docs/sitemap.xml
	@echo "    <lastmod>$$(date -u +%Y-%m-%d)</lastmod>" >> docs/sitemap.xml
	@echo "    <changefreq>monthly</changefreq>" >> docs/sitemap.xml
	@echo "    <priority>0.8</priority>" >> docs/sitemap.xml
	@echo "  </url>" >> docs/sitemap.xml
	@echo "  <url>" >> docs/sitemap.xml
	@echo "    <loc>https://thedelta.news/editorial-policy.html</loc>" >> docs/sitemap.xml
	@echo "    <lastmod>$$(date -u +%Y-%m-%d)</lastmod>" >> docs/sitemap.xml
	@echo "    <changefreq>monthly</changefreq>" >> docs/sitemap.xml
	@echo "    <priority>0.7</priority>" >> docs/sitemap.xml
	@echo "  </url>" >> docs/sitemap.xml
	@echo "  <url>" >> docs/sitemap.xml
	@echo "    <loc>https://thedelta.news/contact.html</loc>" >> docs/sitemap.xml
	@echo "    <lastmod>$$(date -u +%Y-%m-%d)</lastmod>" >> docs/sitemap.xml
	@echo "    <changefreq>monthly</changefreq>" >> docs/sitemap.xml
	@echo "    <priority>0.7</priority>" >> docs/sitemap.xml
	@echo "  </url>" >> docs/sitemap.xml
	@echo "  <url>" >> docs/sitemap.xml
	@echo "    <loc>https://thedelta.news/advertise.html</loc>" >> docs/sitemap.xml
	@echo "    <lastmod>$$(date -u +%Y-%m-%d)</lastmod>" >> docs/sitemap.xml
	@echo "    <changefreq>monthly</changefreq>" >> docs/sitemap.xml
	@echo "    <priority>0.6</priority>" >> docs/sitemap.xml
	@echo "  </url>" >> docs/sitemap.xml
	@for file in docs/2025/*/*/index.html; do \
		if [ -f "$$file" ]; then \
			date=$$(basename $$(dirname $$file)); \
			echo "  <url>" >> docs/sitemap.xml; \
			echo "    <loc>https://thedelta.news/$$(echo $$file | sed 's|docs/||' | sed 's|/index.html||')/</loc>" >> docs/sitemap.xml; \
			echo "    <lastmod>$$date</lastmod>" >> docs/sitemap.xml; \
			echo "    <changefreq>monthly</changefreq>" >> docs/sitemap.xml; \
			echo "    <priority>0.8</priority>" >> docs/sitemap.xml; \
			echo "  </url>" >> docs/sitemap.xml; \
		fi; \
	done
	@echo "</urlset>" >> docs/sitemap.xml

robots:
	@echo "User-agent: *" > docs/robots.txt
	@echo "Allow: /" >> docs/robots.txt
	@echo "Sitemap: https://thedelta.news/sitemap.xml" >> docs/robots.txt

ads:
	@echo "google.com, pub-8699046198561974, DIRECT, f08c47fec0942fa0" > docs/ads.txt

new:
	@if [ -z "$(TITLE)" ]; then \
		echo "❌ Error: TITLE is required. Usage: make new TITLE='Your Post Title'"; \
		exit 1; \
	fi
	@SLUG=$$(echo "$(TITLE)" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9가-힣]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$$//'); \
	DATE=$$(date +%Y-%m-%d); \
	DIR="contents/$$SLUG"; \
	FILE="$$DIR/$$SLUG.md"; \
	if [ -d "$$DIR" ]; then \
		echo "❌ Error: Directory '$$DIR' already exists"; \
		exit 1; \
	fi; \
	mkdir -p "$$DIR"; \
	echo "---" > "$$FILE"; \
	echo "title: $(TITLE)" >> "$$FILE"; \
	echo "pub_date: $$DATE" >> "$$FILE"; \
	echo "description: " >> "$$FILE"; \
	echo "tags: " >> "$$FILE"; \
	echo "featured_image: " >> "$$FILE"; \
	echo "---" >> "$$FILE"; \
	echo "" >> "$$FILE"; \
	echo "# $(TITLE)" >> "$$FILE"; \
	echo "" >> "$$FILE"; \
	echo "Write your content here..." >> "$$FILE"; \
	echo "" >> "$$FILE"; \
	echo "✅ Created new post:"; \
	echo "   📁 Directory: $$DIR"; \
	echo "   📄 File: $$FILE"; \
	echo ""; \
	echo "Next steps:"; \
	echo "   1. Edit the file: $$FILE"; \
	echo "   2. Run 'make build' to generate HTML"; \
	echo "   3. Run 'make serve' to preview"

