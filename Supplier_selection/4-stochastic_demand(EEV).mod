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

int x[I] = ...;
int y[I][R] = ...;

tuple tuple_3dims{
    key int i;
    key int k;
    key int r;
    int value;
    };
    
{tuple_3dims} set_z = ...;

int z[i in I][k in K][r in R] = item(set_z, <i,k,r>).value;


dvar int+ z_plus[I][K][R][S];
dvar int+ z_minus[I][K][R][S];
dvar int+ ws[K][S];
dvar boolean lamda_plus[I][K][R][S];
dvar boolean lamda_minus[I][K][R][S];

//dvar float extra_cost;
//dvar float total_cost;

// objective function
dexpr float activation_cost = sum(i in I)a[i]*x[i];
dexpr float purchasing_cost = sum (s in S)( p[s] * (sum (k in K, i in I, r in R) (1 - delta[i][r] )*f[i][k] *(z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s])));
dexpr float outsource_cost = sum (s in S) ( p[s] * (sum(k in K) F[k]*ws[k][s]) );
dexpr float total_cost = activation_cost + purchasing_cost + outsource_cost;


execute PRE_Setup
{ 
  cplex.epgap=0.2;
  cplex.tilim=8000;
}
minimize total_cost;
subject to 
{
  con_67:
  forall (k in K)
  sum (i in I, r in R) z[i][k][r]  >= d[k];

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
  
//  extra_cost == sum (s in S)( p[s] * (sum (k in K, i in I, r in R) (1 - delta[i][r] )*f[i][k] *(z[i][k][r] + z_plus[i][k][r][s] - z_minus[i][k][r][s])));
//  total_cost == activation_cost + purchasing_cost + extra_cost;
  
}



 