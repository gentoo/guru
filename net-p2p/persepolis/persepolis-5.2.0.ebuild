# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit meson python-single-r1 optfeature xdg

DESCRIPTION="Persepolis is a download manager written in Python."
HOMEPAGE="https://github.com/persepolisdm/persepolis"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/persepolisdm/persepolis.git"
else
	SRC_URI="https://github.com/persepolisdm/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-python/pyside:6
	dev-python/requests
	dev-python/setuptools
	dev-python/lxml
	dev-python/pysocks
	dev-python/beautifulsoup4
	dev-python/pyopenssl
	dev-python/certifi
	dev-python/sip
	dev-python/urllib3
	dev-python/setproctitle
	net-misc/aria2
	dev-python/dasbus
"
RDEPEND="${PYTHON_DEPS} ${DEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}/${PN}-5.2.0-fix-executable.patch"
)

src_configure() {
	python_setup
	meson_src_configure
}

src_install() {
	meson_src_install

	# removes packaged executable, and replaces with a python-exec version
	rm "${D}/usr/bin/persepolis" || die
	python_newscript "persepolis/${PN}.py" "${PN}"

	python_optimize
}

pkg_postinst() {
	optfeature "supporting youtube video downloads" net-misc/yt-dlp media-video/ffmpeg
	optfeature "uniform styling between persepolis and other applications" X11-themes/adwaita-qt

	xdg_pkg_postinst
}
