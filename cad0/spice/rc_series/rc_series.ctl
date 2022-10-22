* The first line of a control file must be a comment (HSPICE syntax rules) 

* ==========================
*      File Includes
* ==========================
* - stdLibs may be necessary (uncomment), but ONLY if the libraries are not already included in the netlist!
*   otherwise you will get an error 
.INC "rc_series.ckt"

* ==========================
*   Simulation Parameters
* ==========================
* - essentially variables
* - HSPICE keywords are case insensitive (.param, .PARAM, etc.)
.PARAM vdd =1.2
.PARAM vss =0
.paRAm beta = 2.6
.param period = 20n
.PARAM tr = 0p

* ==========================
*    Simulation Duration 
* ==========================
* - TRANsient 
.TRAN 1p 50n 

* ===============================
*   Voltages and Input Waveforms
* ===============================
*  - 0 is a special character in HSPICE for the global ground 
*  - Syntax: V<name> FROM<node> TO<node> VALUE 
Vvdd vdd! 0 vdd         * A voltage named "vdd" FROM the global node "vdd!" TO ground, of VALUE vdd=1.2
Vvss vss! 0 0           * A voltage named "vss" FROM the global node "vss!" TO ground, of VALUE 0

* Generate the input waveform
* - Uses an HSPICE command called PULSE, many other input patterns exist
Vvi Vi 0 PULSE(0 vdd 0 tr tr 'period/4-tr' 'period/2')

* ==========================
*    Voltage/Current Probes 
* ==========================
* - Sampled into waveforms
* - Wildcard to probe all voltages/currents
.probe V(*)
.probe I(*)
* .probe lx4(M1)  * lx4 is a spice model "handle" for drain current in mos device 

* ==========================
*    Measurements
* ==========================
* - Results appear as text data in .mt[0-9] files, for instance "rc_circuit.mt0" 

* Trigger measurement when vo = 20% vdd, on the 2nd rising edge, until vo = 80% vdd 
.MEAS TRAN rise_time   
   + TRIG V(Vo) VAL='0.2*vdd' RISE=1 TD=0 * '+' for line continuation 
   + TARG V(Vo) VAL='0.8*vdd' RISE=1 TD=0

* Trigger measurement on 2nd rising edge of "Vi", use 2nd rising edge of "vo" as the target 
.MEAS TRAN rise_delay TRIG V(Vi) VAL='0.5*vdd' RISE=1 TD=2n TARG V(Vo) VAL='0.5*vdd' RISE=1 TD=2n


* ==== Sidenote ==== 
* 
* The measurements taken here may not match the exact numbers you find by measuring the waveform. 
* The reason is that we are triggering the measurements on vo relative to vdd, while SiliconExplorer
* measures relative to the waveform itself. For the sake of most CAD's it is okay to take a measurement
* that is a little bit off; the autograder considers measurements correct if they are within 15% of the
* true value. Nevertheless, if you are OCD about the numbers matching exactly, you could do something like 
* the following: 

* Max and min input and output voltages 
*.MEAS TRAN vo_max MAX V(Vo)  
*.MEAS TRAN vo_min MIN V(Vo)
*.MEAS TRAN vi_max MAX V(Vi)
*.MEAS TRAN vi_min MIN V(Vi)

* Rise delay WRT output voltage
*.MEAS TRAN rise_delay  
*	+ TRIG V(Vi) VAL='0.5*(vi_max-vi_min)+vi_min' TD=0 FALL=1 
*	+ TARG V(Vo) VAL='0.5*(vo_max-vo_min)+vo_min' TD=0 RISE=1 

* Rise time WRT output voltage
*.MEAS TRAN rise_time   
*	+ TRIG V(Vo) VAL='0.2*(vo_max-vo_min)+vo_min' TD=0 RISE=1
*	+ TARG V(Vo) VAL='0.8*(vo_max-vo_min)+vo_min' TD=0 RISE=1

.END
