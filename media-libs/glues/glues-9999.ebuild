# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-6.0.0.ebuild,v 1.1 2013/07/01 10:19:17 hanno Exp $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="The OpenGL Utility Library (GLU|ES subset)"
HOMEPAGE="https://github.com/lunixbochs/glues"
EGIT_REPO_URI="https://github.com/ssvb/glues.git"
EGIT_BRANCH="glu"

SLOT="0"
LICENSE="SGI-B-2.0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/opengl
	media-libs/glumesa"
DEPEND="${RDEPEND}
	dev-util/cmake"

DOCS="README"

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_compile
	into "/usr"
	newlib.so "${CMAKE_BUILD_DIR}"/libGLU.so.1 libGLUES.so.1
	dosym "libGLUES.so.1" "/usr/$(get_libdir)/libGLUES.so"
}
