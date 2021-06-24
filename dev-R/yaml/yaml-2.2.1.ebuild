# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Methods to Convert R Data to YAML and Back'
KEYWORDS="~amd64"
LICENSE='BSD'
#TODO: unbundle libyaml
#status: https://github.com/viking/r-yaml/issues/102
#https://github.com/viking/r-yaml/commit/b4579dc42cb3bc6c78fedc46b6fa2acfc79932f3
