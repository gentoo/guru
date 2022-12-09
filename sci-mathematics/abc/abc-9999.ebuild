EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="System for sequential logic synthesis and formal verification"
HOMEPAGE="https://people.eecs.berkeley.edu/~alanmi/abc/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/berkeley-abc/abc.git"
EGIT_BRANCH="master"


LICENSE="Berkeley-ABC"
SLOT="0"
KEYWORDS=""
PROPERTIES="live"
IUSE="+static-libs +readline +pthread"
REQUIRED_USE=""


BDEPEND="
  sys-devel/gcc[cxx]
"

RDEPEND="
  readline? ( sys-libs/readline:= )
"

DEPEND="
  ${RDEPEND}
"


src_compile() {
  local MAKE_ARGS=(
    CC=$(tc-getCC)
    CXX=$(tc-getCXX)
    AR=$(tc-getAR)
    LD=$(tc-getCXX)
    ABC_USE_PIC=1
    $(usex readline "" "ABC_USE_NO_READLINE=1")
    $(usex pthread "" "ABC_USE_NO_PTHREADS=1")
  )

  # We're explicitly building these targets sequentially,
  # because if the abc executable and libabc.a are linked in parallel,
  # we risk exhausting memory.
  emake "${MAKE_ARGS[@]}" abc
  emake "${MAKE_ARGS[@]}" libabc.so
  use static-libs && emake "${MAKE_ARGS[@]}" libabc.a
}


src_install() {
  dobin abc
  dolib.so libabc.so
  use static-libs && dolib.a libabc.a
}
