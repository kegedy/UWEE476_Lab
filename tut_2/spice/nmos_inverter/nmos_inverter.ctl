* DESCRIPTION ctl file
* ===== Tech Lib ======
.LIB "/home/projects/ee476.2022aut/common/cadence_setup/freepdk45.l" tt_lib
* ==== Netlist ====
.INCLUDE "nmos_inverter.ckt"
* ==== Voltage sources ====
.PARAM vdd = 1.2
Vvgs vin 0 vdd
Vvdd vdd! 0 vdd
* ==== DC analysis definition ====
.DC Vvgs 0 1.2 0.05
.MEAS DC switch_thresh FIND V(vin) WHEN V(vout) = V(vin)
.OPTION POST
.END
