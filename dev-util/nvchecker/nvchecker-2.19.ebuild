# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="New version checker for software releases"
HOMEPAGE="https://github.com/lilydjwg/nvchecker/"

SRC_URI="https://github.com/lilydjwg/nvchecker/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="aiohttp"

RDEPEND="
	dev-python/structlog[${PYTHON_USEDEP}]
	!aiohttp? (
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}]
	)
	aiohttp? (
		dev-python/aiohttp[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-httpbin[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# Needs network
	tests/test_android_sdk.py::test_android_addon
	tests/test_android_sdk.py::test_android_list
	tests/test_android_sdk.py::test_android_package
	tests/test_android_sdk.py::test_android_package_channel
	tests/test_android_sdk.py::test_android_package_os
	tests/test_android_sdk.py::test_android_package_os_missing
	tests/test_anitya.py::test_anitya
	tests/test_anitya.py::test_anitya_by_id
	tests/test_apt.py::test_apt
	tests/test_apt.py::test_apt_srcpkg
	tests/test_apt.py::test_apt_strip_release
	tests/test_archpkg.py::test_archpkg
	tests/test_archpkg.py::test_archpkg_provided
	tests/test_archpkg.py::test_archpkg_provided_strip
	tests/test_archpkg.py::test_archpkg_strip_release
	tests/test_aur.py::test_aur
	tests/test_aur.py::test_aur_strip_release
	tests/test_aur.py::test_aur_use_last_modified
	tests/test_bitbucket.py::test_bitbucket
	tests/test_bitbucket.py::test_bitbucket_max_tag
	tests/test_bitbucket.py::test_bitbucket_max_tag_with_ignored
	tests/test_bitbucket.py::test_bitbucket_sorted_tags
	tests/test_container.py::test_container
	tests/test_container.py::test_container_paging
	tests/test_container.py::test_container_with_tag
	tests/test_container.py::test_container_with_tag_and_multi_arch
	tests/test_container.py::test_container_with_tag_and_registry
	tests/test_cpan.py::test_cpan
	tests/test_cran.py::test_cran
	tests/test_cratesio.py::test_cratesio
	tests/test_cratesio.py::test_cratesio_list
	tests/test_cratesio.py::test_cratesio_skip_prerelease
	tests/test_cratesio.py::test_cratesio_use_prerelease
	tests/test_debianpkg.py::test_debianpkg
	tests/test_debianpkg.py::test_debianpkg_strip_release
	tests/test_debianpkg.py::test_debianpkg_suite
	tests/test_gems.py::test_gems
	tests/test_git.py::test_git
	tests/test_git.py::test_git_commit
	tests/test_git.py::test_git_commit_branch
	tests/test_gitea.py::test_gitea
	tests/test_gitea.py::test_gitea_latest_release
	tests/test_gitea.py::test_gitea_max_tag_with_include
	tests/test_gitlab.py::test_gitlab
	tests/test_gitlab.py::test_gitlab_blm
	tests/test_gitlab.py::test_gitlab_max_tag
	tests/test_gitlab.py::test_gitlab_max_tag_with_ignored
	tests/test_gitlab.py::test_gitlab_max_tag_with_include
	tests/test_go.py::test_go
	tests/test_hackage.py::test_hackage
	tests/test_htmlparser.py::test_rss_feed
	tests/test_htmlparser.py::test_xpath_element
	tests/test_htmlparser.py::test_xpath_ok
	tests/test_httpheader.py::test_redirection
	tests/test_jq.py::test_jq
	tests/test_jq.py::test_jq_filter
	tests/test_launchpad.py::test_launchpad
	tests/test_maven.py::test_maven
	tests/test_maven.py::test_maven_cannot_find_release
	tests/test_maven.py::test_maven_custom_repo
	tests/test_maven.py::test_maven_non_existing_group
	tests/test_npm.py::test_npm
	tests/test_opam.py::test_opam_coq
	tests/test_opam.py::test_opam_coq_trailing_slash
	tests/test_opam.py::test_opam_official
	tests/test_openvsx.py::test_openvsx
	tests/test_packagist.py::test_packagist
	tests/test_pagure.py::test_pagure
	tests/test_pagure.py::test_pagure_with_alternative_host
	tests/test_pagure.py::test_pagure_with_ignored
	tests/test_pypi.py::test_pypi
	tests/test_pypi.py::test_pypi_invalid_version
	tests/test_pypi.py::test_pypi_list
	tests/test_pypi.py::test_pypi_pre_release
	tests/test_pypi.py::test_pypi_release
	tests/test_pypi.py::test_pypi_yanked_version
	tests/test_repology.py::test_repology
	tests/test_repology.py::test_repology_bad_subrepo
	tests/test_repology.py::test_repology_subrepo
	tests/test_rpmrepo.py::test_rpmrepo_alma
	tests/test_rpmrepo.py::test_rpmrepo_fedora
	tests/test_snapcraft.py::test_snapcraft
	tests/test_snapcraft.py::test_snapcraft_non_existent_channel
	tests/test_snapcraft.py::test_snapcraft_non_existent_snap
	tests/test_sparkle.py::test_sparkle
	tests/test_ubuntupkg.py::test_ubuntupkg
	tests/test_ubuntupkg.py::test_ubuntupkg_strip_release
	tests/test_ubuntupkg.py::test_ubuntupkg_suite
	tests/test_ubuntupkg.py::test_ubuntupkg_suite_with_paging
	tests/test_vsmarketplace.py::test_vsmarketplace

	# Need missing python libraries
	tests/test_sortversion.py::test_awesomeversion  # awesomeversion
	tests/test_sortversion.py::test_vercmp  # pyalpm

	# "requires makepkg command"
	tests/test_alpm.py::test_alpm
	tests/test_alpm.py::test_alpm_missing_pkg
	tests/test_alpm.py::test_alpm_missing_provides
	tests/test_alpm.py::test_alpm_missing_repo
	tests/test_alpm.py::test_alpm_provided
	tests/test_alpm.py::test_alpm_provided_strip
	tests/test_alpm.py::test_alpm_strip

	# "requires pacman command"
	tests/test_alpmfiles.py::test_alpmfiles
	tests/test_alpmfiles.py::test_alpmfiles_strip
	tests/test_pacman.py::test_pacman
	tests/test_pacman.py::test_pacman_strip_release

	# "KEYFILE not set"
	tests/test_github.py::test_github
	tests/test_github.py::test_github_default_not_master
	tests/test_github.py::test_github_latest_release
	tests/test_github.py::test_github_latest_release_include_prereleases
	tests/test_github.py::test_github_latest_tag
	tests/test_github.py::test_github_max_release
	tests/test_github.py::test_github_max_release_with_ignored
	tests/test_github.py::test_github_max_release_with_include
	tests/test_github.py::test_github_max_tag
	tests/test_github.py::test_github_max_tag_with_ignored
	tests/test_github.py::test_github_max_tag_with_include
	tests/test_github.py::test_github_with_path
	tests/test_github.py::test_github_with_path_and_branch

	# "unconditional skip"
	tests/test_mercurial.py::test_mercurial
)
# NOTE: With all these skips, only 29 tests actually get ran...

distutils_enable_tests pytest
