# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit desktop python-single-r1 xdg optfeature

DESCRIPTION="Camera controls for Linux"
HOMEPAGE="https://github.com/soyersoyer/cameractrls"
SRC_URI="https://github.com/soyersoyer/cameractrls/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	gui-libs/gtk:4
	media-libs/libjpeg-turbo
	media-libs/libsdl2
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/desktop-file-utils"

src_prepare() {
	default

	desktop-file-edit \
		--set-key=Exec \
		--set-value=cameractrlsgtk4 \
		pkg/hu.irl.cameractrls.desktop || die
}

src_install() {
	local site_packages
	site_packages="$(python_get_sitedir)"

	exeinto "${site_packages}/CameraCtrls"
	doexe \
		cameractrls.py \
		cameractrlsd.py \
		cameractrlsgtk4.py \
		cameraptzgame.py \
		cameraptzmidi.py \
		cameraptzspnav.py \
		cameraview.py

	insinto "${site_packages}/CameraCtrls/images"
	doins pkg/hu.irl.cameractrls.svg

	dosym "${site_packages}/CameraCtrls/cameractrls.py" /usr/bin/cameractrls
	dosym "${site_packages}/CameraCtrls/cameractrlsd.py" /usr/bin/cameractrlsd
	dosym "${site_packages}/CameraCtrls/cameractrlsgtk4.py" /usr/bin/cameractrlsgtk4

	doicon -s scalable pkg/hu.irl.cameractrls.svg
	domenu pkg/hu.irl.cameractrls.desktop

	insinto /usr/share/metainfo
	doins pkg/hu.irl.cameractrls.metainfo.xml

	dodoc LICENSE README.md CHANGELOG.md
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature_header "'Start with Systemd'"
	optfeature "enable option in the gui" sys-apps/systemd
}

