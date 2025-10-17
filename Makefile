.PHONY: serve build clean

serve: build
	@echo "🚀 Starting local server at http://localhost:8002"
	@cd docs && python -m http.server 8002

build:
	@echo "🔨 Building static site..."
	@uv run zvc build
	@echo "✅ Build complete!"

clean:
	@echo "🧹 Cleaning generated files..."
	@uv run zvc clean
	@echo "✅ Clean complete!"

