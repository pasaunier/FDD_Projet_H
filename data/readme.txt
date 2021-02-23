R visualization : Cholesterol Analysis
A study tested whether cholesterol was reduced after using a certain brand of margarine as part of a low fat, low cholesterol diet. 
The subjects consumed on average 2.31g of the active ingredient, stanol easter, a day. This data set contains information on 18 people 
using margarine to reduce cholesterol over three time points. 

Python classification
There are 3 types of input features:
    Objective: factual information;
    Examination: results of medical examination;
    Subjective: information given by the patient.
Features:
    Age | Objective Feature | age | int (days)
    Height | Objective Feature | height | int (cm) |
    Weight | Objective Feature | weight | float (kg) |
    Gender | Objective Feature | gender | categorical code |
    Systolic blood pressure | Examination Feature | ap_hi | int |
    Diastolic blood pressure | Examination Feature | ap_lo | int |
    Cholesterol | Examination Feature | cholesterol | 1: normal, 2: above normal, 3: well above normal |
    Glucose | Examination Feature | gluc | 1: normal, 2: above normal, 3: well above normal |
    Smoking | Subjective Feature | smoke | binary |
    Alcohol intake | Subjective Feature | alco | binary |
    Physical activity | Subjective Feature | active | binary |
    Presence or absence of cardiovascular disease | Target Variable | cardio | binary |

Topic modeling 
Tweets of the COVID_19
These tweets are collected using Twitter API and a Python script.
 A query for this high-frequency hashtag (#covid19) is run on a daily basis for a certain time period, to collect a larger number of tweets samples.
The tweets have #covid19 hashtag. Collection started on 25/7/2020, with an initial 17k batch.