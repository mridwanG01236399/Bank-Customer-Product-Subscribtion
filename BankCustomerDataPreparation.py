# -*- coding: utf-8 -*-
"""
Created on Wed May  6 20:18:20 2020

@author: iwanJ
"""

import os  # for OS interface (to get/change directory)
import pandas as pd  # for data frame creation

os.chdir('D:/George Mason University/Semester 2/Analytics Big Data to Information/Data Analytics Research Project/Dataset')
os.getcwd()

bank = pd.read_csv("bank-full.csv", sep=";")
bank.head()
bank.info()

#bank.y[13]

answers = []
i = 0
while (i < len(bank)):
    if (bank.y[i] == "no"):
        answers.append(0)
    else:
        answers.append(1)
#    print(bank.y[i])
    i = i + 1

bank['answer'] = answers

df_new_bank = pd.DataFrame({'age': bank['age'],
                            'job': bank['job'],
                            'marital': bank['marital'],
                            'education': bank['education'],
                            'default': bank['default'],
                            'balance': bank['balance'],
                            'housing': bank['housing'],
                            'loan': bank['loan'],
                            'contact': bank['contact'],
                            'day': bank['day'],
                            'month': bank['month'],
                            'duration': bank['duration'],
                            'campaign': bank['campaign'],
                            'pdays': bank['pdays'],
                            'previous': bank['previous'],
                            'poutcome': bank['poutcome'],
                            'y': bank['answer']})
    
df_new_bank.to_csv (r'bank_customer.csv', index = False, header=True) 

# libraries
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
###############################################################################
#Visualization for Marital Status
###############################################################################
marital_status_value = []
i = 0
while (i < len(df_new_bank['marital'].value_counts())):
    marital_status_value.append(df_new_bank['marital'].value_counts()[i])
    i = i + 1

# Make a dataset
height = marital_status_value
bars = ('married', 'single', 'divorced')
y_pos = np.arange(len(bars))

plt.bar(y_pos, height, color=('green', 'blue', 'cyan'))
plt.xticks(y_pos, bars)
plt.title('Customers Marital Status', weight='bold').set_fontsize('18')
plt.xlabel('Type of Marital Status', fontsize=10, weight='bold')
plt.ylabel('Total Number of Each Status', fontsize=10, weight='bold')
plt.show()

###############################################################################
#Visualization for Education
###############################################################################
education_level = []
i = 0
while (i < len(df_new_bank['education'].value_counts())):
    education_level.append(df_new_bank['education'].value_counts()[i])
    i = i + 1
    
# Make a dataset
height = education_level
bars = ('secondary', 'tertiary', 'primary', 'unknown')
y_pos = np.arange(len(bars))

plt.bar(y_pos, height, color=('blue', 'cyan', 'purple', 'green'))
plt.xticks(y_pos, bars)
plt.title('Customers Education Level', weight='bold').set_fontsize('18')
plt.xlabel('Type of Education Level', fontsize=10, weight='bold')
plt.ylabel('Total Number of Level', fontsize=10, weight='bold')
plt.show()

###############################################################################
#Visualization for Age
###############################################################################
fig = plt.figure()
fig.suptitle('Banks Customers Age Summary', fontsize=14, fontweight='bold')
ax = fig.add_subplot(111)
sns.boxplot(x = df_new_bank["age"], 
            palette="Blues")
ax.set_xlabel('Age', weight='bold')
plt.show()