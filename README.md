# How to create a simple login page in shiny apps

This project is just a simple workaround if you want to publish your app online for free but need some (little) security. Don't use this method if you have top secret infos in your app...

**The login page core concept:**

>Remove login page UI and insert new UI of your choice if the username and password are corrects.

Username and password can be defined inside the script, in a .csv, .txt, .xlsx etc. You just need to import/read it when validating user credential.

It's also possible to use cryptography (check <code>sodium package</code>).
