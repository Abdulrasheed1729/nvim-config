#!/usr/bin/env python3
"""
Cross-platform tool downloader for Ziggy and SuperHTML
Downloads and extracts tools to ~/dev/bin based on the operating system
"""

import os
import platform
import urllib.request
import zipfile
import tarfile
from pathlib import Path


def get_home_directory():
    """Get the user's home directory"""
    return Path.home()


def create_dev_bin_directory():
    """Create dev/bin directory in home folder if it doesn't exist"""
    home_dir = get_home_directory()
    dev_bin_path = home_dir / "dev" / "bin"
    dev_bin_path.mkdir(parents=True, exist_ok=True)
    return dev_bin_path


def download_file(url, destination):
    """Download a file from URL to destination"""
    print(f"Downloading {url}...")
    try:
        urllib.request.urlretrieve(url, destination)
        print(f"Downloaded to {destination}")
        return True
    except Exception as e:
        print(f"Error downloading {url}: {e}")
        return False


def extract_zip(zip_path, extract_to):
    """Extract a ZIP file"""
    print(f"Extracting {zip_path}...")
    try:
        with zipfile.ZipFile(zip_path, "r") as zip_ref:
            zip_ref.extractall(extract_to)
        print(f"Extracted to {extract_to}")
        return True
    except Exception as e:
        print(f"Error extracting {zip_path}: {e}")
        return False


def extract_tar_xz(tar_path, extract_to):
    """Extract a TAR.XZ file"""
    print(f"Extracting {tar_path}...")
    try:
        with tarfile.open(tar_path, "r:xz") as tar_ref:
            tar_ref.extractall(extract_to)
        print(f"Extracted to {extract_to}")
        return True
    except Exception as e:
        print(f"Error extracting {tar_path}: {e}")
        return False


def delete_file(file_path):
    """Delete a file"""
    try:
        os.remove(file_path)
        print(f"Deleted {file_path}")
    except Exception as e:
        print(f"Error deleting {file_path}: {e}")


def get_download_urls():
    """Get download URLs based on operating system"""
    system = platform.system().lower()

    urls = []

    if system == "windows":
        urls = [
            "https://github.com/kristoff-it/ziggy/releases/download/0.0.1/x86_64-windows.zip",
            "https://github.com/kristoff-it/superhtml/releases/download/v0.5.3/x86_64-windows.zip",
        ]
    elif system == "linux":
        urls = [
            "https://github.com/kristoff-it/ziggy/releases/download/0.0.1/x86_64-linux-musl.tar.xz",
            "https://github.com/kristoff-it/superhtml/releases/download/v0.5.3/x86_64-linux-musl.zip",
        ]
    else:
        print(f"Unsupported operating system: {system}")
        return []

    return urls


def main():
    """Main function"""
    print("Cross-platform Tool Downloader")
    print("=" * 40)

    # Detect operating system
    system = platform.system().lower()
    print(f"Detected OS: {system}")

    # Create dev/bin directory
    dev_bin_path = create_dev_bin_directory()
    print(f"Target directory: {dev_bin_path}")

    # Get URLs for current OS
    urls = get_download_urls()
    if not urls:
        return

    # Download and extract each file
    for url in urls:
        # Get filename from URL
        filename = url.split("/")[-1]
        file_path = dev_bin_path / filename

        # Download file
        success = download_file(url, file_path)
        if not success:
            continue

        # Extract based on file extension
        if filename.endswith(".zip"):
            extract_success = extract_zip(file_path, dev_bin_path)
        elif filename.endswith(".tar.xz"):
            extract_success = extract_tar_xz(file_path, dev_bin_path)
        else:
            print(f"Unknown file type: {filename}")
            extract_success = False

        # Delete the archive file after extraction
        if extract_success:
            delete_file(file_path)

        print("-" * 40)

    print("Download and extraction complete!")
    print(f"Tools installed in: {dev_bin_path}")


if __name__ == "__main__":
    main()
