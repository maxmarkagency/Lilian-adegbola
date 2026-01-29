#!/bin/bash

echo "🔧 Fixing build and deployment issues..."

# Step 1: Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf node_modules package-lock.json dist

# Step 2: Clear npm cache
echo "🗑️ Clearing npm cache..."
npm cache clean --force

# Step 3: Install dependencies with specific flags
echo "📦 Installing dependencies with network optimizations..."
npm install --no-audit --prefer-offline --legacy-peer-deps --timeout=60000

# Step 4: Build the project
echo "🔨 Building production version..."
npm run build

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    # Step 5: Create deployment package
    echo "📁 Creating deployment package..."
    cd dist
    zip -r ../lillian-website-deploy.zip .
    cd ..
    
    echo "✅ Build complete!"
    echo "📦 Deployment package created: lillian-website-deploy.zip"
    echo ""
    echo "Next steps:"
    echo "1. Login to your cPanel"
    echo "2. Go to File Manager"
    echo "3. Navigate to public_html"
    echo "4. Upload and extract lillian-website-deploy.zip"
    echo "5. Upload the .htaccess file to public_html"
    echo "6. Test your website!"
    echo ""
    echo "Admin login: Lilian.Adegbola / Adegbola@2025"
else
    echo "❌ Build failed! Please check the errors above."
    exit 1
fi