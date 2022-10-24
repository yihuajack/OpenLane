# Copyright 2022 Rameen Anwar
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
proc run_dft {args} {
    if { $::env(DFT_ENABLE) } {
        increment_index
    }

    if { ! [info exists ::env(RESET_PORT) ] && $::env(DFT_ENABLE) } {
        if { ! [info exists ::env(CLOCK_PORT) ] } {
            puts_info "::env(CLOCK_PORT) is not set"
        }
        puts_info "::env(RESET_PORT) is not set"
        puts_warn "Skipping DFT"
        set ::env(DFT_ENABLE) 0
    }

    if { $::env(DFT_ENABLE) } {
        fault_chain \
            -verilog $::env(synthesis_results)/$::env(DESIGN_NAME).v \
            -liberty $::env(LIB_SYNTH) \
            -clock $::env(CLOCK_PORT) \
            -reset $::env(RESET_PORT) \
            -output $::env(synthesis_results)/$::env(DESIGN_NAME).v

        increment_index

        fault_tap \
            -verilog $::env(synthesis_results)/$::env(DESIGN_NAME).v \
            -liberty $::env(LIB_SYNTH) \
            -clock $::env(CLOCK_PORT) \
            -reset $::env(RESET_PORT) \
            -output $::env(synthesis_results)/$::env(DESIGN_NAME).v
    }

}


proc fault_chain {args} {
    puts_info "Running Scan Chain Insertion..."
    set options {
        {-verilog required}
        {-liberty required}
        {-clock required}
        {-reset required}
        {-output required}
    }
    parse_key_args "fault_chain" args values $options
    set tmp $::env(synthesis_tmpfiles)/$::env(DESIGN_NAME).v
    file copy -force $values(-verilog) $tmp

    try_catch $::env(DFT_BIN) chain \
        --liberty $values(-liberty) \
        --clock $values(-clock) \
        --reset $values(-reset) \
        --output $values(-output) \
        $values(-verilog)
}


proc fault_tap {args} {
    puts_info "Running JTAG Interface Insertion..."
    set options {
        {-verilog required}
        {-liberty required}
        {-clock required}
        {-reset required}
        {-output required}
    }
    parse_key_args "fault_tap" args values $options
    set tmp $::env(synthesis_tmpfiles)/$::env(DESIGN_NAME).v.chained.v
    file copy -force $values(-verilog) $tmp

    try_catch $::env(DFT_BIN) tap \
        --liberty $values(-liberty) \
        --clock $values(-clock) \
        --reset $values(-reset) \
        --output $values(-output) \
        $values(-verilog)
}