@echo off
echo 🚀 Starting build and deployment process...

REM Step 1: Install dependencies
echo 📦 Installing dependencies...
call npm install

REM Step 2: Build the project
echo 🔨 Building production version...
call npm run build

REM Check if build was successful
if %errorlevel% equ 0 (
    echo ✅ Build successful!
    
    REM Step 3: Create deployment info
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