# ML_credit_card_fraud_detection
Paper Refferences:https://doi.org/10.1016/j.jisa.2019.02.007
Credit card fraud has raised the concern for both financial institution and cardholders which result in substatial financial lost and identity theif.
Two main challenges in credit card fraud detection are that the fraudulent transaction only account for the extremely small amount of total transaction, and the fraudulent behaviour constantly envolve. 
This project aim to build the robust and accurate Machine Learning model to effectively detect illegal credit card transaction.

## Dataset
The dataset is collected by credit cards in September 2013 by European cardholders. 
This dataset contain 30 input variables and 1 response variable "Class".
Due to the confidential reason, only 2 variable "Time" and "Amount"  was revealed. For the remaining, from "V1" to "V28", these variable have already been transformed by PCA.
There are the total of 284,807 transaction but only 492  (0.172%) out of them were fraud.
Data source: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud

## Methodology
### 1. Exploratory Data Analysis (EDA): 
* Gain insights about two known feature and their relation to the fraud transaction
### 2. Feature Selection
* Check for Data correlation and multicollinearity between input variable 
* Check for autocorrelation with the target variable
* Access feature importance by Random Forest, AdaBoost and Gradient Boosting
### 3. Preprocessing
* Handle skew data with Yeo-Johnson transformations
* Handle class imbalance with SMOTE, ADASYN
### 4. Model Selection and Training
* We choose five different algorithms for training, namely: MultiLayer Perception (MLP), Gaussian Naive Bayes (GNB), Random Forest (RFC), AdaBoost (ADA) and Gradient Boosting (GBC)
* We also combine these algorithm to create an Ensemble Learning model by 5 different approach: prudential Multiple Consensus model (PMC), Majority Voting, Complete Agreement, Weighted Voting, Classifier Selection and Relational Approach
### 5. Model Evaluation
* 3 metric are chosen for evaluation are: Sensitivity, Fallout and AUC

## Results and Conclusion

