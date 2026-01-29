#!/bin/bash

# Build and Deploy Script for cPanel
echo "🚀 Starting build and deployment process..."

# Step 1: Install dependencies
echo "📦 Installing dependencies..."
npm install

# Step 2: Build the project (without linting to avoid errors)
echo "🔨 Building production version..."
npm run build

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    # Step 3: Create deployment package
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