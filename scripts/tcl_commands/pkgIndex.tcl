# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Tcl package index file, version 1.1
# This file is generated by the "pkg_mkIndex" command
# and sourced either when an application starts up or
# by a "package unknown" script.  It invokes the
# "package ifneeded" command to set up package-related
# information so that packages will be loaded automatically
# in response to "package require" commands.  When this
# script is sourced, the variable $dir must contain the
# full path name of this file's directory.

package ifneeded openlane 0.9 [list source [file join $dir all.tcl]]\n[list source [file join $dir checkers.tcl]]\n[list source [file join $dir cts.tcl]]\n[list source [file join $dir floorplan.tcl]]\n[list source [file join $dir init_design.tcl]]\n[list source [file join $dir lvs.tcl]]\n[list source [file join $dir magic.tcl]]\n[list source [file join $dir placement.tcl]]\n[list source [file join $dir routing.tcl]]\n[list source [file join $dir synthesis.tcl]]\n[list source [file join $dir dft.tcl]]\n[list source [file join $dir klayout.tcl]]\n[list source [file join $dir cvc_rv.tcl]]\n[list source [file join $dir eco.tcl]]\n[list source [file join $dir sta.tcl]]
