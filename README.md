# Panama

[![build-ublue](https://github.com/KE0VVT/panama/actions/workflows/build.yml/badge.svg)](https://github.com/KE0VVT/panama/actions/workflows/build.yml)

This is a constantly updating repository for creating [a native container image](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) designed to be mostly compliant with the [GNU Free System Distribution Guidelines](https://www.gnu.org/distros/free-system-distribution-guidelines.html). 

For more info, check out the [uBlue homepage](https://ublue.it/) and the [main uBlue repo](https://github.com/ublue-os/main/).

## Help Me Leave GitHub

I really do not like using GitHub for this, but the ["Making Your Own"](https://ublue.it/making-your-own/) documentation relies heavily on GitHub-specific workflows, and I am not experienced enough to know how to do this with [Codeberg](https://codeberg.org/) instead.

## Installation

> **Warning**
> This is an experimental feature and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ke0vvt/panama:latest
```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ke0vvt/panama:19830927
```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/ke0vvt/panama

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.
