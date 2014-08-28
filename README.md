Staffnet2
=========
[![Code Climate](https://codeclimate.com/github/cdale77/staffnet2/badges/gpa.svg)](https://codeclimate.com/github/cdale77/staffnet2)
[![Test Coverage](https://codeclimate.com/github/cdale77/staffnet2/badges/coverage.svg)](https://codeclimate.com/github/cdale77/staffnet2)

This is a rewrite of my first major Rails project (hens the 2). It is a Ruby
on Rails application that handles a variety of tasks for a membership-based
nonprofit organization. 

Supporter data
--------------
Staffnet2 stores a variety of important information about supporters.


Communications
--------------

###Email
Staffnet2 automatically syncs supporter emails with [Sendy](http://sendy.co/) 
for email blasting.

###Phone fundraising
Staffnet2 has a simple donor outreach cycle and can produce turf reports. 

Fundraising
-----------
Via [ActiveMerchant](http://activemerchant.org/), Staffnet2 handles a variety of
tasks related to fundraising. 

###Credit card payments
Staffnet2 uses Authorize.Net to process credit card payments. 

###Stored cards and recurring payments
Staffnet2 securely stores credit card information via Authorize.Net's Customer
Information Manager. It handles monthly and quarterly recurring donations.

###Fundraising history
Staffnet2 tracks all kinds of donations and makes that information available to
staff through a web interface. 


Payroll and HR information
--------------------------
Staffnet2 tracks employee data and work shifts. It can also attribute donations
to employees and their shifts. Finally, it calculates payroll based on money
raised. 
