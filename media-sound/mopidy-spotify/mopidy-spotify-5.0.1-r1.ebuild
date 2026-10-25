# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO="https://github.com/mopidy/mopidy-spotify"
PYTHON_COMPAT=( python3_{13..14} )
inherit distutils-r1 pypi

DESCRIPTION="Mopidy extension for playing music from Spotify"
HOMEPAGE="
	https://mopidy.com/ext/spotify/
	https://pypi.org/project/mopidy-spotify
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=media-plugins/gst-plugins-rs-1.26.11[spotify]
	media-sound/librespot[gstreamer]
	media-sound/mopidy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

EPYTEST_PLUGINS=( pytest pytest-cov responses cyclopts )

distutils_enable_tests pytest

src_prepare() {
	local class
	local classifiers=( "license =" "\"License ::" )
	for class in "${classifiers[@]}"; do
		sed -ie "/${class}/d" pyproject.toml \
			|| die "Failed to remove deprecated license classifier"
	done
	eapply_user
}
