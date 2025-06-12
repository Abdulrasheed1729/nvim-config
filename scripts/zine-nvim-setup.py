#!/usr/bin/env python3
"""
Neovim query setup script for Ziggy, SuperHTML, and SuperMD
Clones repositories and copies query files to Neovim configuration
"""

import platform
import shutil
import subprocess
from pathlib import Path


def get_home_directory():
    """Get the user's home directory"""
    return Path.home()


def get_neovim_config_path():
    """Get the Neovim configuration path based on OS"""
    home_dir = get_home_directory()
    system = platform.system().lower()

    if system == "windows":
        return home_dir / "AppData" / "Local" / "nvim"
    else:
        return home_dir / ".config" / "neovim"


def clone_repository(repo_url, destination):
    """Clone a git repository"""
    print(f"Cloning {repo_url}...")
    try:
        result = subprocess.run(
            ["git", "clone", repo_url, str(destination)],
            capture_output=True,
            text=True,
            check=True,
        )
        print(f"Successfully cloned to {destination}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error cloning {repo_url}: {e.stderr}")
        return False
    except FileNotFoundError:
        print("Error: Git is not installed or not in PATH")
        return False


def copy_directory_contents(src, dst):
    """Copy contents of source directory to destination directory"""
    if not src.exists():
        print(f"Source directory doesn't exist: {src}")
        return False

    # Create destination directory if it doesn't exist
    dst.mkdir(parents=True, exist_ok=True)

    try:
        # Copy all files and subdirectories
        for item in src.iterdir():
            if item.is_file():
                shutil.copy2(item, dst / item.name)
            elif item.is_dir():
                shutil.copytree(item, dst / item.name, dirs_exist_ok=True)

        print(f"Copied {src} to {dst}")
        return True
    except Exception as e:
        print(f"Error copying {src} to {dst}: {e}")
        return False


def remove_directory(directory):
    """Remove a directory and all its contents"""
    try:
        shutil.rmtree(directory)
        print(f"Removed directory: {directory}")
    except Exception as e:
        print(f"Error removing directory {directory}: {e}")


def main():
    """Main function"""
    print("Neovim Query Setup")
    print("=" * 40)

    # Get temporary directory for cloning
    temp_dir = Path.home() / "temp_git_clones"
    temp_dir.mkdir(exist_ok=True)

    # Get Neovim config path
    nvim_config = get_neovim_config_path()
    queries_dir = nvim_config / "queries"

    print(f"Neovim config path: {nvim_config}")
    print(f"Queries directory: {queries_dir}")

    repositories = [
        "https://github.com/kristoff-it/ziggy",
        "https://github.com/kristoff-it/superhtml",
        "https://github.com/kristoff-it/supermd",
    ]

    cloned_dirs = []

    # Clone all repositories
    for repo_url in repositories:
        repo_name = repo_url.split("/")[-1]
        repo_path = temp_dir / repo_name

        if clone_repository(repo_url, repo_path):
            cloned_dirs.append(repo_path)
        else:
            print(f"Failed to clone {repo_url}, skipping...")

    # Copy query files if repositories were cloned successfully
    if cloned_dirs:
        print("\nCopying query files to Neovim config...")

        for repo_path in cloned_dirs:
            repo_name = repo_path.name

            if repo_name == "ziggy":
                # Copy ziggy/tree-sitter-ziggy/queries to ~/.config/neovim/queries/ziggy
                ziggy_queries = repo_path / "tree-sitter-ziggy" / "queries"
                ziggy_dest = queries_dir / "ziggy"
                copy_directory_contents(ziggy_queries, ziggy_dest)

                # Copy ziggy/tree-sitter-ziggy-schema/queries to ~/.config/neovim/queries/ziggy_schema
                ziggy_schema_queries = (
                    repo_path / "tree-sitter-ziggy-schema" / "queries"
                )
                ziggy_schema_dest = queries_dir / "ziggy_schema"
                copy_directory_contents(ziggy_schema_queries, ziggy_schema_dest)

            elif repo_name == "supermd":
                # Copy supermd/editors/neovim/queries/supermd to ~/.config/neovim/queries/supermd
                supermd_queries = (
                    repo_path / "editors" / "neovim" / "queries" / "supermd"
                )
                supermd_dest = queries_dir / "supermd"
                copy_directory_contents(supermd_queries, supermd_dest)

                # Copy supermd/editors/neovim/queries/supermd_inline to ~/.config/neovim/queries/supermd_inline
                supermd_inline_queries = (
                    repo_path / "editors" / "neovim" / "queries" / "supermd_inline"
                )
                supermd_inline_dest = queries_dir / "supermd_inline"
                copy_directory_contents(supermd_inline_queries, supermd_inline_dest)

            elif repo_name == "superhtml":
                # Copy superhtml/tree-sitter-superhtml/queries to ~/.config/neovim/queries/superhtml
                superhtml_queries = repo_path / "tree-sitter-superhtml" / "queries"
                superhtml_dest = queries_dir / "superhtml"
                copy_directory_contents(superhtml_queries, superhtml_dest)

    # Clean up cloned repositories
    print("\nCleaning up cloned repositories...")
    for repo_path in cloned_dirs:
        remove_directory(repo_path)

    # Remove temp directory if empty
    try:
        temp_dir.rmdir()
        print(f"Removed temporary directory: {temp_dir}")
    except:
        pass  # Directory might not be empty or might not exist

    print(f"\nNeovim queries setup complete!")
    print(f"Query files installed in: {queries_dir}")


if __name__ == "__main__":
    main()
