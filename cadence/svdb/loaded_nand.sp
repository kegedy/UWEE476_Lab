* SPICE NETLIST
***************************************

.SUBCKT NAND2 b vss! a z vdd!
** N=6 EP=5 IP=0 FDC=4
M0 6 b vss! vss! NMOS_VTL L=5e-08 W=3e-07 AD=4.35e-14 AS=3.3e-14 PD=8.9e-07 PS=8.2e-07 $X=275 $Y=-400 $D=1
M1 z a 6 vss! NMOS_VTL L=5e-08 W=3e-07 AD=3.3e-14 AS=4.35e-14 PD=8.2e-07 PS=8.9e-07 $X=470 $Y=-400 $D=1
M2 z b vdd! vdd! PMOS_VTL L=5e-08 W=2.5e-07 AD=3.625e-14 AS=2.75e-14 PD=7.9e-07 PS=7.2e-07 $X=275 $Y=300 $D=0
M3 vdd! a z vdd! PMOS_VTL L=5e-08 W=2.5e-07 AD=2.75e-14 AS=3.625e-14 PD=7.2e-07 PS=7.9e-07 $X=470 $Y=300 $D=0
.ENDS
***************************************
.SUBCKT loaded_nand z vdd! vss! a b
** N=9 EP=5 IP=25 FDC=20
X0 a vss! b z vdd! NAND2 $T=0 700 0 0 $X=0 $Y=0
X1 vdd! vss! z 6 vdd! NAND2 $T=575 700 0 0 $X=575 $Y=0
X2 vdd! vss! z 7 vdd! NAND2 $T=1150 700 0 0 $X=1150 $Y=0
X3 vdd! vss! z 8 vdd! NAND2 $T=1725 700 0 0 $X=1725 $Y=0
X4 vdd! vss! z 9 vdd! NAND2 $T=2300 700 0 0 $X=2300 $Y=0
.ENDS
***************************************
