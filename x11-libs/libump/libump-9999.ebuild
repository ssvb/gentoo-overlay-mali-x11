# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils git-2

EGIT_REPO_URI="git://github.com/linux-sunxi/libump.git"
EGIT_BRANCH="r3p0-04rel0"
EGIT_COMMIT="914c64ce07b30129c69030facacb52cd1e6197ef"
DESCRIPTION="Unified Memory Provider userspace code needed for xf86-video-mali"

KEYWORDS="~arm ~amd64 ~x86"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="x11-libs/libdri2"
DEPEND="${RDEPEND}"

src_configure() {
	sed -i s,-mthumb-interwork,,g Makefile
	sed -i s,-march=armv7-a,,g Makefile
}

src_install() {
	insinto /usr/include/ump
	doins include/ump/ump.h
	doins include/ump/ump_platform.h
	doins include/ump/ump_debug.h
	doins include/ump/ump_osu.h
	doins include/ump/ump_ref_drv.h
	doins include/ump/ump_uk_types.h

	insinto "/usr/$(get_libdir)"
	dolib.so libUMP.so
}
