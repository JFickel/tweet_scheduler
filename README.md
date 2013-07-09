This is the first challenge in a sequence of challenges, leading up to building an application to schedule future tweets and deploying it to Heroku.

To start, we'll create an application that lets a single user tweet. We'll hard-code the user from which we'll be tweeting. Later we'll add support for logging in via Twitter so that anyone can tweet. Finally, we'll add the ability to schedule tweets into the future.

You'll learn about background jobs, tasks queues, and scheduled tasks over these challenges — three fundamental components to building a usable, scalable web application. You'll also learn some sysadmin voodoo to manage development and production credentials, and a bit of the inner workings of OAuth.

All in a day's work, right?

Objectives
Tweet It!
Create a single page with a form, a text field, and a submit button. When the user posts this form it should Tweet whatever text the user typed.

The account from which the application tweets should be hard-coded for now. You can make it your own personal tweet page if you'd like.

Tweet It, Asynchronously!
It takes time to tweet something and that makes for a subpar user experience. Bind to your form's submit event and instead submit an AJAX request. As soon as the form is submitted, disable the form elements, display a message letting the user know their tweet is being processed, and display an "all good" or "error" message via the AJAX callback once the tweet has actually been processed.

jQuery .submit()
How to disable/enable an element with jQuery
