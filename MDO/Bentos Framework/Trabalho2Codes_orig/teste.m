

tc = 0.12384999999999999
F_2slot=[0. , 0.989204601706829
0.9969704770013683, 0.9959368750371262
2.8252975070787887, 0.9987169079064608
3.2815080292259857, 1.0093222184820703
4.265528780468488, 1.160861730986275
5.494129061639901, 1.0407579747737756
6.6872463021998705, 1.069049363404154
7.7742312337880914, 1.1045957665881232
8.615369383996988, 1.1366493079619029
9.595271568025659, 1.190261964635764
10.679088370987863, 1.2618458309407359
11.796487337385898, 1.351432588163079
12.668989960992413, 1.4267152446389322
13.680573431281307, 1.519953270102766
14.586975031186263, 1.6096350711838898
15.494643882541627, 1.6849018870166126
16.33356434271231, 1.421816525750944
17.41959883571273, 1.7885392946953644
18.33170306714452, 1.8133536621586834
18.89467952398867, 1.8094964655565013];

VBase_2slot=spline(F_2slot(:,1)',F_2slot(:,2)',tc*100);


plot(F_2slot(:,1)',F_2slot(:,2)')
