* SPICE NETLIST
***************************************

.SUBCKT INVD1 vi vo vss! vdd!
** N=4 EP=4 IP=0 FDC=2
M0 vo vi vss! vss! NMOS_VTL L=5e-08 W=3e-07 AD=3.3e-14 AS=3.3e-14 PD=8.2e-07 PS=8.2e-07 $X=275 $Y=-400 $D=1
M1 vo vi vdd! vdd! PMOS_VTL L=5e-08 W=4e-07 AD=4.4e-14 AS=4.4e-14 PD=1.02e-06 PS=1.02e-06 $X=275 $Y=170 $D=0
.ENDS
***************************************
