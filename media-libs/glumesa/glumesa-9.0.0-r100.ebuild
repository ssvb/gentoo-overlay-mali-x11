# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glu/glu-9.0.0.ebuild,v 1.15 2013/03/03 11:51:05 vapier Exp $

EAPI=4

EGIT_REPO_URI="git://anongit.freedesktop.org/mesa/glu"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
	EXPERIMENTAL="true"
fi

inherit autotools-utils ${GIT_ECLASS}

MY_P="glu-${PV}"

DESCRIPTION="The OpenGL Utility Library (Mesa implementation)"
HOMEPAGE="http://cgit.freedesktop.org/mesa/glu/"

if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/mesa/glu/${MY_P}.tar.bz2"
fi

LICENSE="SGI-B-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="multilib static-libs"

DEPEND="virtual/opengl"
RDEPEND="${DEPEND}
	!media-libs/glu
	>=media-libs/mesa-9"

S="${WORKDIR}/${MY_P}"
BUILD_DIR="${S}_build"

src_unpack() {
	default
	[[ $PV = 9999* ]] && git-2_src_unpack
}

src_prepare() {
	AUTOTOOLS_AUTORECONF=1 autotools-utils_src_prepare
}

src_configure() {
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
}

src_install() {
	insinto "/usr/$(get_libdir)/opengl/xorg-x11/lib"
	doins "${BUILD_DIR}"/.libs/libGLU.so*
	insinto "/usr/include/GL"
	doins "${S}/include/GL/glu.h"
	doins "${S}/include/GL/glu_mangle.h"
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${BUILD_DIR}/glu.pc"
}

pkg_postinst() {
	# Kick eselect to make sure that we get a symlink to libGLU.so
	"${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}

src_test() {
	:;
}
