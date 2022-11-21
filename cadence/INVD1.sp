* SPICE NETLIST
***************************************

.SUBCKT INVD1 vi vss! vdd! vo
** N=6 EP=4 IP=0 FDC=2
M0 vo vi vss! 5 NMOS_VTL L=2.5e-08 W=1.5e-07 AD=8.25e-15 AS=8.25e-15 PD=4.1e-07 PS=4.1e-07 $X=275 $Y=-400 $D=1
M1 vo vi vdd! 6 PMOS_VTL L=2.5e-08 W=2e-07 AD=1.1e-14 AS=1.1e-14 PD=5.1e-07 PS=5.1e-07 $X=275 $Y=170 $D=0
.ENDS
***************************************
