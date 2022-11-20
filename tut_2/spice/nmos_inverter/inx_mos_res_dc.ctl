* ====== File for basic rc_series analysis. ====== 
* - Lines not used have been commented out but left in there 
*   for user reference in the future. The First line of a spice 
*   file is often reserved for comments and may be ignored by 
*   some tools. To be safe always juse use it for opening 
*   remarks you want to make


* You may have to manually include the mosfet models (stdLibs.ctl). 
* The stdLibs file is at: 

* .LIB <TECH_PATH> 

* 
* Note that if the standard libs are already in your netlist, including
* stdLibs will generate a duplicate include error
*

* Include the netlist
.include "inx_mos_res.ckt"

*Define parameters. Very handy to work with meaningful symbols instead of
*actual values. Also needed to implement sweeps (more on this later)
.param vdd =1.2
.param vds=1.2

*Define voltage supplies and input waveforms.
*Basic syntax: V<name> node+ node- value 
*The above syntax is for a basic DC voltage source
*Notice that the name of the node and the name of the parameter are the same
*Spice allows this, but its up to you to not be confused between the two...
vvgs vgs 0 vdd
vvds vds 0 vds
vvss vss 0 0

*DC analysis statement. 
*Sweep the voltage of a node of a voltage source.
*In this case, sweep from 0 to vdd(defined above)
.dc vvgs 0 vdd 0.05 

*************** OPTIONAL ************************
* Try out the sweep below instead. View the results. 
* The sweep functionality will prove to be very to 
* find the resistance for example...

* .dc vvgs 0 vdd 0.05 SWEEP vds 'vdd/2' vdd 'vdd/10'
*************************************************

*Probe statements
*Probe all voltages and currents. Not recommended for large nets.
*Look at the HSPICE manual for more details on how to identify which specific nodes you would like to view.
*The ".option post" is needed if you want hspice to generate waveform files. For a dc analysis, the output file is a .sw* file.
.option post
.probe v(*)
.probe i(*)

******************* OPTIONAL *********************
*The hspice model you included (stdLibs.ctl) had a model definition 
* for a MOS transistors. These models contain "handles" to make it 
* easy for you to probe relevant details of the fet, such as Vt, Ids, 
* Junction Leakage etc. LX4 is a spice model parameter (handle) for 
* drain current. It tells you the drain current of a mos device.
.probe lx4(M0)
**************************************************

*Measurements
*FIND-WHEN is a popular measure during DC analysis. In this case
*The measure statement finds V(vgs), the voltage of the vgs node,
*When the voltage of the vout node, V(vout) = vdd/2. V(<node_name>) 
*and I(<instance>) are ways to obtain the voltage and current of
*nodes and elements respectively and handy for hspice measurement.
*Notice the benefit of using parameters here: You will not have to 
*fix this statement every time you run a simulation for a different 
*voltage. If you need a value to be evaluated, such as in the target V(vout),
* include the expression in '', like 'vdd/2'

.meas dc sw_thresh FIND v(vgs) WHEN V(vout)='vdd/2'
*Note there is a bug in the above statement below. Fix it to get a 
* working measurement. Sometimes the .lis file where you 
* redirected the output to is useful...

*Observe results in inx_mos_res_tran.ms0


*.END must be at the end of the spice file that you call hspice on.
*Note that HSpice is case-insensitive, so nets FOO Foo and foo will 
* all be counted as one node, and you will short them together
.end
