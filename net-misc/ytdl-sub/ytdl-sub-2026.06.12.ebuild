# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Automate downloading and metadata generation with YoutubeDL"
HOMEPAGE="https://github.com/jmbannon/ytdl-sub"
SRC_URI="
	https://github.com/jmbannon/ytdl-sub/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=net-misc/yt-dlp-2026.06.09[${PYTHON_USEDEP}]
	media-video/ffmpeg
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/mergedeep[${PYTHON_USEDEP}]
	dev-python/mediafile[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

src_prepare() {
	distutils-r1_src_prepare

	# upstream has hard-coded version strings in src/ytdl_sub/__init__.py
	# that get overwritten by the Makefile for releases. So we need to
	# recreate the same edits.
	sed -E -e "/^__(pypi|local)_version__/ s/= .*/= \"${PV}\"/" \
		-i src/ytdl_sub/__init__.py || die

}

# These deselected tests rely on the local ffmpeg producing
# byte-for-byte identical output as the ffmpeg version in upstream's CI
# running on ubuntu. We just skip these ones.
EPYTEST_DESELECT=(
	# from tests/integration (sans prebuilt_presets)
	"tests/integration/cli/test_dl.py::TestCliDl::test_cli_dl_command[False-True]"
	"tests/integration/plugins/test_chapters.py::TestChapters::test_chapters_from_comments[False]"
	"tests/integration/plugins/test_file_convert.py::TestFileConvert::test_file_convert_custom_args[False]"
	"tests/integration/plugins/test_output_options.py::TestOutputOptions::test_download_archive_migration"
	"tests/integration/plugins/test_output_options.py::TestOutputOptions::test_empty_info_json_and_thumb[False]"
	"tests/integration/plugins/test_output_options.py::TestOutputOptions::test_missing_thumbnail"
	"tests/integration/plugins/test_thumbnail_plugins.py::TestThumbnailPlugins::test_thumbnail[False-False]"
	"tests/integration/plugins/test_thumbnail_plugins.py::TestThumbnailPlugins::test_thumbnail[True-False]"
	# from tests/integration/prebuilt_presets
	"tests/integration/prebuilt_presets/test_music.py::TestPrebuiltMusicPresets::test_presets_run[YouTube Full Albums]"
	"tests/integration/prebuilt_presets/test_music_videos.py::TestPrebuiltMusicVideoPresets::test_presets_run"
	"tests/integration/prebuilt_presets/test_music_videos.py::TestPrebuiltMusicVideoPresetsWithCategories::test_presets_run"
	"tests/integration/prebuilt_presets/test_tv_show_by_date.py::TestPrebuiltTVShowPresets::test_tv_show_presets"
	"tests/integration/prebuilt_presets/test_tv_show_by_date.py::TestPrebuiltTVShowPresets::test_episode_ordering_presets"
	"tests/integration/prebuilt_presets/test_tv_show_collection.py::TestPrebuiltTvShowCollectionPresets::test_tv_show_collection_presets"
	"tests/integration/prebuilt_presets/test_tv_show_collection.py::TestPrebuiltTvShowCollectionPresets::test_episode_ordering_presets"
)

EPYTEST_PLUGINS=( pytest-rerunfailures )

distutils_enable_tests pytest

python_test() {
	# mimics upstream CI testing
	epytest --reruns 3 --reruns-delay 5 tests/unit
	epytest --reruns 3 --reruns-delay 5 tests/integration --ignore tests/integration/prebuilt_presets
	epytest --reruns 3 --reruns-delay 5 tests/integration/prebuilt_presets
	# skip tests/e2e - accesses the network
}
