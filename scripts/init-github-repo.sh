#!/bin/bash

# Script to initialize a GitHub repository for Vivaah Weddings website
# Usage: ./init-github-repo.sh <github-username> <repository-name>

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Check if arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: ./init-github-repo.sh <github-username> <repository-name>"
    echo "Example: ./init-github-repo.sh johndoe vivah-la-vidaz-website"
    exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME=$2
GITHUB_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

echo "Initializing Git repository for Vivaah Weddings website..."

# Initialize git repository if not already initialized
if [ ! -d .git ]; then
    git init
    echo "Git repository initialized."
else
    echo "Git repository already exists."
fi

# Configure git if needed
if [ -z "$(git config user.name)" ]; then
    echo "Please enter your name for Git commits:"
    read GIT_NAME
    git config user.name "$GIT_NAME"
fi

if [ -z "$(git config user.email)" ]; then
    echo "Please enter your email for Git commits:"
    read GIT_EMAIL
    git config user.email "$GIT_EMAIL"
fi

# Add all files
echo "Adding files to Git..."
git add .

# Commit changes
echo "Committing files..."
git commit -m "Initial commit for Vivaah Weddings wedding planning website"

# Rename master branch to main if needed
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "master" ]; then
    echo "Renaming master branch to main..."
    git branch -M main
fi

# Add remote origin
echo "Adding remote origin: $GITHUB_URL"
git remote add origin $GITHUB_URL

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

echo "Done! Your Vivaah Weddings website has been pushed to GitHub at: $GITHUB_URL"
echo "Next steps:"
echo "1. Set up branch protection rules"
echo "2. Invite collaborators"
echo "3. Configure GitHub Pages (if desired)"
echo "4. Set up GitHub Actions for CI/CD"

exit 0
