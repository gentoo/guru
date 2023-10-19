# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="lua"
PYTHON_COMPAT=( python3_{10..12} )
inherit mpv-plugin python-any-r1

DESCRIPTION="A Lua script to show preview thumbnails in mpv's OSC seekbar"
HOMEPAGE="https://github.com/marzzzello/mpv_thumbnail_script"

SRC_URI="https://github.com/marzzzello/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"

BDEPEND="
	${PYTHON_DEPS}
"

MPV_PLUGIN_FILES=(
	${PN}_client_osc.lua
	${PN}_server.lua
)

src_compile() {
	${EPYTHON} concat_files.py -r "cat_osc.json" || die
	${EPYTHON} concat_files.py -r "cat_server.json" || die
}

src_install() {
	mpv-plugin_src_install

	# add multiple threads
	THUMBNAIL_SERVER_THREADS="${THUMBNAIL_SERVER_THREADS:-1}"

	if [[ "${THUMBNAIL_SERVER_THREADS}" -gt 1 ]]; then
		i=1
		while [[ ${i} -lt ${THUMBNAIL_SERVER_THREADS} ]]; do
			dosym -r "/etc/mpv/scripts/mpv_thumbnail_script_server.lua" \
				"/etc/mpv/scripts/mpv_thumbnail_script_server_${i}.lua" || die
			(( i++ ))
		done
	fi
}

pkg_postinst(){
	mpv-plugin_pkg_postinst

	if [[ "${THUMBNAIL_SERVER_THREADS}" -gt 1 ]]; then
		elog "Created a total of ${THUMBNAIL_SERVER_THREADS} server threads. Setting this too high is not recommended"
	else
		elog "You can create multiple thumbnailing threads by setting THUMBNAIL_SERVER_THREADS"
	fi
}
