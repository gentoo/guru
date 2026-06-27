# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit desktop distutils-r1 optfeature xdg

MY_PV="0.9.0"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Wallpaper downloader and manager for Linux systems"
HOMEPAGE="https://github.com/varietywalls/variety"
SRC_URI="https://github.com/varietywalls/variety/archive/refs/tags/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"
#RESTRICT="!test? ( test )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/configobj[${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP},cairo]
		dev-python/requests[${PYTHON_USEDEP}]
	')

	media-gfx/imagemagick
	media-libs/gexiv2[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
"
# Trim RDEPEND from legacy versions
# net-libs/webkit-gtk[introspection]
# x11-libs/gdk-pixbuf:2[introspection]
# x11-libs/pango[introspection]

BDEPEND="
	sys-devel/gettext
	test? (
		$(python_gen_cond_dep '
			dev-python/pylint[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_tests unittest

python_test() {
	eunittest -s tests -p '[tT]est*.py'
}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	# cleanup upstream GitHub artifacts to avoid incorrect installation paths
	rm -f "${S}"/README.md "${S}"/CONTRIBUTING.md "${S}"/AUTHORS || die
	rm -f "${S}"/data/ui/changes.txt || die

	# variety requires this file; distutils-r1 does not generate it
	cat > variety_lib/variety_build_settings.py <<-EOF || die
__variety_data_directory__ = '/usr/share/variety'
EOF

	# patch setup.py robustly so setuptools does not try to package
	# variety/data and trigger namespace/package QA warnings.
	sed -i -e '/package_data={/,/}/ { /package_data={/!d; s/$/},/ }' \
		-e 's/include_package_data=True,/include_package_data=False,/g' "${S}"/setup.py || die

	# silence deprecated PEP621 license table warning
	sed -i -e 's/license = { text = "GPL-3.0-only" }/license = "GPL-3.0-only"/' "${S}"/pyproject.toml || die

	# patch varietyconfig.py to make runtime data lookup use /usr/share/variety instead of package resources
	sed -i -e 's@import importlib\.resources@import os@' -e '/pkg_files_root = importlib/,/return str(/ {
		/pkg_files_root = importlib/d
		s@return str(.*@return os.path.join("/usr/share/variety", *path_segments)@
	}' "${S}"/variety_lib/varietyconfig.py || die

	# make real desktop entry from upstream template
	sed -i -e 's/^_Name=/Name=/' -e 's/^_Comment=/Comment=/' "${S}"/variety.desktop || die

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	# install Variety shared data directory
	insinto /usr/share/variety
	doins -r "${S}"/data/config "${S}"/data/ui "${S}"/data/media "${S}"/data/scripts

	# install desktop templates
	doins "${S}"/data/variety-autostart.desktop.template
	doins "${S}"/data/variety-profile.desktop.template

	# compile and install translations from po/*.po
	local po lang
	for po in po/*.po; do
		[[ -f ${po} ]] || continue
		lang=${po##*/}
		lang=${lang%.po}

		dodir /usr/share/locale/${lang}/LC_MESSAGES || die
		msgfmt "${po}" -o "${ED}/usr/share/locale/${lang}/LC_MESSAGES/variety.mo" || die "msgfmt failed for ${po}"
	done

	# install application icon
	doicon -s scalable "${S}"/data/icons/scalable/apps/variety.svg

	# install desktop entry
	domenu "${S}"/variety.desktop
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "displaying systray icon, without it, a classic tray icon will be used" dev-libs/libayatana-appindicator
}

pkg_postrm() {
	xdg_pkg_postrm
}
