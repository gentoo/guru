# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rakudo.eclass
# @MAINTAINER:
# amano.kenji <amano.kenji@proton.me>
# @BLURB: An eclass for raku modules

EXPORT_FUNCTIONS src_compile src_install src_test

# @ECLASS_VARIABLE: rakudo_test_deps
# @DESCRIPTION:
# Packages that shouldn't run tests with dev-raku/App-Prove6
# @INTERNAL
declare -A rakudo_test_deps
rakudo_test_deps[dev-raku/App-Prove6]=1
rakudo_test_deps[dev-raku/Getopt-Long]=1
rakudo_test_deps[dev-raku/TAP]=1

if [ ${rakudo_test_deps[${CATEGORY}/${PN}]} ]; then
	BDEPEND="dev-lang/rakudo:="
else
	BDEPEND="dev-lang/rakudo:=
		test? ( dev-raku/App-Prove6 )"
	IUSE="test"
	RESTRICT="!test? ( test )"
fi
RDEPEND="dev-lang/rakudo:="

# @FUNCTION: rakudo_symlink_bin
# @USAGE: <executable-in-/usr/share/perl6/vendor/bin>
# @DESCRIPTION:
# Make a symlink to /usr/share/perl6/vendor/bin/executable in /usr/bin
rakudo_symlink_bin() {
	dosym "/usr/share/perl6/vendor/bin/$1" "/usr/bin/$1" || die
}

rakudo_src_compile() {
	env RAKUDO_RERESOLVE_DEPENDENCIES=0 \
	/usr/share/perl6/core/tools/install-dist.raku --only-build --from=. \
	|| die
}

rakudo_src_install() {
	einstalldocs
	env RAKUDO_RERESOLVE_DEPENDENCIES=0 \
	/usr/share/perl6/core/tools/install-dist.raku \
	--to="${D}/usr/share/perl6/vendor" --for=vendor --from=. --build=False \
	|| die
}

rakudo_src_test() {
	[ ${rakudo_test_deps[${CATEGORY}/${PN}]} ] && return
	prove6 --lib t/ || die
}
