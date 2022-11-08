*File for basic rc_series analysis. 
*Lines not used have been commented out but left in there 
*for user reference in the future. The First line of a spice 
*file is often reserved for comments and may be ignored by 
*some tools. To be safe always juse use it for opening 
*remarks you want to make


*Include the inx_mos_res netlist (inx_mos_res.ckt) and the mosfet models
* (stdLibs.ctl). The files can be in a different directory in which case, 
* provide the absolute path to those files. In this case, its assumed that 

* .LIB <TECH_PATH>

* making it a "local file"
.include "inx_mos_res.ckt"

*Set initial condition of a node. This sets the voltage of a node to your desired value at t=0 (Some exceptions apply). 
* Current flow through elements can also be set in this way. HSPICE will do its own dc convergence analysis. For example 
* if your input voltage source to an inverter is 0 at t=0 then the tool will set the output to vdd at t=0 in accordance with
* the dc solution of the circuit. Sometimes though, the voltage can be arbitrary(such as the initial voltage across a capacitor 
* in an RC series circuit..the .ic command helps here
*Example
* .ic v(<node>)=<initial_voltage>

.param vdd =1.2
.param period=1n
*Define voltage supplies and input waveforms.
*Basic syntax: V<name> node+ node- value 
*The above syntax is for a basic DC voltage source
*Notice that the name of the node and the name of the parameter are the same
*Spice allows this, but its up to you to not be confused between the two...

*This time, vgs is driven by a pulse waveform. Syntax:
*V<source_name> node+ node- PULSE value_initial value_next t_Delay t_rise t_fall t_duration t_period
*Read the spice manual for more details. study the resulting simulation waveform of vgs and experiment with different settings... 
vvgs vgs 0 PULSE 0 vdd 0 20p 20p 'period/2-10p' 'period'
vvdd vds 0 vdd
vvss vss 0 0

*Add capacitive load to the output,10f.
Cout vout 0 10f 

*Run a transient analysis with timestep 1ps for a duration of 10ns
*Note, you can also run spice sweeps here where you "sweep" any parameter you choose and 
*HSPICE will perform a simulation for each parameter value in your sweep, giving you a family of curves. 
*This is optional
.tran 1p 10n 


*Probe statements
.option post
.probe v(*)
.probe i(*)
.probe lx4(M1)

*Measurements
*Basic rise and fall delay measurement. Read the spice manual to understand these commands.
.meas tran delay_rise trig V(vgs) val='0.5*vdd' FALL=2 TD=1n targ V(vout) val='0.5*vdd' RISE=2 TD=1n
.meas tran delay_fall trig V(vgs) val='0.5*vdd' RISE=1 TD='period*0' targ V(vout) val='0.5*vdd' FALL=1 TD='period*0'
.meas tran rise_time trig V(vout) val='0.2*vdd' RISE=2 TD=1n targ V(vout) val='0.8*vdd' RISE=2 TD=1n
.meas tran fall_time trig V(vout) val='0.8*vdd' FALL=2 TD='period*0' targ V(vout) val='0.2*vdd' FALL=2 TD='period*0'
*Observe results in inx_mos_res_tran.mt0
*The rise_time and fall time measurements will fail. Can you use the waveforms and the .lis file to figure out why?

.end
