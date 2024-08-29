# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="GNU Radio SRT implementation of a LoRa transceiver."
HOMEPAGE="https://github.com/tapparelj/gr-lora_sdr"
EGIT_REPO_URI="https://github.com/tapparelj/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="net-wireless/gnuradio"
RDEPEND="${DEPEND}"
# Could maybe use local mycmakeargs=(  -DENABLE_DOXYGEN=$(usex doc)  ); cmake_src_configure "${mycmakeargs[@]}" ; 
