# House Rental Subscription API
Welcome to the House Rental Subscription API documentation! This API facilitates customers to subscribe to view houses 
available for renting. These houses are created by the admin, and the app also features feedback from users.

## Table of Contents
1. [Introduction](#introduction)
2. [Authentication](#authentication)
3. [Endpoints](#endpoints)
   - [Customers](#customers)
   - [Admins](#admins)
   - [Houses](#houses)
   - [Amounts](#amounts)
   - [Subscriptions](#subscriptions)
   - [Feedbacks](#feedbacks)
4. [Error Handling](#error-handling)
5. [Response Format](#response-format)
6. [Examples](#examples)
7. [Rate Limiting](#rate-limiting)
8. [Security](#security)
9. [Conclusion](#conclusion)

## Introduction
The House Rental Subscription API allows customers to browse houses available for rent full information on houses can 
only be provided whe the customer has paid a subscription fee set by the admin(amounts). Admins can create and manage
house listings, and users can provide feedback on their rental experience.

## Authentication
To use this API, you need to set the an environment variable `ALLOWED_DOMAIN` to the url of the client that will make
requests to the app.

## Endpoints

### Customers
- `POST /api/v2/customers`: Creates a customer record.
- `PATCH/PUT /api/v2/customers/{phone}`: Updates a customer record.
- `DELETE /api/v2/customers/{phone}`: Deletes a customer record.

### Admins
- `POST /api/v2/admins`: Creates an admin record.
- `PATCH/PUT /api/v2/admins/{phone}`: Updates an admin record.
- `DELETE /api/v2/admins/{phone}`: Deletes an admin record.

### Subscription
- `POST /api/v2/customers/{customer_phone}/subscriptions`: Creates a subscription record.

### Houses
- `POST /api/v2/houses`: Creates an house record.
- `PATCH/PUT /api/v2/houses/{id}`: Updates an house record.
- `DELETE /api/v2/houses/{id}`: Deletes an house record.
- `GET /api/v2/houses`: Indexes houses available.
- `GET /api/v2/houses/{id}`: Displays a house record.

### Amounts
- `POST /api/v2/amounts`: Creates an amount record which is the subscription fee.
- `GET /api/v2/amounts`: Indexes amounts available.

### Feedbacks
- `POST /api/v2/feedbacks`: Creates an feedback record which is the subscription fee.
- `GET /api/v2/feedbacks`: Indexes feedbacks available.
- `GET /api/v2/feedbacks/{id}`: 

## Error handling
The API returns HTTP status codes, error messages and success messages in the response.

HTTP Statuses:
* OK: Successful request.
* Created: Resource created successfully.
* Failed: Opertation was not successful.
* Bad Request: Invalid input or missing parameters.
* Unauthorized: Authentication failed or missing API key.
* Forbidden: Access denied.
* Not Found: Resource not found.
* Internal Server Error: Server issues (contact support).

## Response Format
Responses will be in JSON format, following a standard structure with data and meta fields.

Example Response:

```json
   {
     "status_of_opertation": "message here"
   }
```

More on this subject will be included in the swagger documentation of the app.

## Contributors

- [Brolin Remunyanga](https://github.com/brolinr)