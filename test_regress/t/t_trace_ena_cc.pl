#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

top_filename("t/t_trace_ena.v");

compile (
	 verilator_flags2 => ['-trace'],
	 );

execute (
	 check_finished=>1,
	 );

if ($Self->{vlt}) {
    file_grep     ("$Self->{obj_dir}/V$Self->{name}__Trace__Slow.cpp", qr/c_trace_on\"/x);
    file_grep_not ("$Self->{obj_dir}/V$Self->{name}__Trace__Slow.cpp", qr/_trace_off\"/x);
    file_grep     ("$Self->{obj_dir}/simx.vcd", qr/\$enddefinitions/x);
}

ok(1);
1;
