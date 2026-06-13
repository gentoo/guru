# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 xdg desktop

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
RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-python/pylint[${PYTHON_USEDEP}]
	)
"

RDEPEND="
	x11-libs/libnotify[introspection]
	dev-python/configobj[${PYTHON_USEDEP}]
	media-libs/gexiv2[introspection]
	dev-python/pycurl[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	x11-libs/pango[introspection]
	dev-python/pygobject:3[${PYTHON_USEDEP},cairo]
	dev-python/pillow[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf:2[introspection]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	net-libs/webkit-gtk[introspection]
	media-gfx/imagemagick
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"

BDEPEND="
	sys-devel/gettext
	test? (
		dev-python/pylint[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	# Remove upstream documentation to avoid incorrect installation paths
	rm -f README.md CONTRIBUTING.md AUTHORS || die
	rm -f data/ui/changes.txt || die

	# Variety requires this file; distutils-r1 does not generate it
	cat > variety_lib/variety_build_settings.py <<-EOF || die
__variety_data_directory__ = '/usr/share/variety'
EOF

	# Patch setup.py robustly so setuptools does not try to package
	# variety/data and trigger namespace/package QA warnings.
	python3 - <<'PY' || die
from pathlib import Path
p = Path("setup.py")
text = p.read_text()

replacements = {
    "package_data={'variety': ['data/**', 'locale/**']},":
        "package_data={},",
    'package_data={"variety": ["data/**", "locale/**"]},':
        'package_data={},',
    "include_package_data=True,":
        "include_package_data=False,",
}

for old, new in replacements.items():
    text = text.replace(old, new)

p.write_text(text)
PY

	# Silence deprecated PEP621 license table warning
	python3 - <<'PY' || die
from pathlib import Path
p = Path("pyproject.toml")
text = p.read_text()
text = text.replace(
    'license = { text = "GPL-3.0-only" }',
    'license = "GPL-3.0-only"'
)
p.write_text(text)
PY

	# Patch varietyconfig.py to make runtime data lookup use /usr/share/variety instead of package resources
	python3 - <<'PY' || die "Failed to patch varietyconfig.py"
import re
import sys
from pathlib import Path

p = Path("variety_lib/varietyconfig.py")
text = p.read_text()

text = text.replace('import importlib.resources', 'import os')

pattern = r"def get_data_file.*?return str\(.*?\)\)"

new_function = '''def get_data_file(*path_segments):
    """Get the full path to a data file."""
    return os.path.join("/usr/share/variety", *path_segments)'''

text, count = re.subn(pattern, new_function, text, flags=re.DOTALL)

if count == 0:
	sys.exit("Error: Could not locate get_data_file() function in varietyconfig.py")

p.write_text(text)
PY

	distutils-r1_python_prepare_all
}

python_test() {
	cd tests || die
	PYTHONPATH="${S}:${PYTHONPATH}" \
		"${EPYTHON}" -m unittest discover -p '[tT]est*.py' \
		|| die "Tests failed with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install

	# Install Variety shared data directory
	insinto /usr/share/variety
	doins -r data/config data/ui data/media data/scripts || die

	# Install desktop templates
	doins \
		data/variety-autostart.desktop.template \
		data/variety-profile.desktop.template || die

	# Compile and install translations from po/*.po
	local po lang
	for po in po/*.po; do
		[[ -f ${po} ]] || continue
		lang=${po##*/}
		lang=${lang%.po}

		dodir /usr/share/locale/${lang}/LC_MESSAGES || die
		msgfmt "${po}" -o "${ED}/usr/share/locale/${lang}/LC_MESSAGES/variety.mo" \
			|| die "msgfmt failed for ${po}"
	done

	# Install application icon
	insinto /usr/share/icons/hicolor/scalable/apps
	newins data/icons/scalable/apps/variety.svg variety.svg || die

	# Install real desktop entry from upstream template
	sed \
		-e 's/^_Name=/Name=/' \
		-e 's/^_Comment=/Comment=/' \
		variety.desktop > "${T}/variety.desktop" || die

	domenu "${T}/variety.desktop" || die
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] && ! has_version dev-libs/libayatana-appindicator; then
		elog "Variety has an optional dependency on dev-libs/libayatana-appindicator."
		elog "Without it, a classic tray icon will be used."
	fi

	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
