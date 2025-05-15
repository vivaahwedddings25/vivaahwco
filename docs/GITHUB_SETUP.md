# GitHub Repository Setup Guide

This document provides instructions for setting up a GitHub repository for the Vivaah Weddings wedding planning website and establishing a workflow for future development.

## Initial Repository Setup

### Creating a New GitHub Repository

1. **Log in to GitHub**
   - Go to [GitHub](https://github.com) and log in to your account

2. **Create a New Repository**
   - Click the "+" icon in the top-right corner
   - Select "New repository"
   - Enter repository name: `vivah-la-vidaz-website`
   - Add a description: "Wedding planning website for Vivaah Weddings"
   - Choose repository visibility (Public or Private)
   - Initialize with a README (optional, since we already have one)
   - Click "Create repository"

### Setting Up Your Local Repository

1. **Clone the Repository** (if you created it on GitHub first)
   ```bash
   git clone https://github.com/yourusername/vivah-la-vidaz-website.git
   cd vivah-la-vidaz-website
   ```

   **OR**

   **Initialize a Local Repository** (if starting from local files)
   ```bash
   cd /path/to/vivah-la-vidaz-website
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/yourusername/vivah-la-vidaz-website.git
   git push -u origin main
   ```

2. **Add .gitignore File**
   Create a `.gitignore` file to exclude unnecessary files:
   ```
   # OS files
   .DS_Store
   Thumbs.db

   # Editor directories and files
   .idea/
   .vscode/
   *.sublime-project
   *.sublime-workspace

   # Logs
   logs
   *.log
   npm-debug.log*

   # Dependency directories
   node_modules/
   vendor/

   # Environment variables
   .env
   .env.local
   .env.development.local
   .env.test.local
   .env.production.local

   # Build directories
   /dist
   /build
   ```

3. **Add License File** (if needed)
   - Consider adding a LICENSE file to specify how others can use your code
   - Common options include MIT, Apache 2.0, or proprietary licenses

## Initial Commit and Push

### Preparing Your Files

1. **Organize Your Files**
   - Ensure all files are in their proper directories
   - Check that no sensitive information is included

2. **Add Files to Git**
   ```bash
   git add .
   ```

3. **Commit Your Changes**
   ```bash
   git commit -m "Initial website setup with home, services, gallery, about, and contact pages"
   ```

4. **Push to GitHub**
   ```bash
   git push -u origin main
   ```

## Branch Strategy

### Main Branches

- **main**: Production-ready code
- **development**: Integration branch for features before merging to main

### Feature Branches

For each new feature or significant change:

1. **Create a Feature Branch**
   ```bash
   git checkout development
   git pull
   git checkout -b feature/feature-name
   ```

2. **Work on Your Feature**
   Make changes, commit frequently with descriptive messages

3. **Push Feature Branch to GitHub**
   ```bash
   git push -u origin feature/feature-name
   ```

4. **Create a Pull Request**
   - Go to GitHub repository
   - Click "Pull requests" > "New pull request"
   - Set base branch to `development` and compare branch to your feature branch
   - Add description and request review

5. **Merge to Development**
   - After review and approval, merge the pull request
   - Delete the feature branch when no longer needed

### Release Process

1. **Create Release Branch**
   ```bash
   git checkout development
   git pull
   git checkout -b release/v1.0.0
   ```

2. **Test and Fix**
   - Perform final testing
   - Fix any bugs directly in the release branch

3. **Merge to Main**
   - Create a pull request from release branch to main
   - After approval, merge to main

4. **Tag the Release**
   ```bash
   git checkout main
   git pull
   git tag -a v1.0.0 -m "Version 1.0.0"
   git push origin v1.0.0
   ```

5. **Merge Back to Development**
   - Create a pull request from main to development
   - Merge to ensure bug fixes are in the development branch

## GitHub Repository Settings

### Branch Protection

1. Go to repository Settings > Branches
2. Add rule for `main` branch:
   - Require pull request reviews before merging
   - Require status checks to pass before merging
   - Include administrators in these restrictions

### Collaborators

1. Go to Settings > Manage access
2. Click "Invite a collaborator"
3. Enter GitHub username or email
4. Set appropriate permissions

### GitHub Pages (Optional)

If you want to use GitHub Pages for hosting:

1. Go to Settings > Pages
2. Select source branch (usually `main`)
3. Choose folder (usually `/` or `/docs`)
4. Click "Save"
5. Configure custom domain (if available)

## GitHub Actions (CI/CD)

### Basic Workflow for Static Site

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy Website

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      # Add linting or testing steps here if needed
      
      # Example deployment to GitHub Pages
      - name: Deploy to GitHub Pages
        uses: JamesIves/github-pages-deploy-action@4.1.4
        with:
          branch: gh-pages
          folder: .
```

### Advanced Workflow (For Future Development)

For the client portal, you might need more complex workflows:

```yaml
name: Build and Test

on:
  push:
    branches: [ main, development ]
  pull_request:
    branches: [ main, development ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run linting
        run: npm run lint
        
      - name: Run tests
        run: npm test
        
      - name: Build
        run: npm run build
```

## Best Practices for Collaboration

### Commit Messages

Follow a consistent format for commit messages:

```
type: Subject line (50 chars max)

Body of the commit message explaining what and why (not how).
Wrap at 72 characters.
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting, missing semicolons, etc.
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `test`: Adding tests
- `chore`: Maintenance tasks

### Pull Requests

- Create focused pull requests that address a single concern
- Provide clear descriptions of changes
- Reference related issues using #issue-number
- Request reviews from appropriate team members
- Respond to feedback promptly

### Code Reviews

- Be respectful and constructive
- Focus on code, not the author
- Explain reasoning behind suggestions
- Approve only when all concerns are addressed

## Troubleshooting Common Issues

### Authentication Problems

If you encounter authentication issues:

1. **Check your credentials**
   ```bash
   git config --global user.name
   git config --global user.email
   ```

2. **Use SSH instead of HTTPS**
   ```bash
   git remote set-url origin git@github.com:yourusername/vivah-la-vidaz-website.git
   ```

3. **Use GitHub CLI or credential manager**
   ```bash
   # Install GitHub CLI
   brew install gh  # macOS
   gh auth login    # Follow prompts
   ```

### Merge Conflicts

When encountering merge conflicts:

1. **Pull latest changes**
   ```bash
   git pull origin development
   ```

2. **Resolve conflicts**
   - Open conflicted files and resolve differences
   - Look for markers like `<<<<<<< HEAD`, `=======`, and `>>>>>>> branch-name`

3. **Complete the merge**
   ```bash
   git add .
   git commit -m "Resolve merge conflicts"
   ```

## Additional Resources

- [GitHub Documentation](https://docs.github.com)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [GitHub Flow Guide](https://guides.github.com/introduction/flow/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Next Steps

After setting up your GitHub repository:

1. Invite team members as collaborators
2. Set up branch protection rules
3. Configure GitHub Actions for CI/CD
4. Consider integrating with project management tools (GitHub Projects, Jira, etc.)
5. Establish a regular code review schedule
