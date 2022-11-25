* SPICE NETLIST
***************************************

.SUBCKT AlphaPhaseLatch Q Q_bar Clk D Clk_bar rst_bar VSS! VDD!
** N=11 EP=8 IP=0 FDC=12
M0 6 D VSS! VSS! NMOS_VTL L=5e-08 W=3e-07 AD=4.35e-14 AS=3.3e-14 PD=8.9e-07 PS=8.2e-07 $X=670 $Y=385 $D=1
M1 Q Clk 6 VSS! NMOS_VTL L=5e-08 W=3e-07 AD=4.65e-14 AS=4.35e-14 PD=9.1e-07 PS=8.9e-07 $X=865 $Y=385 $D=1
M2 2 Clk_bar Q VSS! NMOS_VTL L=5e-08 W=3e-07 AD=3.15e-14 AS=4.65e-14 PD=8.1e-07 PS=9.1e-07 $X=1070 $Y=385 $D=1
M3 VSS! Q Q_bar VSS! NMOS_VTL L=5e-08 W=3e-07 AD=4.65e-14 AS=5.7e-14 PD=9.1e-07 PS=9.8e-07 $X=1495 $Y=385 $D=1
M4 11 rst_bar VSS! VSS! NMOS_VTL L=5e-08 W=3e-07 AD=4.8e-14 AS=4.65e-14 PD=9.2e-07 PS=9.1e-07 $X=1700 $Y=385 $D=1
M5 2 Q_bar 11 VSS! NMOS_VTL L=5e-08 W=3e-07 AD=3.15e-14 AS=4.8e-14 PD=8.1e-07 PS=9.2e-07 $X=1910 $Y=385 $D=1
M6 6 D VDD! VDD! PMOS_VTL L=5e-08 W=4e-07 AD=5.8e-14 AS=4.4e-14 PD=1.09e-06 PS=1.02e-06 $X=670 $Y=995 $D=0
M7 Q Clk_bar 6 VDD! PMOS_VTL L=5e-08 W=4e-07 AD=6.2e-14 AS=5.8e-14 PD=1.11e-06 PS=1.09e-06 $X=865 $Y=995 $D=0
M8 2 Clk Q VDD! PMOS_VTL L=5e-08 W=4e-07 AD=4.2e-14 AS=6.2e-14 PD=1.01e-06 PS=1.11e-06 $X=1070 $Y=995 $D=0
M9 VDD! Q Q_bar VDD! PMOS_VTL L=5e-08 W=4e-07 AD=6.2e-14 AS=7.6e-14 PD=1.11e-06 PS=1.18e-06 $X=1495 $Y=995 $D=0
M10 2 rst_bar VDD! VDD! PMOS_VTL L=5e-08 W=4e-07 AD=6.4e-14 AS=6.2e-14 PD=1.12e-06 PS=1.11e-06 $X=1700 $Y=995 $D=0
M11 VDD! Q_bar 2 VDD! PMOS_VTL L=5e-08 W=4e-07 AD=4.2e-14 AS=6.4e-14 PD=1.01e-06 PS=1.12e-06 $X=1910 $Y=995 $D=0
.ENDS
***************************************
