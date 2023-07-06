/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Admin
 * Creation Date: Mar 20, 2023 at 10:03:46 AM
 *********************************************/
int numr= 5;
int numi= 10;
int numk= 5;
int nums = 30;

// range
range R = 1..numr;
range I = 1..numi;
range K = 1..numk;
range S = 1..nums;

// parameter
float a[I]=...;
float f[I][K]=...;
float delta[I][R]= ...;
int d[K]=...;
int q[I][K] = ...;
int l[I][R] =...;
int u[I][R] = ...;

// deccision variable
dvar boolean x[I];
dvar int+ z[I][K][R];
dvar boolean y[I][R];

// objective function
dexpr float activation_cost = sum(i in I)a[i]*x[i];
dexpr float purchasing_cost = sum (k in K, i in I, r in R) (1 - delta[i][r]) * f[i][k] * z[i][k][r];
dexpr float total_cost = activation_cost + purchasing_cost;
 

execute PRE_Setup
{ 
  cplex.epgap=0.01;
  cplex.tilim=8000;
}
//minimize staticLex(cost,env_impact); //step 1&3
minimize total_cost;
subject to 
{
  con_2:
  forall (k in K)
  sum (i in I, r in R) z[i][k][r] >= d[k];
  
  con_3:
  forall (k in K, i in I)
  sum (r in R) z[i][k][r] <= q[i][k];
  
  con_4a:
  forall (i in I, r in R)
  l[i][r] * y[i][r] <= sum (k in K) z[i][k][r];
  
  con_4b:
  forall (i in I, r in R)
  sum (k in K) z[i][k][r] <= u[i][r]*y[i][r];
  
  con_5:
  forall (i in I)
  sum (r in R) y[i][r] <= x[i];
  
}



