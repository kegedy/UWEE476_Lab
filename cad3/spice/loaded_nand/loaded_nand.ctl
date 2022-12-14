* BEWARE!!!! First line is ALWAYS a comment line and SPICE ignores this line     
* Lines not used have been commented out but left in
* there for user reference in the future.

.LIB "/home/projects/ee476.2022aut/common/cadence_setup/freepdk45.l" tt_lib
.INCLUDE "loaded_nand.ckt"

** include freepdk45.l
*.lib "freepdk45.l" tt_lib

* Define parameters. These are very handy. 
* They are like constant declarations so when
* you need to adjust them in future you just
* have to change them in one place instead of all over the place
* .PARAM v_drain=1.2
* .PARAM v_source=0
* .PARAM v_gate=0.5
.PARAM vdd=1.2

* Define voltage supplies and input waveforms. All voltage
* Sources must start with a v, all current sources, with an i
* Notice that I have a voltage supply called "vg" which also connects a node
* "vg" to ground. Spice understands context so it will not confuse the name 
* of the supply with the name of the node.
* vd vdd! 0 DC=v_drain         
* vs vss! 0 DC=v_source           
* vg vg 0 DC=v_gate
Vvdd vdd! 0 vdd
Vvss vss! 0 0
Va a 0 vdd
*Vz xdut.net1 0 0 


* ==== TRANsient analysis definition ====
*.TRAN <t_step> <t_duration>
.TRAN 1p 5n

* ==== Input waveform ====
.PARAM rise_time = 20p
.PARAM fall_time = 20p
.PARAM pulse_width = 250p
.PARAM period = 500p
.PARAM time_delay = 0n
Vb b 0 PULSE
   + 0 vdd time_delay
   + rise_time fall_time
   + pulse_width period

* DC_analysis. Specify the voltage supply that the DC_analysis
* applies to and the voltage range and step. Here Spice knows that I am not 
* talking about the node vd, but rather the supply
*.DC Vvgs 0 1.2 0.05 

* Probe statements. In this case, probe all node voltages and currents.
* lx4 is a spice model "handle" for a mos device.
* It tells you the drain current of a mos device. Try it out!
.probe v(*)
.probe i(*)
.probe lx4(m0)

* Measurements
.meas tran rise_time trig V(z) val='0.2*vdd' RISE=2 TD=250p targ V(z) val='0.8*vdd' RISE=2 TD=250p
.meas tran fall_time trig V(z) val='0.8*vdd' FALL=2 TD='period' targ V(z) val='0.2*vdd' FALL=2 TD='period'
.meas tran rise_delay trig V(b) val='0.5*vdd' RISE=2 TD=250p targ V(z) val='0.5*vdd' FALL=2 TD=250p
.meas tran fall_delay trig V(b) val='0.5*vdd' FALL=2 TD='period' targ V(z) val='0.5*vdd' RISE=2 TD='period'
*.meas tran mnmos0r integ 'abs(i(xdut.mnmos0))*vdd/20p' from=1.29n to=1.31n
*.meas tran mnmos1r integ 'abs(i(xdut.mnmos1))*vdd/20p' from=1.29n to=1.31n
*.meas tran mpmos0r integ 'abs(i(xdut.mpmos0))*vdd/20p' from=1.29n to=1.31n
*.meas tran mpmos1r integ 'abs(i(xdut.mpmos1))*vdd/20p' from=1.29n to=1.31n
*.meas tran mnmos0f integ 'abs(i(xdut.mnmos0))*vdd/20p' from=1.51n to=1.53n
*.meas tran mnmos1f integ 'abs(i(xdut.mnmos1))*vdd/20p' from=1.51n to=1.53n
*.meas tran mpmos0f integ 'abs(i(xdut.mpmos0))*vdd/20p' from=1.51n to=1.53n
*.meas tran mpmos1f integ 'abs(i(xdut.mpmos1))*vdd/20p' from=1.51n to=1.53n
.meas tran mnmos0r integ 'abs(i(xloaded_nand.mxdut/mnmos0))*vdd/20p' from=1.29n to=1.32n
.meas tran mnmos1r integ 'abs(i(xloaded_nand.mxdut/mnmos1))*vdd/20p' from=1.29n to=1.32n
.meas tran mpmos0r integ 'abs(i(xloaded_nand.mxdut/mpmos0))*vdd/20p' from=1.29n to=1.32n
.meas tran mpmos1r integ 'abs(i(xloaded_nand.mxdut/mpmos1))*vdd/20p' from=1.29n to=1.32n
.meas tran mnmos0f integ 'abs(i(xloaded_nand.mxdut/mnmos0))*vdd/20p' from=1.52n to=1.54n
.meas tran mnmos1f integ 'abs(i(xloaded_nand.mxdut/mnmos1))*vdd/20p' from=1.52n to=1.54n
.meas tran mpmos0f integ 'abs(i(xloaded_nand.mxdut/mpmos0))*vdd/20p' from=1.52n to=1.54n
.meas tran mpmos1f integ 'abs(i(xloaded_nand.mxdut/mpmos1))*vdd/20p' from=1.52n to=1.54n
.meas tran rise_en_dissip param='mnmos0r+mnmos1r+mpmos0r+mpmos1r'
.meas tran fall_en_dissip param='mnmos0f+mnmos1f+mpmos0f+mpmos1f'
.meas tran input_cap integ 'abs(I(Vb))/vdd' from=0 to=250p
.meas tran output_cap integ 'abs(I(Vz))/vdd' from=0p to=250p


.END
