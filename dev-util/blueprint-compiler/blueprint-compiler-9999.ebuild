# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit meson python-r1

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/jwestman/blueprint-compiler.git"
else
	SRC_URI="https://gitlab.gnome.org/jwestman/blueprint-compiler/-/archive/v${PV}/blueprint-compiler-v${PV}.tar.bz2"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Compiler for Blueprint, a markup language for GTK user interfaces"
HOMEPAGE="https://jwestman.pages.gitlab.gnome.org/blueprint-compiler/"

LICENSE="LGPL-3+"
SLOT="0"

IUSE="doc test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

BDEPEND="
	${PYTHON_DEPS}
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/furo[${PYTHON_USEDEP}]
	)
"

DEPEND="
	test? (
		gui-libs/gtk:4[introspection]
	)
"

RDEPEND="
	${PYTHON_DEPS}
"

src_configure() {
	local emesonargs=(
		$(meson_use doc docs)
	)
	python_foreach_impl meson_src_configure
}

src_compile() {
	python_foreach_impl meson_src_compile
	use doc && build_sphinx docs
}

src_test() {
	python_foreach_impl meson_src_test
}

src_install() {
	my_src_install() {
		local exe="${ED}/usr/bin/${PN}"

		# Meson installs a Python script at ${ED}/usr/bin/${PN}; on
		# Gentoo, the script should go into ${ED}/usr/lib/python-exec,
		# and ${ED}/usr/bin/${PN} should be a symbolic link to
		# ${ED}/usr/lib/python-exec/python-exec2.
		#
		# When multiple PYTHON_TARGETS are enabled, then after the
		# package has been installed for one Python implementation,
		# Meson will follow the ${ED}/usr/bin/${PN} symbolic link and
		# install the script at ${ED}/usr/lib/python-exec/python-exec2
		# for the remaining implementations, leading to file collision.
		if [[ -L "${exe}" ]]; then
			rm -v "${exe}" || die "Failed to remove symbolic link ${exe}"
		fi

		meson_src_install
		python_doscript "${exe}"
		python_optimize
	}

	python_foreach_impl my_src_install
}
