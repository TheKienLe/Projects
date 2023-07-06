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

tuple tuple_3dims{
    key int i;
    key int k;
    key int s;
    float value;
    };
{tuple_3dims} set_fdelta = ...;
float fdelta[i in I][k in K][s in S] = item(set_fdelta, <i,k,s>).value;

float p[S] = ...; 
float F[K] = ...;

int x[I] = ...;
int y[I][R] = ...;

tuple tuple_ikr{
    key int i;
    key int k;
    key int r;
    int value;
    };
{tuple_ikr} set_z = ...;
int z[i in I][k in K][r in R] = item(set_z, <i,k,r>).value;


dvar int+ z_plus[I][K][R][S];
dvar int+ z_minus[I][K][R][S];
dvar boolean lamda_plus[I][K][R][S];
dvar boolean lamda_minus[I][K][R][S];

// objective function
dexpr float activation_cost = sum(i in I)a[i]*x[i];
dexpr float purchasing_cost = sum (s in S)( p[s] * (sum (k in K, i in I, r in R) (1 - delta[i][r] )*(f[i][k]+fdelta[i][k][s]) *(z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s])));
dexpr float total_cost = activation_cost + purchasing_cost;

execute PRE_Setup
{ 
  cplex.epgap=0.01;
  cplex.tilim=8000;
}

minimize total_cost;
subject to 
{
   con_39:
  forall (k in K)
  sum (i in I, r in R) z[i][k][r] >= d[k];
  
  con_40:
  forall (k in K, i in I)
  sum (r in R) z[i][k][r] <= q[i][k];
  
  con_41a:
  forall (i in I, r in R)
  l[i][r] * y[i][r] <= sum (k in K) z[i][k][r];
  
  con_41b:
  forall (i in I, r in R)
  sum (k in K) z[i][k][r] <= u[i][r]*y[i][r];
  
  con_42:
  forall (i in I)
  sum (r in R) y[i][r] <= x[i];
  
  con_43:
  forall (k in K, s in S)
  sum(i in I, r in R) (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s]) >= d[k];
  
  con_44:
  forall (k in K, i in I, s in S)
  sum (r in R) (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s]) <= q[i][k];
  
  con_45a:
  forall (i in I, r in R, s in S)
  l[i][r]* y[i][r] <= sum (k in K) (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s]);
  
  con_45b:
  forall (i in I, r in R, s in S)
  sum (k in K)  (z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s])<= u[i][r]*y[i][r];
  
  con_46:
  forall (k in K, i in I, r in R, s in S)
  z_minus[i][k][r][s] <= z[i][k][r];
  
  con_47:
  forall (k in K, i in I, r in R, s in S)
  z_plus[i][k][r][s] <= (q[i][k])*lamda_plus[i][k][r][s];
  
  con_48:
  forall (k in K, i in I, r in R, s in S)
  z_minus[i][k][r][s] <= (q[i][k])*lamda_minus[i][k][r][s];
  
  con_49:
  forall (k in K, i in I, r in R, s in S)
  lamda_minus[i][k][r][s] + lamda_plus[i][k][r][s] <= y[i][r];
  
  cont_50:
  forall(i in I)
  sum(r in R) y[i][r] <= 1;   
  
  
  
}



 