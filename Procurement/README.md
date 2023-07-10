# PROCUREMENT PERFORMANCE ANALYSIS DASHBOARD
The project includes two files: 
* [Dashboard.xlsm](Dashboard.xlsm): the excel file showing the perfomance of the procurement team and individual employee
* [Report.pptx](Report.pptx): The ppt file that present our analysis and recommended methodology to enhance the procurement team performance

## Dataset
There are two dataset file which are the [PR Record.xlsm](PR Record.xlsm) (Purchasing Requisition) and [PO Record.xlsm](PO Record.xlsm) (Purchasing Requisition). These data showcase the process within the Procurement department

## The Procurement process
The procurement process involves the following steps:
* Purchasing Request Submission: The Procurement team receive purchasing request from various department and may be the procurement team per se. These requests outline the required items or serviced with specific requirement, if neccessary.
* Processing Requesst and Generating Purchase Orders: The Procurement team works on the requests to assess whether or not they are approved. The team then create the purchase orders based on the approved request and send to the respective suppliers.
* Monitoring Deadlines: Thoughout the process, both PRs and PO have the deadlines. If either the PR or PO request exceed the due date without completion, they are categorized as PR Pending and PO Pending respectively.

## Methodology
To deal uncertainty, I propose the two-stage stochastic model, where the first stage is selection of supplier of supplier and the fixed order quantity thorughout all scenarios, and the second stage (or uncertainty stage) is the adjustment of order quantity in order to leverage the benefit of quantity discout, or fulfill the need for peak demand month. The assumption for the second stage is that we cannot change the supplier and the fixed order quantity that already designed at stage 1. Plus, in the demand uncertainty case, we have another option to purchase products at the spot market when the demand exceeding the capacity of our supplier.

To comprehensively address the supplier selection problem, I have developed the 5 distinct models, including both Deterministic model and Stochastic models: 
1. Deterministic Model (EV):
* This model assumes no variation in demand and price, providing a baseline for comparison.
2. Price or Demand without Recourse Action:
* These models assume no recourse action is taken when there is variation in price or demand.
3. Price or Demand Recourse Model (RP):
* This stochastic two-stage model incorporates knowledge of the probability associated with each uncertainty scenario in advance.
4. Price or Demand Wait-and-See Model (WS):
* This stochastic model assumes perfect foresight, with complete knowledge of the specific scenario that will occur in the following month.
5. Deterministic Model with Exact Expected Value (EEV):
* This two-stage model is an extension of the Deterministic Model (EV), where the decision made in the first stage aligns exactly with the decision derived from the Deterministic Model.

## Model evaluation
In the following, we evaluate the economic advantage of considering uncertainty through the
use of stochastic models with recourse for demand uncertainty and price uncertainty with respect of using
expected values for approximating the stochastic variables. To this aim, we compute two well-
known stochastic programming measures (see, e.g., Birge, 1982 or Birge and Louveaux, 1997), i.e.
the Value of the Stochastic Solution (VSS) and the Expected Value of Perfect Information (EVPI),
for both the problems on the complete set of generated instances and considering all the above
described scenario tree generations. 
More precisely, 
VSS := EEV − RP and, 
EVPI := RP − W S,


