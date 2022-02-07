# Property Letting API

A rails property letting API. The application handles property creation and storage, mobile payment processing with the help of the paynow ruby sdk [Paynow SDK](https://github.com/gitnyasha/paynow-ruby-sdk) and monthly subscriptions for customers.

## Built With

    - Rails
    - RESTful API
    - Paynow
    - Postgresql for production
    - SQLite for development
    - Postman for testing

## Authors

👤 **Brolin Remunyanga**

- Linkedin: [Brolin Remunyanga](https://www.linkedin.com/brolinr-remunyanga/)
- Github: [@brolinr](https://github.com/brolinr)

## 🤝 Contributing

    issue reports are welcome!

Feel free to check the [issues page](../../issues).

## ⭐️ Show your support

    Give a ⭐️ if you like this project!

#WE NEED A METHOD TO CHECK FOR THE SUBSCRIPTION EXIPRATION
#
#def expired
#    created = customer.subscription.last.created_at
#    if created >= created + 30#days from now
        #then we are still good
#    else
        #create new subscription
#    end
#end


#def subscribed?
    
#    if customer.subscriptions.any? && expiry > current_date 
        #expiry = customer.Subscription.last.created_at + 30 days 
        #current_date = customer.Subscription.last.created_at

        #then user is subscribed
#    else
        
#    end
    
#end