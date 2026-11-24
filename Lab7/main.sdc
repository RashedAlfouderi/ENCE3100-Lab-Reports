# SW9 is the manual step clock used by this design.
# 20 ns is a conservative timing-analysis assumption, NOT the physical switch frequency.
create_clock -name MANUAL_STEP -period 20.000 [get_ports {SW[9]}]
derive_clock_uncertainty
