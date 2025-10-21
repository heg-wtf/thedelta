.PHONY: serve build clean new

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
	@echo "✅ Build complete!"

clean:
	@echo "🧹 Cleaning generated files..."
	@uv run zvc clean
	@echo "✅ Clean complete!"

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

