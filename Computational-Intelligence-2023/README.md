# Computational-Intelligence-2023
This project contains files from the 2022 projects in the Computational Intelligence course in ECE, Aristotle University of Thessaloniki. 

The course included four projects. Namely: 

# Project 1- Satellite

**Exercise 1- Classic Control** \
For the following closed-loop control system:
<p>
<img src="https://user-images.githubusercontent.com/95578892/230614266-ad30d634-ebc9-4c22-9e2b-4d03383bdba8.png" width="450" height="150" />
</p>

i) Define the parameters $K_I$ and $K_P$ of a PI controller so that the following conditions are met for the system: 
  1. Overshoot smaller than 10% 
  2. Rising time smaller than 1.2 seconds. 
  
ii) Calculate the step response of the closed-loop system 

**Exercise 2- Fuzzy Control**\
For the following closed-loop control system:

<p>
<img src="https://user-images.githubusercontent.com/95578892/230615307-603e14a1-8efa-49f5-93b6-08dec34ac9a4.png" width="450" height="150" />
</p>

i) Design a Fuzzy Logic Controller, where the fuzzy variables are the error $E$ and the derivative of the error $\dot{E}$

ii) Define the gains $K_e$  $K_I$ and a of the FLC so that the following conditions are met for step input:
  1. Overshoot smaller than 10% 
  2. Rising time smaller than 1.2 seconds. 

iii) Calculate the response of the system for step input 

iv) Calculate the response of the system for the following inputs
<div id="image-table">
    <table>
	    <tr>
    	    <td style="padding:10px">
        	    <img src="https://user-images.githubusercontent.com/95578892/230617618-036f4778-f39a-465e-aff3-2e116e774fd2.png" width="350"/>
      	    </td>
            <td style="padding:10px">
            	<img src="https://user-images.githubusercontent.com/95578892/230617662-2920b313-f077-4c24-bc74-f445c8cd35c7.png" width="350"/>
            </td>
        </tr>
    </table>
</div>

# Project 2- TSK

**Exercise 1** \
Train 4 TSK models using the [Airfoil
Self-Noise dataset](https://archive.ics.uci.edu/ml/datasets/airfoil+self-noise) to predict the target variable

**Exercise 2** \
For the [Superconductivty dataset](https://archive.ics.uci.edu/ml/datasets/superconductivty+data) :
1) Apply feature scaling using Grid Partitioning
2) Train 4 TSK models to predict the target variable

# Project 3- MLP

**Exercise 1** \
For the [MNIST dataset](http://yann.lecun.com/exdb/mnist/) train a MLP Neural Network for 
- batch size = {1,256, N_train}
- RMSProp optimizer, lr = 0:001;
- SGD optimizer, lr = 0:01
- L2 regularization
- L2 regularization

**Exercise 2** - Fine tune the model \
Fine tune the model with grid search and 5-fold cross validation for the following hyperparameters:
- number of neuros in the first hidden layer
- number of neuros in the second hidden layer
- regularization factor
- learning rate

# Project 4- RBF

**Exercise 1** \
For the [Boston housing dataset](https://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html) train a RBF Neural Network for number of neuros in the hidden layer = {10%,50%,90%} of the total training samples

**Exercise 2** - Fine tune the model \
Fine tune the model with grid search and 5-fold cross validation for the following hyperparameters:
- number of neuros in the first hidden layer samples
- number of neuros in the second hidden layer
- dropout probability

