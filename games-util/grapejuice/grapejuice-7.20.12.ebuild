# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="A Wine+Roblox management application"
HOMEPAGE="https://gitlab.com/brinkervii/grapejuice"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/brinkervii/grapejuice.git"
	EGIT_BRANCH="staging"
else
	SRC_URI="https://gitlab.com/brinkervii/grapejuice/-/archive/v${PV}/grapejuice-v${PV}.tar.bz2"
	KEYWORDS="-* ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/gobject-introspection
		dev-python/click
		dev-python/packaging
		dev-python/pip
		dev-python/psutil
		dev-python/pydantic
		dev-python/pygobject
		dev-python/requests
		dev-python/setuptools
		dev-python/unidecode
		dev-python/wheel
		dev-util/desktop-file-utils
		dev-util/gtk-update-icon-cache
		dev-vcs/git
		sys-devel/gettext
		x11-apps/mesa-progs
		x11-libs/cairo
		x11-libs/gtk+
		x11-misc/shared-mime-info
		x11-misc/xdg-user-dirs
		x11-misc/xdg-utils"

RDEPEND="
		${DEPEND}
		virtual/wine"

src_unpack() {
	default
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_unpack
	else
		mv "${WORKDIR}/grapejuice-v${PV}" "${S}" || die
	fi
}

src_prepare() {
	default
	sed -i \
		-e 's/"--target"/"--no-build-isolation",\n\t\t"--target"/' \
		src/grapejuice_packaging/builders/linux_package_builder.py || die
}

src_compile() {
	cd "${S}"
	export PYTHONPATH="${S}/src"
	python3 -m grapejuice_packaging linux_package || die
}

src_install() {
	export PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
	tar -xf "${S}/dist/linux_package"/*.tar.gz -C "${D}" || die
	mv "${D}/usr/lib/python3/dist-packages" "${D}/usr/lib/python${PYTHON_VERSION}" || die
	rm -r "${D}/usr/lib/python3" || die
	default
}
