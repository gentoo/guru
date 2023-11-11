### Contents

1. [Common Mistakes](#CommMist)
2. [Other Tips and Tricks](#tips)

## Common Mistakes <a name="CommMist"></a>

- #### Gentoo projects shouldn't be in the metadata files

Please don't put Gentoo projects (e.g. the proxy-maint project) in the metadata.xml files. Gentoo projects and developers are **not** responsible for the packages in GURU, as such they should not be listed in the metadata files.

> "New maintainers can only be added with their consent. In particular, it is not acceptable to add generic projects (such as the Python project) as package maintainers without the approval of their members or against their explicit policy."
> -- [Package Maintainers](https://devmanual.gentoo.org/general-concepts/package-maintainers/index.html#adding-and-removing-maintainers) section of the devmanual

When moving a package from a Pull Request in the [main Gentoo Repository](https://github.com/gentoo/gentoo) to GURU it is easy to forget to remove the [proxy-maint](https://wiki.gentoo.org/wiki/Project:Proxy_Maintainers) project from the metadata.xml file. The same is true for moving from GURU to a ::gentoo Pull Request, if you forget to add proxy-maint to the metadata file the `gentoo-repo-qa-bot` will complain.

- #### Use pkgcheck for double checking your ebuilds and use pkgdev for committing

`pkgcheck scan --net` (for QA run) and `pkgdev commit` (for committing) is strongly preferred over a direct `git commit -S`, because [pkgdev](https://blogs.gentoo.org/mgorny/2019/12/12/a-better-ebuild-workflow-with-pure-git-and-pkgcheck/) does additional checks and regenerates the manifest before committing. Sometimes committing with pkgdev is not possible (e.g. when committing eclasses or removing packages), in these cases there is no other possibility but to revert to `git commit -S`. In all other cases it is good practice to use pkgcheck and pkgdev.

In GURU we use ['thin manifests'](https://wiki.gentoo.org/wiki/Repository_format/package/Manifest#Thin_Manifest). Because this is not the default, manifest files should be regenerated when moving a package from another overlay that does not use thin manifests (including your [local overlay](https://wiki.gentoo.org/wiki/Custom_repository) unless it is also configured to use thin manifests).

- #### Quote your variables

String variables should be quoted (e.g. not `$P` or `${P}` but `"${P}"`). `pkgcheck scan` will warn you about any unquoted variables you might have forgotten about.

- #### Run tests if you enable them

You can enable `FEATURES="test"` for GURU in your [package.env](https://wiki.gentoo.org/wiki//etc/portage/package.env) or on the command line:

`sudo env FEATURES=test USE=test ebuild foo-1.0.ebuild test`

- #### No Symlinks in the repository

Please don't use symlinks in the repository (e.g. foobar-x.y.z.ebuild -> foobar-9999.ebuild), see [this forum posts](https://forums.gentoo.org/viewtopic-t-1079126-start-0.html) on why this is not a good idea.

- #### Undesirable/Deprecated dependencies

Sometimes a upstream lists dependencies which are considered deprecated. If possible, packages should **not** depend on these deprecated dependencies. Reasons a dependency might be deprecated is that it is too old, unmaintained, or the features it adds are not useful to Gentoo. You can find an overview of the currently deprecated dependencies and the reason they are deprecated in `$(portageq get_repo_path / gentoo)/profiles/package.deprecated`. `pkgcheck scan` will warn you if your package depends on a deprecated dependency.

For Python packages there are some additional (test) dependencies that are considered undesirable or not useful, but are not considered deprecated. You can find an overview of those [here](https://projects.gentoo.org/python/guide/distutils.html#enabling-tests) and in the list below:
```
dev-python/black
dev-python/check-manifest
dev-python/coverage
dev-python/docutils
dev-python/flake8
dev-python/isort
dev-python/mypy
dev-python/multilint
dev-python/pep8
dev-python/pycodestyle
dev-python/pytest-cov
dev-python/pytest-runner
dev-python/readme_renderer
dev-python/tox
dev-python/twine
```

- #### Licenses of bundled libraries

Some packages include files that are licensed under a different license then the rest of the package. In this case all the licenses should be specified in the LICENSE variable. This is very often the case for packages written in Rust or Go.

Rust and Go packages automagically collect all dependencies. The licenses of the things that are statically linked in these packages should be checked *manually* with `dev-util/cargo-license` and `dev-go/lichen`.


## Other Tips and Tricks <a name="tips"></a>

- #### Don't use `EGO_SUM`

This method of declaring Go module dependencies is deprecated. Please consider either hosting a dependency tarball somewhere (you can find out how to generate it in [go-module.eclass(5)](https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html)) or improving upstream release CI scripts (example: [noborus/ov#196](https://github.com/noborus/ov/pull/196/files)).

- #### Use the cmake eclass instead of the cmake-utils eclass

The [cmake-utils eclass](https://devmanual.gentoo.org/eclass-reference/cmake-utils.eclass/index.html) will be deprecated in favour of the [cmake eclass](https://devmanual.gentoo.org/eclass-reference/cmake.eclass/index.html). To make your ebuilds more future proof, you might want to use the cmake eclass instead. These eclasses are functionally equivalent, so replacing references to `cmake-utils_....` with `cmake_....` should just work.

- #### Use the xdg eclass instead of the xdg-utils eclass

The xdg eclass will automatically export the correct functions to the `src_prepare`, `pkg_preinst`, `pkg_postinst` and `pkg_postrm` phases. This means that *often* (but not always) you can save a few lines by using the [xdg](https://devmanual.gentoo.org/eclass-reference/xdg.eclass/index.html) eclass instead of the [xdg-utils](https://devmanual.gentoo.org/eclass-reference/xdg-utils.eclass/index.html) eclass. Please note that if you are using another eclass that exports to the `src_prepare` phase, the xdg eclass **will** overwrite it if it is inherited after that eclass. To fix this, you can inherit the xdg eclass *before* the other eclass.

- #### Use the latest EAPI whenever possible

Since the packages in GURU are all 'new packages' (not in ::gentoo). It is good practice to use the latest [EAPI](https://devmanual.gentoo.org/ebuild-writing/eapi/index.html) (8 at the moment), this makes your ebuilds more future proof.

- #### Establish your package testing workflow

There are [make.conf flags](https://wiki.gentoo.org/wiki/Package_testing#make.conf_.26_test.conf) you might want to set to enable more QA checks.

The [app-portage/iwdevtools](https://github.com/ionenwks/iwdevtools) package contains scripts that help with ebuild development: finding incorrect dependencies, detectng [ABI changes](https://devmanual.gentoo.org/general-concepts/slotting/index.html#abi-breakage) etc.

- #### Tests and documentation for Python packages

Many Python packages have tests and documentation. Unlike some other eclasses the [distutils-r1 eclass](https://devmanual.gentoo.org/eclass-reference/distutils-r1.eclass/index.html) does not enable support for these tests automatically. This is because there are multiple test runners available for Python. To enable tests for your Python ebuilds, use the `distutils_enable_tests <test-runner>` function. Similarly, support for documentation building with Sphinx can be added with the `distutils_enable_sphinx <subdir> [--no-autodoc | <plugin-pkgs>...]` function. Please note that these functions already append to IUSE and RESTRICT, so there is no need to specify this manually. 

See the [dev manual](https://devmanual.gentoo.org/eclass-reference/distutils-r1.eclass/index.html) and the [Gentoo Python Guide](https://projects.gentoo.org/python/guide/distutils.html) for more information.

- #### Prefer the PEP 517 mode for `distutils-r1` packages

If you are writing a new ebuild or doing a version bump for a project that has `pyproject.toml` file, consider switching to [the PEP 517 mode](https://projects.gentoo.org/python/guide/distutils.html#the-pep-517-and-legacy-modes).

- #### Avoid introducing USE flags for small files and optional runtime dependencies.

Installation of small files, like documentation, completions, man pages, etc, does not have to be toggle-able with an USE flag. Instead, just install these files unconditionally. This avoids unnecessary recompilations when an user forgot to enable a flag that installs a small file ([PG 0301](https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0301)).

The same holds for optional runtime dependencies ([PG 0001](https://projects.gentoo.org/qa/policy-guide/dependencies.html#pg0001)). It is not necessary to introduce a USE flag, that does not alter the compiled binary and just pulls in an extra optional runtime dependency. Instead, you can notify the user of these optional runtime dependencies with the `optfeature` function from the [optfeature](https://devmanual.gentoo.org/eclass-reference/optfeature.eclass/) eclass (early from currently deprecated [eutils](https://devmanual.gentoo.org/eclass-reference/eutils.eclass/) eclass). If, for whatever reason, it is still desired to introduce an USE flag for optional runtime dependencies, one can still use the `optfeature` function as well to allow the user to choose to avoid recompiling a package.

- #### Clean your patches

See the [dev manual](https://devmanual.gentoo.org/ebuild-writing/misc-files/patches/#clean-patch-howto) for a guide on how to write clean patches

- #### Avoid colon as a sed delimiter

As seen in https://bugs.gentoo.org/685160 colon as a sed delimiter can break \*FLAGS. You must not use it to modify \*FLAGS, better if you avoid using it completely.
