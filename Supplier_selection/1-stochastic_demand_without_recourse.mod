/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Admin
 * Creation Date: Mar 20, 2023 at 9:24:38 PM
 *********************************************/

int numr= 5;
int numi= 10;
int numk= 5;
int nums = 30;
// range
range R =1..numr;
range I =1..numi;
range K =1..numk;
range S = 1..nums;
// parameter
float a[I]=...;
float f[I][K]=...;
float delta[I][R]= ...;
int d[K]=...;
int q[I][K] = ...;
int l[I][R] =...;
int u[I][R] = ...;

int ddelta[K][S]=...;

float p[S] = ...; 
float F[K] = ...;

dvar boolean x[I];
dvar int+ z[I][K][R];

dvar int+ z_plus[I][K][R][S];
dvar int+ z_minus[I][K][R][S];
dvar int+ w[K];
dvar int+ ws[K][S];
dvar boolean lamda_plus[I][K][R][S];
dvar boolean lamda_minus[I][K][R][S];
dvar boolean y[I][R];
dvar float purchasing_cost;
dvar float total_cost;
dvar float outsource_cost;

// objective function
dexpr float activation_cost = sum(i in I)a[i]*x[i];
//dexpr float purchasing_cost = sum (k in K, i in I, r in R) (1 - delta[i][r]) * f[i][k] * z[i][k][r];
//dexpr float extra_cost = sum (s in S)( p[s] * (sum (k in K, i in I, r in R) (1 - delta[i][r] )*f[i][k] *(z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s])));
//dexpr float total_cost = activation_cost + purchasing_cost + extra_cost;

execute PRE_Setup
{ 
  cplex.epgap=0.1;
  cplex.tilim=8000;
}
minimize activation_cost;
subject to 
{
  con_67:
  forall (k in K)
  sum (i in I, r in R) z[i][k][r] >= d[k];

  con_68:
  forall (k in K, i in I)
  sum (r in R) z[i][k][r] <= q[i][k];
  
  con_69_a:
  forall (i in I, r in R)
  l[i][r]*y[i][r] <= sum (k in K) z[i][k][r];
  
  con_69_b:
  forall (i in I, r in R)
  sum (k in K) z[i][k][r] <= u[i][r]*y[i][r];
  
  con_70:
  forall (i in I)
  sum (r in R) y[i][r] <= x[i];
  
  con_71:
  forall (k in K, s in S)
  sum (i in I, r in R) (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s]) + ws[k][s] >= d[k] + ddelta[k][s];
  
  con_72:
  forall (k in K, s in S, i in I)
  sum (i in I, r in R) (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s]) >= q[i][k];

  con_73_a:
  forall (i in I, r in R, s in S)
  l[i][r]*y[i][r] <= sum (k in K) (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s]);
   
  con_73_b:
  forall (i in I, r in R, s in S)
  sum (k in K) (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s]) <= u[i][r]*y[i][r];
  
  con_74:
  forall (k in K, i in I, r in R, s in S)
  z_minus[i][k][r][s] <= z[i][k][r];

  con_75:
  forall (k in K, i in I, r in R, s in S)
  z_plus[i][k][r][s] <= q[i][k]*lamda_plus[i][k][r][s];

  con_76:
  forall (k in K, i in I, r in R, s in S)
  z_minus[i][k][r][s] <= q[i][k]*lamda_minus[i][k][r][s];

  con_77:
  forall (k in K, i in I, r in R, s in S)
  lamda_plus[i][k][r][s] + lamda_minus[i][k][r][s] <= y[i][r];
  
  cont_78:
  forall(i in I)
  sum(r in R) y[i][r] <= 1; 
  
  purchasing_cost == sum (s in S)( p[s] * (sum (k in K, i in I, r in R) (1 - delta[i][r] )*f[i][k] *(z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s])));
  outsource_cost == sum (s in S) ( p[s] * (sum(k in K) F[k]*ws[k][s]) );
  total_cost == activation_cost + purchasing_cost + outsource_cost;
  
}



 