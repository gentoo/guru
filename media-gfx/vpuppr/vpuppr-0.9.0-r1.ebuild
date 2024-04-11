EAPI=7

DESCRIPTION="VTuber application made with Godot 3.4"
HOMEPAGE="https://github.com/virtual-puppet-project/vpuppr"

RESTRICT="strip"

PYTHON_COMPAT=( python3_{10..12} )
inherit desktop xdg python-single-r1

IUSE="+osf-tracker ifm-tracker mouse-tracker vts-tracker meowface-tracker remote-control"
REQUIRED_USE="osf-tracker? ( ${PYTHON_REQUIRED_USE} )"

IFACIALMOCAP_COMMIT="8095807804b138a3236d9ce21e800e02fe44e53a"
MEOWFACE_COMMIT="790e4c7a5913184f71076e1c8606236b02ff1de8"
OPENSEEFACE_COMMIT="c1b8bc5fd0014abb1a059368d205740dd7f0f592"
RC_SERVER_COMMIT="e95d2bf0f29767f9be8461422c696d691ca3da48"
VTUBE_STUDIO_COMMIT="0cf3304723dbe0f71d5e12bff2b76d0ef0c22aea"

SRC_URI="
	https://github.com/virtual-puppet-project/vpuppr/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/virtual-puppet-project/godot-builds/releases/download/latest/Godot_v3.x-stable_linux_headless.64.tar.gz
		-> godot-vpuppr-headless-${P}.tar.gz
	https://github.com/virtual-puppet-project/godot-builds/releases/download/latest/Godot_v3.x-stable_linux_release.64.tar.gz
		-> godot-vpuppr-release-profile.${P}.tar.gz
	osf-tracker? (
		https://github.com/you-win/OpenSeeFace/releases/download/latest/OpenSeeFace_latest_linux.tar.gz
			-> OpenSeeFace_latest.tar.gz
		https://github.com/virtual-puppet-project/openseeface-tracker/archive/${OPENSEEFACE_COMMIT}.tar.gz
			-> openseeface-tracker-${OPENSEEFACE_COMMIT}.tar.gz
	)
	ifm-tracker? (
		https://github.com/virtual-puppet-project/ifacialmocap-tracker/archive/${IFACIALMOCAP_COMMIT}.tar.gz
			-> ifacialmocap-tracker-${IFACIALMOCAP_COMMIT}.tar.gz
	)
	vts-tracker? (
		https://github.com/virtual-puppet-project/vtube-studio-tracker/archive/${VTUBE_STUDIO_COMMIT}.tar.gz
			-> vtube-studio-tracker-${VTUBE_STUDIO_COMMIT}.tar.gz
	)
	meowface-tracker? (
		https://github.com/virtual-puppet-project/meowface-tracker/archive/${MEOWFACE_COMMIT}.tar.gz
			-> meowface-tracker-${MEOWFACE_COMMIT}.tar.gz
	)
	remote-control? (
		https://github.com/virtual-puppet-project/remote-control-server/archive/${RC_SERVER_COMMIT}.tar.gz
		-> remote-control-server-${RC_SERVER_COMMIT}.tar.gz
	)
"

LICENSE="MIT"
SLOT="0"
RDEPEND="
	osf-tracker? ( ${PYTHON_DEPS} )
"
BDEPEND="
	mouse-tracker? ( virtual/rust )
"

export EDITOR="${WORKDIR}/Godot_v3.x-stable_linux_headless.64"

src_prepare() {
	if use osf-tracker; then
		mv -T "${WORKDIR}"/openseeface-tracker-${OPENSEEFACE_COMMIT} \
			resources/extensions/openseeface-tracker || die
		mv "${WORKDIR}"/OpenSeeFace \
			resources/extensions/openseeface-tracker/ || die
		touch resources/extensions/openseeface-tracker/OpenSeeFace/.gdignore || die
	fi

	if use ifm-tracker; then
		mv -T "${WORKDIR}"/ifacialmocap-tracker-${IFACIALMOCAP_COMMIT} \
			resources/extensions/ifacialmocap-tracker || die
	fi

	if use vts-tracker; then
		mv -T "${WORKDIR}"/vtube-studio-tracker-${VTUBE_STUDIO_COMMIT} \
			resources/extensions/vtube-studio-tracker || die
	fi

	if use meowface-tracker; then
		mv -T "${WORKDIR}"/meowface-tracker-${MEOWFACE_COMMIT} \
			resources/extensions/meowface-tracker || die
	fi

	if use remote-control; then
		mv -T "${WORKDIR}"/remote-control-server-${RC_SERVER_COMMIT} \
			resources/extensions/remote-control-server || die
	fi

	mkdir -p release_templates/ || die

	cp "${WORKDIR}"/Godot_v3.x-stable_linux_release.64 release_templates/ || die

	echo "resource_path = '/usr/share/vpuppr'" >> release_config.toml
	echo "version = '$(date '+%Y-%m-%d_%H-%M-%S')'" >> release_config.toml

	default
}

src_compile() {
	 "${WORKDIR}"/Godot_v3.x-stable_linux_headless.64 \
		 --verbose --export linux "export/${PN}" || die
}

src_install() {
	local size
	dobin export/${PN}
	insinto usr/share/vpuppr
	doins -r resources/*
	make_desktop_entry vpuppr "Virtual Puppet Project" "vpuppr"\
		"Application" "Comment=Live VTuber model renderer, written in Godot"

	for size in 16 24 48 64 128 256; do
		newicon -s ${size} assets/icons/com.github.youwin.VPupPr-${size}.png vpuppr.png
	done
}
