# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit meson python-r1

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/jwestman/blueprint-compiler.git"
else
	# Upstream has not started to tag releases yet, so each keyworded (normal)
	# ebuild is to be based on a Git commit snapshot at this moment.
	# Live ebuild: Might be intentionally left blank
	# Normal ebuild: Fill in commit SHA-1 object name to this variable's value
	GIT_COMMIT="8ce748e62b6f7d10cf16a075a37c8f4b1f0267e4"
	KEYWORDS="~amd64"

	SRC_URI="https://gitlab.gnome.org/jwestman/blueprint-compiler/-/archive/${GIT_COMMIT}/blueprint-compiler-${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${GIT_COMMIT}"
fi

DESCRIPTION="Compiler for Blueprint, a markup language for GTK user interfaces"
HOMEPAGE="https://jwestman.pages.gitlab.gnome.org/blueprint-compiler/"

LICENSE="LGPL-3+"
SLOT="0"

IUSE="doc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	${PYTHON_DEPS}
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/furo[${PYTHON_USEDEP}]
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

		# Install Sphinx-generated documentation only once
		# since the documentation is supposed to be identical
		# between different Python implementations
		use doc && HTML_DOCS=( "${BUILD_DIR}/docs"/* )
	}

	python_foreach_impl my_src_install
	einstalldocs
}
