# Build

## Overview
This repository builds Vagrant Cloud images using the `build.sh` script. It supports filtering by distro, architecture, provider, and custom patch selection.

## Prerequisites
- Bash 5.0+
- `qemu-img` and `libguestfs-tools` or `docekr` installed
- `gh` authenticated (`gh auth login` or `GH_TOKEN` environment variable) with write access to the repository releases

## Quick Start
```bash
./build.sh
```

### Override Variables
Use `-e` to set a variable:
```bash
./build.sh -e filter_distro=centos -e filter_arch=arm64 -e preserve=true -e upload=false
```

Boxes are uploaded to one GitHub release per box, and the Vagrant box metadata is
published to the `gh-pages` branch (served by GitHub Pages). One-time setup of the
repository:

```bash
git switch --orphan gh-pages
touch .nojekyll
git add .nojekyll
git commit -m "Initialize GitHub Pages"
git push origin gh-pages
```

Then enable GitHub Pages from the `gh-pages` branch in the repository settings.

Set `GITHUB_REPOSITORY` (e.g. `myuser/vagrant-cloud-images`) to upload to a fork.

## Environment Variables
| Variable          | Description |
|-------------------|-------------|
| `filter_distro`   | Target distribution (e.g., `centos`, `ubuntu`) |
| `filter_release`  | Release channel (`trusty`, `18.04`, ...) |
| `filter_arch`     | Target architecture (`x86_64`, `arm64`) |
| `filter_provider` | Provider to target (`virtualbox`, `qemu`, `libvirt`) |
| `overwrite`       | Delete existing image before building (`true` / `false`) |
| `preserve`        | Keep intermediate artifacts after build (`true` / `false`) |
| `upload`          | Upload the built image to GitHub releases (`true` / `false`) |

## Troubleshooting
- `guestfish: command not found` – install the required packages (`libguestfs-tools`).
- `gh` not authenticated – run `gh auth login` or export `GH_TOKEN`.
- Image not uploading – check network connectivity and token scopes.

## Contributing
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/foo`).
3. Implement, test, and ensure lint and tests pass.
4. Open a Pull Request with a clear description.
