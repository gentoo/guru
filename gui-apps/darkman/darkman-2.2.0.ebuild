# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module optfeature shell-completion systemd

DESCRIPTION="Framework for dark and light mode transitions"
HOMEPAGE="https://gitlab.com/WhyNotHugo/darkman"
SRC_URI="https://gitlab.com/WhyNotHugo/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
	https://github.com/pkulev/riru/releases/download/1.0.0/${PN}-v${PV}-vendor.tar.xz"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

BDEPEND="app-text/scdoc"

DOCS=( CHANGELOG.md README.md )

src_compile() {
	ego build -v -x -o ${PN} -ldflags="-X main.Version=${PV}" ./cmd/${PN}
	scdoc < ./${PN}.1.scd > ./${PN}.1 || die
	./darkman completion bash > darkman.bash || die
	./darkman completion fish > darkman.fish || die
	./darkman completion zsh > darkman.zsh || die
}

src_test() {
	ego test
}

src_install() {
	dobin ${PN}
	domenu darkman.desktop

	newbashcomp darkman.bash darkman
	dofishcomp darkman.fish
	newzshcomp darkman.zsh _darkman

	newinitd contrib/${PN}.openrc ${PN}
	systemd_douserunit contrib/${PN}.service
	doman ${PN}.1

	use examples && DOCS+=( examples/. )
	einstalldocs

	insinto /usr/share/dbus-1/services
	doins contrib/dbus/*

	insinto  /usr/share/xdg-desktop-portal/portals/
	doins contrib/portal/darkman.portal
}

pkg_postinst() {
	optfeature "determining the system's location" app-misc/geoclue

	ewarn "The scripts' layout was changed in darkman 2.2.0:"
	ewarn "- All scripts will get a mode (light or dark) as a first argument."
	ewarn "- Scripts should be placed in \${XDG_DATA_HOME}/darkman/ or in a darkman directory"
	ewarn "  in any of the paths in \${XDG_DATA_DIRS}. Old layout is still supported,"
	ewarn "  but consider migrating now."
	ewarn "You can look at the examples to merge your scripts using the mode value (make sure that"
	ewarn "examples USE flag is enabled)."
}
