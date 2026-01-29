@echo off
echo 🔧 Fixing build and deployment issues...

REM Step 1: Clean previous builds
echo 🧹 Cleaning previous builds...
if exist node_modules rmdir /s /q node_modules
if exist package-lock.json del package-lock.json
if exist dist rmdir /s /q dist

REM Step 2: Clear npm cache
echo 🗑️ Clearing npm cache...
call npm cache clean --force

REM Step 3: Install dependencies with specific flags
echo 📦 Installing dependencies with network optimizations...
call npm install --no-audit --prefer-offline --legacy-peer-deps --timeout=60000

REM Step 4: Build the project
echo 🔨 Building production version...
call npm run build

REM Check if build was successful
if %errorlevel% equ 0 (
    echo ✅ Build successful!
    
    echo 📁 Build complete!
    echo.
    echo Files ready for upload in the 'dist' folder:
    dir /b dist
    echo.
    echo Next steps:
    echo 1. Login to your cPanel
    echo 2. Go to File Manager
    echo 3. Navigate to public_html
    echo 4. Upload ALL files from the 'dist' folder to public_html
    echo 5. Upload the .htaccess file to public_html
    echo 6. Test your website!
    echo.
    echo Admin login: Lilian.Adegbola / Adegbola@2025
) else (
    echo ❌ Build failed! Please check the errors above.
    pause
    exit /b 1
)

pause