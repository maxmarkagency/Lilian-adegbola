# Complete Guide: Deploying Lillian Adegbola Website to cPanel

## Prerequisites
- cPanel hosting account with Node.js support (or static hosting)
- FTP/File Manager access
- Domain configured in cPanel

## Method 1: Static Build Deployment (Recommended for most shared hosting)

### Step 1: Build the Production Version
```bash
# In your local project directory
npm run build
```
This creates a `dist` folder with all static files.

### Step 2: Upload Files via cPanel File Manager

1. **Login to cPanel**
   - Go to your hosting provider's cPanel
   - Navigate to "File Manager"

2. **Navigate to public_html**
   - Go to `public_html` (or your domain's document root)
   - Delete any existing files if this is a new site

3. **Upload the dist folder contents**
   - Select all files from your `dist` folder (not the folder itself)
   - Upload them to `public_html`
   - Files should include: `index.html`, `assets/` folder, etc.

### Step 3: Configure Domain (if needed)
- Ensure your domain points to the correct folder
- In cPanel > Subdomains/Addon Domains, set document root to `public_html`

## Method 2: FTP Upload

### Step 1: Build the Project
```bash
npm run build
```

### Step 2: FTP Upload
```bash
# Using FileZilla or similar FTP client
# Connect to your hosting server
# Upload all contents of 'dist' folder to public_html
```

## Method 3: Node.js Hosting (if your host supports it)

### Step 1: Create Node.js App in cPanel
1. Go to cPanel > "Node.js Apps" or "Node.js Selector"
2. Create new Node.js application
3. Set Node.js version (16+ recommended)
4. Set startup file to a simple server

### Step 2: Upload Source Code
```bash
# Upload entire project to the app directory
# Install dependencies
npm install
npm run build
```

### Step 3: Create Server File
```javascript
// server.js
const express = require('express');
const path = require('path');
const app = express();

// Serve static files from dist directory
app.use(express.static(path.join(__dirname, 'dist')));

// Handle React Router (return index.html for all routes)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
```

## Database Setup (Supabase Integration)

### Your site uses Supabase, so no additional database setup needed in cPanel
- Supabase handles all database operations
- Your connection is already configured in `src/lib/supabase.js`
- Admin credentials: `Lilian.Adegbola` / `Adegbola@2025`

## SSL Certificate Setup

### Step 1: Enable SSL in cPanel
1. Go to cPanel > "SSL/TLS"
2. Enable "Let's Encrypt" SSL certificate
3. Force HTTPS redirects

### Step 2: Update Supabase Settings (if needed)
- Ensure your Supabase project allows your new domain
- Update CORS settings if necessary

## Environment Configuration

### Production Environment Variables
Your site doesn't use local environment variables, but ensure:
- Supabase URL and keys are correctly set in `src/lib/supabase.js`
- All API endpoints use HTTPS in production

## File Structure After Upload
```
public_html/
├── index.html
├── assets/
│   ├── index-[hash].js
│   ├── index-[hash].css
│   └── [other assets]
└── [other static files]
```

## Testing the Deployment

### Step 1: Basic Functionality
- Visit your domain
- Test navigation between pages
- Verify images and styles load correctly

### Step 2: Admin Panel Testing
- Go to `yourdomain.com/#/admin`
- Login with: `Lilian.Adegbola` / `Adegbola@2025`
- Test admin functionality

### Step 3: Database Connectivity
- Test contact form submission
- Verify blog posts display
- Check testimonials loading

## Common Issues and Solutions

### Issue 1: 404 Errors on Refresh
**Problem**: React Router routes return 404 when accessed directly
**Solution**: Add `.htaccess` file to public_html:

```apache
RewriteEngine On
RewriteBase /

# Handle Angular and React Router
RewriteRule ^(?!.*\.).*$ /index.html [L]

# Alternative for hash routing (if needed)
# RewriteCond %{REQUEST_FILENAME} !-f
# RewriteCond %{REQUEST_FILENAME} !-d
# RewriteRule . /index.html [L]
```

### Issue 2: Assets Not Loading
**Problem**: CSS/JS files return 404
**Solution**: Check file paths and ensure all files uploaded correctly

### Issue 3: Supabase Connection Issues
**Problem**: Database operations fail
**Solution**: 
- Verify Supabase credentials in `src/lib/supabase.js`
- Check browser console for CORS errors
- Ensure domain is whitelisted in Supabase project

## Performance Optimization

### Step 1: Enable Compression
Add to `.htaccess`:
```apache
# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>
```

### Step 2: Browser Caching
Add to `.htaccess`:
```apache
# Browser Caching
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType image/png "access plus 1 month"
    ExpiresByType image/jpg "access plus 1 month"
    ExpiresByType image/jpeg "access plus 1 month"
    ExpiresByType image/gif "access plus 1 month"
    ExpiresByType image/ico "access plus 1 month"
    ExpiresByType image/icon "access plus 1 month"
    ExpiresByType text/html "access plus 1 hour"
</IfModule>
```

## Security Considerations

### Step 1: Protect Admin Access
Create `.htaccess` in admin folder (if creating separate admin directory):
```apache
AuthType Basic
AuthName "Admin Area"
AuthUserFile /path/to/.htpasswd
Require valid-user
```

### Step 2: Hide Sensitive Files
Add to main `.htaccess`:
```apache
# Deny access to sensitive files
<Files ~ "^\.">
    Order allow,deny
    Deny from all
</Files>
```

## Monitoring and Maintenance

### Step 1: Set Up Monitoring
- Use cPanel's built-in analytics
- Monitor error logs regularly
- Set up uptime monitoring

### Step 2: Regular Updates
- Keep Supabase dependencies updated
- Monitor for security updates
- Regular backups of the site

## Backup Strategy

### Step 1: Automated Backups
- Enable cPanel's automatic backup feature
- Schedule regular database exports from Supabase

### Step 2: Manual Backups
- Download site files regularly
- Export Supabase data periodically
- Keep local copies of recent versions

## Quick Deployment Checklist

- [ ] Build production version (`npm run build`)
- [ ] Upload dist contents to public_html
- [ ] Configure SSL certificate
- [ ] Add .htaccess for routing
- [ ] Test all functionality
- [ ] Verify admin panel access
- [ ] Check Supabase connectivity
- [ ] Enable compression and caching
- [ ] Set up monitoring
- [ ] Configure backups

## Support and Troubleshooting

### Common Commands for Debugging
```bash
# Check build output
ls -la dist/

# Verify file permissions (if using SSH)
find public_html -type f -exec chmod 644 {} \;
find public_html -type d -exec chmod 755 {} \;
```

### Contact Points
- Your hosting provider's support for cPanel issues
- Supabase support for database connectivity
- Check browser console for JavaScript errors