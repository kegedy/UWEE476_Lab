* BEWARE!!!! First line is ALWAYS a comment line and SPICE ignores this line     
* Lines not used have been commented out but left in
* there for user reference in the future.

.LIB "/home/projects/ee476.2022aut/common/cadence_setup/freepdk45.l" tt_lib
.INCLUDE "q1b.ckt"

* Define parameters. These are very handy. 
* They are like constant declarations so when
* you need to adjust them in future you just
* have to change them in one place instead of all over the place
.PARAM v_drain=1.2
.PARAM v_source=0
.PARAM v_gate=1.2

* Define voltage supplies and input waveforms. All voltage
* Sources must start with a v, all current sources, with an i
.GLOBAL vdd! vss!
vd vdd! 0 DC=v_drain         
vs vss! 0 DC=v_source           
vg vg 0 DC=v_gate 

* DC_analysis. Specify the voltage supply that the DC_analysis
* applies to and the voltage range and step. 
.dc vd 0 1.2 0.05 sweep v_gate 0.6 1.2 0.6

* Another way to do the same thing
*.dc vd 0 1.2 0.05 sweep data=gate_sweep
*.data gate_sweep 
*+v_gate 0.6 1.2 0.6

* Probe statements. In this case, probe all node voltages and currents.
* lx4 is a spice model "handle" for a mos device.
* It tells you the drain current of a mos device. Try it out!
.probe v(*)
.probe i(*)
.probe lx4(m0)

.END


