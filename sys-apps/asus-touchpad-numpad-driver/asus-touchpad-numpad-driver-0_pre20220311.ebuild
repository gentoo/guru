# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit linux-info python-single-r1

DESCRIPTION="Feature-rich configurable Asus NumPad drivers"
HOMEPAGE="https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver"
else
	COMMIT="a2bada610ebb3fc002fceb53ddf93bc799241867"
	SRC_URI="https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-libs/libevdev
	sys-apps/i2c-tools
	$(python_gen_cond_dep '
		dev-python/libevdev[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/evdev[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

src_install() {
	exeinto /usr/libexec/${PN}
	doexe asus_touchpad.py
	insinto /usr/libexec/${PN}
	doins -r numpad_layouts

	python_fix_shebang "${ED}/usr/libexec/${PN}/asus_touchpad.py"

	python_optimize "${ED}/usr/libexec/${PN}"

	dosym -r /usr/libexec/${PN}/asus_touchpad.py /usr/bin/asus_touchpad
}
