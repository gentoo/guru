EAPI=7

DESCRIPTION="VTuber application made with Godot 3.4"
HOMEPAGE="https://github.com/virtual-puppet-project/vpuppr"

RESTRICT="strip"

PYTHON_COMPAT=( python3_{10..11} )
inherit desktop python-single-r1

IUSE="+osf-tracker ifm-tracker mouse-tracker vts-tracker meowface-tracker remote-control"
REQUIRED_USE="osf-tracker? ( ${PYTHON_REQUIRED_USE} )"

inherit git-r3
EGIT_REPO_URI="https://github.com/virtual-puppet-project/vpuppr.git"
EGIT_SUBMODULES=()
SRC_URI="
	https://github.com/virtual-puppet-project/godot-builds/releases/download/latest/Godot_v3.x-stable_linux_headless.64.tar.gz
		-> godot-vpuppr-headless.tar.gz
	https://github.com/virtual-puppet-project/godot-builds/releases/download/latest/Godot_v3.x-stable_linux_release.64.tar.gz
	-> godot-vpuppr-release-profile.tar.gz
	osf-tracker? (
		https://github.com/you-win/OpenSeeFace/releases/download/latest/OpenSeeFace_latest_linux.tar.gz
			-> OpenSeeFace_latest.tar.gz
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

src_unpack() {
	EGIT_SUBMODULES+=(
		$(usex remote-control '*remote-control-server'"")
		$(usex osf-tracker '*openseeface-tracker'"")
		$(usex ifm-tracker '*ifacialmocap-tracker'"")
		$(usex meowface-tracker '*meowface-tracker'"")
		$(usex vts-tracker '*vtube-studio-tracker'"")
	)
	default
	git-r3_src_unpack
}

src_prepare() {
	use osf-tracker && {
		mv "${WORKDIR}"/OpenSeeFace resources/extensions/openseeface-tracker/ || die
		touch resources/extensions/openseeface-tracker/OpenSeeFace/.gdignore || die
	}

	mkdir -p release_templates/ || die

	cp "${WORKDIR}"/Godot_v3.x-stable_linux_release.64 release_templates/ || die

	echo "resource_path = '/usr/share/vpuppr'" >> release_config.toml
	echo "version = '$(date '+%Y-%m-%d_%H-%M-%S')'" >> release_config.toml

	default
}

src_compile() {
	 "${WORKDIR}"/Godot_v3.x-stable_linux_headless.64 --verbose --export linux "export/${PN}"
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
