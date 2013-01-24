# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2 toolchain-funcs versionator

DESCRIPTION="Xorg DDX driver for the devices based on Allwinner A10/A13 SoC"
SRC_URI="https://github.com/ssvb/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="arm amd64 x86"
IUSE="gles1 gles2"

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	gles1? ( x11-drivers/mali-drivers )
	gles2? ( x11-drivers/mali-drivers )
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xproto
	x11-libs/libump
"
