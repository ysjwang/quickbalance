== Quick Balance

Quick balance was a quick app I made to solve a problem I had in Hong Kong, where cash was used for almost every transaction and couldn't be easily tracked with things like Mint.com, or were too cumbersome to load up an app with. I wanted something with short-code support and also SMS support.

When you first sign up, you are given two accounts: your wallet and your bank. Using shorthand such as `w 100 B` would mean a transaction of $100 from your wallet into your bank account. Alternatively you can specify custom accounts or recipients (such as `w 50 Bob`, which would mean I gave Bob $50 from my wallet). Also useful to keep track of who owes you money (or to whom you owe money to - such as if `Jack 10 W` means Jack gave you $10. Note the use of the capital `W`). Each of these shorthands are saved as pending transactions, so you can check to make sure your syntax is correct before you save it.

A demo of this app is running [here](http://quickbalance.herokuapp.com/). Remember to sign up with your phone number in the format of `+1234567890` (one contiguous string with a `+` in front). Then send an SMS message to `+1862307819` in the shorthand format as listed above.

Traditional non-shorthand transaction input is also supported via drop downs.

